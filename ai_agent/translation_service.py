"""
Isolated translation service for converting AI-generated results
into Arabic or French. Uses OpenAI LLM for high-quality translation.

This module is completely separate from the main agent pipeline.
It only operates on the final result AFTER the full analysis is complete.
"""

import json
import os
import re

from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

LLM_MODEL = "gpt-4o-mini"

SUPPORTED_LANGUAGES = {
    "en": "English",
    "ar": "Arabic",
    "fr": "French",
}


def _extract_json_from_response(raw: str) -> dict | None:
    """Parse JSON from LLM response, handling markdown code fences."""
    raw = raw.strip()
    # Strip markdown code fences if present
    if raw.startswith("```"):
        lines = raw.split("\n")
        end = len(lines) - 1 if lines[-1].strip().startswith("```") else len(lines)
        raw = "\n".join(lines[1:end])
    match = re.search(r"\{.*\}", raw, flags=re.DOTALL)
    if not match:
        return None
    try:
        return json.loads(match.group(0))
    except Exception:
        return None


def translate_result(result: dict, target_language: str) -> dict:
    """
    Translate the final AI-generated result dict into the target language.

    - If target_language is 'en' or unsupported, returns the original unchanged.
    - Only translates human-readable text fields.
    - Preserves structure, technical fields, IDs, scores, and chunks.
    """
    if target_language not in SUPPORTED_LANGUAGES or target_language == "en":
        return result

    lang_name = SUPPORTED_LANGUAGES[target_language]

    # Extract only the translatable fields
    # NOTE: "decision" is intentionally excluded — it is a technical label
    # ("Violation" / "No Violation") used by the frontend for color/icon logic.
    fields_to_translate = {
        "report": result.get("report", ""),
        "final_text": result.get("final_text", ""),
        "severity_reason": (
            result.get("severity", {}).get("reason", "")
            if isinstance(result.get("severity"), dict)
            else ""
        ),
        "sanction_recommended_action": (
            result.get("sanction", {}).get("recommended_action", "")
            if isinstance(result.get("sanction"), dict)
            else ""
        ),
        "sanction_reason": (
            result.get("sanction", {}).get("reason", "")
            if isinstance(result.get("sanction"), dict)
            else ""
        ),
    }

    # Skip if nothing to translate
    if not any(v.strip() for v in fields_to_translate.values()):
        return result

    prompt = f"""You are a professional medical/legal translator.

Translate the following text fields from English to {lang_name}.

STRICT RULES:
- Translate ONLY the human-readable text content.
- Preserve the EXACT meaning — do not add, remove, or change any information.
- Preserve all formatting: headings, bullets, numbering, spacing, section order.
- Do NOT translate: person IDs, technical identifiers, chunk references, citation markers like [Chunk X].
- Do NOT summarize or condense — translate everything faithfully.
- The translation must be natural, clear, and professional in {lang_name}.
- Return ONLY valid JSON with exactly the same keys shown below.

Fields to translate:
{json.dumps(fields_to_translate, ensure_ascii=False, indent=2)}

Return ONLY a valid JSON object with exactly these keys:
"report", "final_text", "severity_reason", "sanction_recommended_action", "sanction_reason"
""".strip()

    try:
        response = client.responses.create(
            model=LLM_MODEL,
            temperature=0,
            input=prompt,
        )

        raw = (response.output_text or "").strip()
        translated = _extract_json_from_response(raw)

        if not translated:
            print("Translation: could not parse LLM JSON, returning original.")
            return result

        # Build translated result — shallow copy original, update only translated fields
        translated_result = dict(result)

        if translated.get("report"):
            translated_result["report"] = translated["report"]
        if translated.get("final_text"):
            translated_result["final_text"] = translated["final_text"]

        # Update nested severity reason
        if isinstance(translated_result.get("severity"), dict) and translated.get("severity_reason"):
            translated_result["severity"] = dict(translated_result["severity"])
            translated_result["severity"]["reason"] = translated["severity_reason"]

        # Update nested sanction fields
        if isinstance(translated_result.get("sanction"), dict):
            translated_result["sanction"] = dict(translated_result["sanction"])
            if translated.get("sanction_recommended_action"):
                translated_result["sanction"]["recommended_action"] = translated["sanction_recommended_action"]
            if translated.get("sanction_reason"):
                translated_result["sanction"]["reason"] = translated["sanction_reason"]

        return translated_result

    except Exception as e:
        print(f"Translation failed, returning original: {e}")
        return result
