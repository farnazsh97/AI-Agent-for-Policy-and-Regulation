import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';

class ResultsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ResultsScreen({super.key, required this.data});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _showChunks = false;

  Map<String, dynamic> get d => widget.data;
  String get decision => (d['decision'] ?? '').toString();
  String get report => (d['report'] ?? '').toString();
  String get personId => (d['person_id'] ?? 'unknown').toString();
  String get personRole => (d['person_role'] ?? 'unknown').toString();
  String get finalText => (d['final_text'] ?? '').toString();
  int get previousViolations => (d['previous_violations'] ?? 0) as int;
  List<dynamic> get chunks => (d['top_chunks'] ?? []) as List<dynamic>;

  String get severity => _nested('severity', 'severity');
  String get severityReason => _nested('severity', 'reason');
  String get sanctionLevel => _nested('sanction', 'sanction_level');
  String get recommendedAction => _nested('sanction', 'recommended_action');

  String _nested(String outer, String inner) {
    final m = d[outer];
    if (m is Map) return (m[inner] ?? '').toString();
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTopNav(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildDecisionHero(),
                  const SizedBox(height: 24),
                  _buildMainGrid(),
                  const SizedBox(height: 24),
                  _buildEvidenceSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTopNav() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E40AF)),
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
      title: Text(
        AppLocalizations.of(context)!.auditReport(personId),
        style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
    );
  }

  Widget _buildHeader() {
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.analysisResults, style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 4),
            Text(loc.complianceDetermination,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        _statusBadge(decision, displayLabel: _localizedDecision()),
      ],
    );
  }

  String _localizedDecision() {
    final loc = AppLocalizations.of(context)!;
    final bool isViolation = decision.toLowerCase().contains('violation') && !decision.toLowerCase().contains('no');
    if (isViolation) return loc.badgeViolation;
    if (decision.toLowerCase().contains('no')) return loc.badgeNoViolation;
    return loc.notDetermined;
  }

  Widget _buildDecisionHero() {
    final loc = AppLocalizations.of(context)!;
    final bool isViolation = decision.toLowerCase().contains('violation') && !decision.toLowerCase().contains('no');
    final Color baseColor = isViolation ? Colors.red : (decision.toLowerCase().contains('no') ? Colors.green : Colors.blueGrey);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: baseColor, width: 6)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: baseColor.withOpacity(0.1),
              child: Icon(isViolation ? Icons.gavel : Icons.check_circle, color: baseColor, size: 32),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isViolation ? loc.violationDetected : (decision.isEmpty ? loc.notDetermined : loc.complianceConfirmed),
                    style: TextStyle(color: baseColor, fontWeight: FontWeight.w900, letterSpacing: 1.2, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    finalText.isNotEmpty ? finalText : loc.defaultDecisionText,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainGrid() {
    final loc = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWide = constraints.maxWidth > 800;
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _infoCard(
                  title: loc.personnelInformation,
                  icon: Icons.person_search,
                  content: Column(
                    children: [
                      _dataRow(loc.personId, personId),
                      _dataRow(loc.assignedRole, personRole),
                      _dataRow(loc.priorHistory, loc.previousRecords(previousViolations)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: _infoCard(
                  title: loc.detailedAssessment,
                  icon: Icons.analytics_outlined,
                  content: Column(
                    children: [
                      _dataRow(loc.severityLevel, severity, color: _getSeverityColor(severity)),
                      _dataRow(loc.recommendedSanction, sanctionLevel),
                      _dataRow(loc.actionItems, recommendedAction),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _infoCard(
            title: loc.complianceRationale,
            icon: Icons.description_outlined,
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SelectableText(report, style: const TextStyle(height: 1.6, fontSize: 15)),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildEvidenceSection() {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(loc.policyEvidence, style: Theme.of(context).textTheme.headlineMedium),
            const Spacer(),
            TextButton.icon(
              onPressed: () => setState(() => _showChunks = !_showChunks),
              icon: Icon(_showChunks ? Icons.expand_less : Icons.expand_more),
              label: Text(_showChunks ? loc.hideExcerpts : loc.viewExcerpts),
            ),
          ],
        ),
        if (_showChunks) ...[
          const SizedBox(height: 16),
          ...chunks.map((c) => _chunkItem(c)).toList(),
        ],
      ],
    );
  }

  Widget _infoCard({required String title, required IconData icon, required Widget content}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF1E40AF)),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const Divider(height: 32),
            content,
          ],
        ),
      ),
    );
  }

  Widget _dataRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 160, child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14))),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color ?? const Color(0xFF1E293B),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chunkItem(Map<String, dynamic> c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        color: const Color(0xFFF1F5F9),
        borderOnForeground: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.format_quote, size: 16, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.relevanceScore(c['score'].toString()), style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
                ],
              ),
              const SizedBox(height: 8),
              SelectableText(c['chunk'].toString(), style: const TextStyle(fontSize: 14, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String label, {String? displayLabel}) {
    bool isViolation = label.toLowerCase().contains('violation') && !label.toLowerCase().contains('no');
    Color color = isViolation ? Colors.red : (label.toLowerCase().contains('no') ? Colors.green : Colors.grey);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        (displayLabel ?? label).toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1),
      ),
    );
  }

  Color _getSeverityColor(String sev) {
    sev = sev.toLowerCase();
    if (sev.contains('high')) return Colors.red.shade700;
    if (sev.contains('medium')) return Colors.orange.shade700;
    if (sev.contains('low')) return Colors.green.shade700;
    return const Color(0xFF1E293B);
  }
}
