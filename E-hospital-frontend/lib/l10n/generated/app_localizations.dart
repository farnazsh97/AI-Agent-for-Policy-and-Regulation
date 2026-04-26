import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance Audit Dashboard'**
  String get appTitle;

  /// No description provided for @eHospital.
  ///
  /// In en, this message translates to:
  /// **'COMPLIANCE'**
  String get eHospital;

  /// No description provided for @pharmaceuticals.
  ///
  /// In en, this message translates to:
  /// **'AUDIT SYSTEM'**
  String get pharmaceuticals;

  /// No description provided for @eHospitalPharmaceuticals.
  ///
  /// In en, this message translates to:
  /// **'COMPLIANCE AUDIT SYSTEM'**
  String get eHospitalPharmaceuticals;

  /// No description provided for @complianceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance Audit and Automated Policy Alignment System'**
  String get complianceSubtitle;

  /// No description provided for @complianceAuditDashboard.
  ///
  /// In en, this message translates to:
  /// **'Compliance Audit Dashboard'**
  String get complianceAuditDashboard;

  /// No description provided for @automatedPolicyDescription.
  ///
  /// In en, this message translates to:
  /// **'Automated policy alignment and incident investigation system.'**
  String get automatedPolicyDescription;

  /// No description provided for @databaseConnectedTooltip.
  ///
  /// In en, this message translates to:
  /// **'Database Connected'**
  String get databaseConnectedTooltip;

  /// No description provided for @configureDatabaseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Configure Database'**
  String get configureDatabaseTooltip;

  /// No description provided for @database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database;

  /// No description provided for @hospitalPolicy.
  ///
  /// In en, this message translates to:
  /// **'Organization Policy'**
  String get hospitalPolicy;

  /// No description provided for @hospitalPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload the relevant rulebook or policy document (PDF)'**
  String get hospitalPolicySubtitle;

  /// No description provided for @incidentReport.
  ///
  /// In en, this message translates to:
  /// **'Incident Report'**
  String get incidentReport;

  /// No description provided for @incidentReportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload the factual report of the event (PDF)'**
  String get incidentReportSubtitle;

  /// No description provided for @dropFileHere.
  ///
  /// In en, this message translates to:
  /// **'Drop File Here'**
  String get dropFileHere;

  /// No description provided for @dragDropOrClick.
  ///
  /// In en, this message translates to:
  /// **'Drag & Drop or Click to select PDF'**
  String get dragDropOrClick;

  /// No description provided for @documentReady.
  ///
  /// In en, this message translates to:
  /// **'Document Ready'**
  String get documentReady;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @runComplianceAnalysis.
  ///
  /// In en, this message translates to:
  /// **'RUN COMPLIANCE ANALYSIS'**
  String get runComplianceAnalysis;

  /// No description provided for @agentPipelineExecuting.
  ///
  /// In en, this message translates to:
  /// **'Agent Pipeline Executing'**
  String get agentPipelineExecuting;

  /// No description provided for @processingSemanticLayers.
  ///
  /// In en, this message translates to:
  /// **'Processing semantic layers, assessing severity, and generating recommendations...'**
  String get processingSemanticLayers;

  /// No description provided for @pleaseConfigureDatabase.
  ///
  /// In en, this message translates to:
  /// **'Please configure database connection first.'**
  String get pleaseConfigureDatabase;

  /// No description provided for @pleaseUploadBothFiles.
  ///
  /// In en, this message translates to:
  /// **'Please upload BOTH a Policy PDF and an Incident PDF.'**
  String get pleaseUploadBothFiles;

  /// No description provided for @errorWhileAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Error while analyzing: {error}'**
  String errorWhileAnalyzing(String error);

  /// No description provided for @auditReport.
  ///
  /// In en, this message translates to:
  /// **'Audit Report: {personId}'**
  String auditReport(String personId);

  /// No description provided for @analysisResults.
  ///
  /// In en, this message translates to:
  /// **'Analysis Results'**
  String get analysisResults;

  /// No description provided for @complianceDetermination.
  ///
  /// In en, this message translates to:
  /// **'Final compliance determination based on policy cross-referencing.'**
  String get complianceDetermination;

  /// No description provided for @violationDetected.
  ///
  /// In en, this message translates to:
  /// **'VIOLATION DETECTED'**
  String get violationDetected;

  /// No description provided for @complianceConfirmed.
  ///
  /// In en, this message translates to:
  /// **'COMPLIANCE CONFIRMED'**
  String get complianceConfirmed;

  /// No description provided for @notDetermined.
  ///
  /// In en, this message translates to:
  /// **'NOT DETERMINED'**
  String get notDetermined;

  /// No description provided for @badgeViolation.
  ///
  /// In en, this message translates to:
  /// **'Violation'**
  String get badgeViolation;

  /// No description provided for @badgeNoViolation.
  ///
  /// In en, this message translates to:
  /// **'No Violation'**
  String get badgeNoViolation;

  /// No description provided for @defaultDecisionText.
  ///
  /// In en, this message translates to:
  /// **'The agent has processed the incident and compared it against the provided policy guidelines.'**
  String get defaultDecisionText;

  /// No description provided for @personnelInformation.
  ///
  /// In en, this message translates to:
  /// **'Personnel Information'**
  String get personnelInformation;

  /// No description provided for @personId.
  ///
  /// In en, this message translates to:
  /// **'Person ID'**
  String get personId;

  /// No description provided for @assignedRole.
  ///
  /// In en, this message translates to:
  /// **'Assigned Role'**
  String get assignedRole;

  /// No description provided for @priorHistory.
  ///
  /// In en, this message translates to:
  /// **'Prior History'**
  String get priorHistory;

  /// No description provided for @previousRecords.
  ///
  /// In en, this message translates to:
  /// **'{count} previous records'**
  String previousRecords(int count);

  /// No description provided for @detailedAssessment.
  ///
  /// In en, this message translates to:
  /// **'Detailed Assessment'**
  String get detailedAssessment;

  /// No description provided for @severityLevel.
  ///
  /// In en, this message translates to:
  /// **'Severity Level'**
  String get severityLevel;

  /// No description provided for @recommendedSanction.
  ///
  /// In en, this message translates to:
  /// **'Recommended Sanction'**
  String get recommendedSanction;

  /// No description provided for @actionItems.
  ///
  /// In en, this message translates to:
  /// **'Action Items'**
  String get actionItems;

  /// No description provided for @complianceRationale.
  ///
  /// In en, this message translates to:
  /// **'Compliance Rationale'**
  String get complianceRationale;

  /// No description provided for @policyEvidence.
  ///
  /// In en, this message translates to:
  /// **'Policy Evidence'**
  String get policyEvidence;

  /// No description provided for @hideExcerpts.
  ///
  /// In en, this message translates to:
  /// **'Hide Excerpts'**
  String get hideExcerpts;

  /// No description provided for @viewExcerpts.
  ///
  /// In en, this message translates to:
  /// **'View Excerpts'**
  String get viewExcerpts;

  /// No description provided for @relevanceScore.
  ///
  /// In en, this message translates to:
  /// **'Relevance Score: {score}'**
  String relevanceScore(String score);

  /// No description provided for @databaseConnection.
  ///
  /// In en, this message translates to:
  /// **'Database Connection'**
  String get databaseConnection;

  /// No description provided for @enterDatabaseCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter your database credentials to connect'**
  String get enterDatabaseCredentials;

  /// No description provided for @hostname.
  ///
  /// In en, this message translates to:
  /// **'Hostname'**
  String get hostname;

  /// No description provided for @hostnameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., localhost or 192.168.1.1'**
  String get hostnameHint;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., root or admin'**
  String get usernameHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your database password'**
  String get passwordHint;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @databaseName.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get databaseName;

  /// No description provided for @hostnameRequired.
  ///
  /// In en, this message translates to:
  /// **'Hostname is required'**
  String get hostnameRequired;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @portRequired.
  ///
  /// In en, this message translates to:
  /// **'Port is required'**
  String get portRequired;

  /// No description provided for @invalidPort.
  ///
  /// In en, this message translates to:
  /// **'Invalid port'**
  String get invalidPort;

  /// No description provided for @databaseNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Database name is required'**
  String get databaseNameRequired;

  /// No description provided for @databaseConnectedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Database connected successfully!'**
  String get databaseConnectedSuccess;

  /// No description provided for @databaseConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect to database. Please check credentials.'**
  String get databaseConnectionFailed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
