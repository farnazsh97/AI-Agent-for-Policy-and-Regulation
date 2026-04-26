// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'لوحة تدقيق الامتثال';

  @override
  String get eHospital => 'الامتثال';

  @override
  String get pharmaceuticals => 'نظام التدقيق';

  @override
  String get eHospitalPharmaceuticals => 'نظام تدقيق الامتثال';

  @override
  String get complianceSubtitle => 'نظام تدقيق الامتثال ومواءمة السياسات الآلي';

  @override
  String get complianceAuditDashboard => 'لوحة تدقيق الامتثال';

  @override
  String get automatedPolicyDescription =>
      'نظام مواءمة السياسات الآلي والتحقيق في الحوادث.';

  @override
  String get databaseConnectedTooltip => 'قاعدة البيانات متصلة';

  @override
  String get configureDatabaseTooltip => 'تكوين قاعدة البيانات';

  @override
  String get database => 'قاعدة البيانات';

  @override
  String get hospitalPolicy => 'سياسة المؤسسة';

  @override
  String get hospitalPolicySubtitle =>
      'قم بتحميل كتاب القواعد أو وثيقة السياسة ذات الصلة (PDF)';

  @override
  String get incidentReport => 'تقرير الحادث';

  @override
  String get incidentReportSubtitle => 'قم بتحميل التقرير الواقعي للحدث (PDF)';

  @override
  String get dropFileHere => 'أفلت الملف هنا';

  @override
  String get dragDropOrClick => 'اسحب وأفلت أو انقر لاختيار ملف PDF';

  @override
  String get documentReady => 'المستند جاهز';

  @override
  String get remove => 'إزالة';

  @override
  String get runComplianceAnalysis => 'تشغيل تحليل الامتثال';

  @override
  String get agentPipelineExecuting => 'جارٍ تنفيذ خط أنابيب الوكيل';

  @override
  String get processingSemanticLayers =>
      'معالجة الطبقات الدلالية وتقييم الخطورة وإنشاء التوصيات...';

  @override
  String get pleaseConfigureDatabase =>
      'يرجى تكوين اتصال قاعدة البيانات أولاً.';

  @override
  String get pleaseUploadBothFiles =>
      'يرجى تحميل ملف PDF للسياسة وملف PDF للحادث معاً.';

  @override
  String errorWhileAnalyzing(String error) {
    return 'خطأ أثناء التحليل: $error';
  }

  @override
  String auditReport(String personId) {
    return 'تقرير التدقيق: $personId';
  }

  @override
  String get analysisResults => 'نتائج التحليل';

  @override
  String get complianceDetermination =>
      'تحديد الامتثال النهائي بناءً على مراجعة السياسات المتقاطعة.';

  @override
  String get violationDetected => 'تم اكتشاف مخالفة';

  @override
  String get complianceConfirmed => 'تم تأكيد الامتثال';

  @override
  String get notDetermined => 'غير محدد';

  @override
  String get badgeViolation => 'مخالفة';

  @override
  String get badgeNoViolation => 'لا مخالفة';

  @override
  String get defaultDecisionText =>
      'قام الوكيل بمعالجة الحادث ومقارنته بإرشادات السياسة المقدمة.';

  @override
  String get personnelInformation => 'معلومات الموظف';

  @override
  String get personId => 'رقم الشخص';

  @override
  String get assignedRole => 'الدور المحدد';

  @override
  String get priorHistory => 'السجل السابق';

  @override
  String previousRecords(int count) {
    return '$count سجلات سابقة';
  }

  @override
  String get detailedAssessment => 'التقييم التفصيلي';

  @override
  String get severityLevel => 'مستوى الخطورة';

  @override
  String get recommendedSanction => 'العقوبة الموصى بها';

  @override
  String get actionItems => 'بنود العمل';

  @override
  String get complianceRationale => 'مبررات الامتثال';

  @override
  String get policyEvidence => 'أدلة السياسة';

  @override
  String get hideExcerpts => 'إخفاء المقتطفات';

  @override
  String get viewExcerpts => 'عرض المقتطفات';

  @override
  String relevanceScore(String score) {
    return 'درجة الصلة: $score';
  }

  @override
  String get databaseConnection => 'اتصال قاعدة البيانات';

  @override
  String get enterDatabaseCredentials =>
      'أدخل بيانات اعتماد قاعدة البيانات للاتصال';

  @override
  String get hostname => 'اسم المضيف';

  @override
  String get hostnameHint => 'مثال: localhost أو 192.168.1.1';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get usernameHint => 'مثال: root أو admin';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة مرور قاعدة البيانات';

  @override
  String get port => 'المنفذ';

  @override
  String get databaseName => 'قاعدة البيانات';

  @override
  String get hostnameRequired => 'اسم المضيف مطلوب';

  @override
  String get usernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get portRequired => 'المنفذ مطلوب';

  @override
  String get invalidPort => 'منفذ غير صالح';

  @override
  String get databaseNameRequired => 'اسم قاعدة البيانات مطلوب';

  @override
  String get databaseConnectedSuccess => 'تم الاتصال بقاعدة البيانات بنجاح!';

  @override
  String get databaseConnectionFailed =>
      'فشل الاتصال بقاعدة البيانات. يرجى التحقق من بيانات الاعتماد.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get connect => 'اتصال';

  @override
  String get language => 'اللغة';
}
