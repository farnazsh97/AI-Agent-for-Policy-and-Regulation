// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tableau de bord d\'audit de conformité';

  @override
  String get eHospital => 'CONFORMITÉ';

  @override
  String get pharmaceuticals => 'SYSTÈME D\'AUDIT';

  @override
  String get eHospitalPharmaceuticals => 'SYSTÈME D\'AUDIT DE CONFORMITÉ';

  @override
  String get complianceSubtitle =>
      'Système d\'audit de conformité et d\'alignement automatisé des politiques';

  @override
  String get complianceAuditDashboard =>
      'Tableau de bord d\'audit de conformité';

  @override
  String get automatedPolicyDescription =>
      'Système automatisé d\'alignement des politiques et d\'enquête sur les incidents.';

  @override
  String get databaseConnectedTooltip => 'Base de données connectée';

  @override
  String get configureDatabaseTooltip => 'Configurer la base de données';

  @override
  String get database => 'Base de données';

  @override
  String get hospitalPolicy => 'Politique de l\'organisation';

  @override
  String get hospitalPolicySubtitle =>
      'Téléchargez le règlement ou le document de politique pertinent (PDF)';

  @override
  String get incidentReport => 'Rapport d\'incident';

  @override
  String get incidentReportSubtitle =>
      'Téléchargez le rapport factuel de l\'événement (PDF)';

  @override
  String get dropFileHere => 'Déposez le fichier ici';

  @override
  String get dragDropOrClick =>
      'Glissez-déposez ou cliquez pour sélectionner un PDF';

  @override
  String get documentReady => 'Document prêt';

  @override
  String get remove => 'Supprimer';

  @override
  String get runComplianceAnalysis => 'LANCER L\'ANALYSE DE CONFORMITÉ';

  @override
  String get agentPipelineExecuting =>
      'Pipeline d\'agent en cours d\'exécution';

  @override
  String get processingSemanticLayers =>
      'Traitement des couches sémantiques, évaluation de la gravité et génération de recommandations...';

  @override
  String get pleaseConfigureDatabase =>
      'Veuillez d\'abord configurer la connexion à la base de données.';

  @override
  String get pleaseUploadBothFiles =>
      'Veuillez télécharger les DEUX fichiers PDF : politique et incident.';

  @override
  String errorWhileAnalyzing(String error) {
    return 'Erreur lors de l\'analyse : $error';
  }

  @override
  String auditReport(String personId) {
    return 'Rapport d\'audit : $personId';
  }

  @override
  String get analysisResults => 'Résultats de l\'analyse';

  @override
  String get complianceDetermination =>
      'Détermination finale de conformité basée sur le croisement des politiques.';

  @override
  String get violationDetected => 'VIOLATION DÉTECTÉE';

  @override
  String get complianceConfirmed => 'CONFORMITÉ CONFIRMÉE';

  @override
  String get notDetermined => 'NON DÉTERMINÉ';

  @override
  String get badgeViolation => 'Violation';

  @override
  String get badgeNoViolation => 'Aucune violation';

  @override
  String get defaultDecisionText =>
      'L\'agent a traité l\'incident et l\'a comparé aux directives de la politique fournies.';

  @override
  String get personnelInformation => 'Informations sur le personnel';

  @override
  String get personId => 'ID de la personne';

  @override
  String get assignedRole => 'Rôle attribué';

  @override
  String get priorHistory => 'Historique antérieur';

  @override
  String previousRecords(int count) {
    return '$count enregistrements précédents';
  }

  @override
  String get detailedAssessment => 'Évaluation détaillée';

  @override
  String get severityLevel => 'Niveau de gravité';

  @override
  String get recommendedSanction => 'Sanction recommandée';

  @override
  String get actionItems => 'Actions à entreprendre';

  @override
  String get complianceRationale => 'Justification de conformité';

  @override
  String get policyEvidence => 'Preuves de la politique';

  @override
  String get hideExcerpts => 'Masquer les extraits';

  @override
  String get viewExcerpts => 'Voir les extraits';

  @override
  String relevanceScore(String score) {
    return 'Score de pertinence : $score';
  }

  @override
  String get databaseConnection => 'Connexion à la base de données';

  @override
  String get enterDatabaseCredentials =>
      'Entrez vos identifiants de base de données pour vous connecter';

  @override
  String get hostname => 'Nom d\'hôte';

  @override
  String get hostnameHint => 'ex. : localhost ou 192.168.1.1';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get usernameHint => 'ex. : root ou admin';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordHint => 'Entrez votre mot de passe de base de données';

  @override
  String get port => 'Port';

  @override
  String get databaseName => 'Base de données';

  @override
  String get hostnameRequired => 'Le nom d\'hôte est requis';

  @override
  String get usernameRequired => 'Le nom d\'utilisateur est requis';

  @override
  String get passwordRequired => 'Le mot de passe est requis';

  @override
  String get portRequired => 'Le port est requis';

  @override
  String get invalidPort => 'Port invalide';

  @override
  String get databaseNameRequired => 'Le nom de la base de données est requis';

  @override
  String get databaseConnectedSuccess =>
      'Base de données connectée avec succès !';

  @override
  String get databaseConnectionFailed =>
      'Échec de la connexion à la base de données. Veuillez vérifier vos identifiants.';

  @override
  String get cancel => 'Annuler';

  @override
  String get connect => 'Connecter';

  @override
  String get language => 'Langue';
}
