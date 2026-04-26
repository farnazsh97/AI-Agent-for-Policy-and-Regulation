// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Compliance Audit Dashboard';

  @override
  String get eHospital => 'COMPLIANCE';

  @override
  String get pharmaceuticals => 'AUDIT SYSTEM';

  @override
  String get eHospitalPharmaceuticals => 'COMPLIANCE AUDIT SYSTEM';

  @override
  String get complianceSubtitle =>
      'Compliance Audit and Automated Policy Alignment System';

  @override
  String get complianceAuditDashboard => 'Compliance Audit Dashboard';

  @override
  String get automatedPolicyDescription =>
      'Automated policy alignment and incident investigation system.';

  @override
  String get databaseConnectedTooltip => 'Database Connected';

  @override
  String get configureDatabaseTooltip => 'Configure Database';

  @override
  String get database => 'Database';

  @override
  String get hospitalPolicy => 'Organization Policy';

  @override
  String get hospitalPolicySubtitle =>
      'Upload the relevant rulebook or policy document (PDF)';

  @override
  String get incidentReport => 'Incident Report';

  @override
  String get incidentReportSubtitle =>
      'Upload the factual report of the event (PDF)';

  @override
  String get dropFileHere => 'Drop File Here';

  @override
  String get dragDropOrClick => 'Drag & Drop or Click to select PDF';

  @override
  String get documentReady => 'Document Ready';

  @override
  String get remove => 'Remove';

  @override
  String get runComplianceAnalysis => 'RUN COMPLIANCE ANALYSIS';

  @override
  String get agentPipelineExecuting => 'Agent Pipeline Executing';

  @override
  String get processingSemanticLayers =>
      'Processing semantic layers, assessing severity, and generating recommendations...';

  @override
  String get pleaseConfigureDatabase =>
      'Please configure database connection first.';

  @override
  String get pleaseUploadBothFiles =>
      'Please upload BOTH a Policy PDF and an Incident PDF.';

  @override
  String errorWhileAnalyzing(String error) {
    return 'Error while analyzing: $error';
  }

  @override
  String auditReport(String personId) {
    return 'Audit Report: $personId';
  }

  @override
  String get analysisResults => 'Analysis Results';

  @override
  String get complianceDetermination =>
      'Final compliance determination based on policy cross-referencing.';

  @override
  String get violationDetected => 'VIOLATION DETECTED';

  @override
  String get complianceConfirmed => 'COMPLIANCE CONFIRMED';

  @override
  String get notDetermined => 'NOT DETERMINED';

  @override
  String get badgeViolation => 'Violation';

  @override
  String get badgeNoViolation => 'No Violation';

  @override
  String get defaultDecisionText =>
      'The agent has processed the incident and compared it against the provided policy guidelines.';

  @override
  String get personnelInformation => 'Personnel Information';

  @override
  String get personId => 'Person ID';

  @override
  String get assignedRole => 'Assigned Role';

  @override
  String get priorHistory => 'Prior History';

  @override
  String previousRecords(int count) {
    return '$count previous records';
  }

  @override
  String get detailedAssessment => 'Detailed Assessment';

  @override
  String get severityLevel => 'Severity Level';

  @override
  String get recommendedSanction => 'Recommended Sanction';

  @override
  String get actionItems => 'Action Items';

  @override
  String get complianceRationale => 'Compliance Rationale';

  @override
  String get policyEvidence => 'Policy Evidence';

  @override
  String get hideExcerpts => 'Hide Excerpts';

  @override
  String get viewExcerpts => 'View Excerpts';

  @override
  String relevanceScore(String score) {
    return 'Relevance Score: $score';
  }

  @override
  String get databaseConnection => 'Database Connection';

  @override
  String get enterDatabaseCredentials =>
      'Enter your database credentials to connect';

  @override
  String get hostname => 'Hostname';

  @override
  String get hostnameHint => 'e.g., localhost or 192.168.1.1';

  @override
  String get username => 'Username';

  @override
  String get usernameHint => 'e.g., root or admin';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your database password';

  @override
  String get port => 'Port';

  @override
  String get databaseName => 'Database';

  @override
  String get hostnameRequired => 'Hostname is required';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get portRequired => 'Port is required';

  @override
  String get invalidPort => 'Invalid port';

  @override
  String get databaseNameRequired => 'Database name is required';

  @override
  String get databaseConnectedSuccess => 'Database connected successfully!';

  @override
  String get databaseConnectionFailed =>
      'Failed to connect to database. Please check credentials.';

  @override
  String get cancel => 'Cancel';

  @override
  String get connect => 'Connect';

  @override
  String get language => 'Language';
}
