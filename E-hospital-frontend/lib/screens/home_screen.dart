import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/api_service.dart';
import '../services/db_config_storage.dart';
import 'database_connection_dialog.dart';

class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  final Locale? currentLocale;

  const HomeScreen({
    super.key,
    required this.onLocaleChanged,
    this.currentLocale,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PlatformFile? _policyFile;
  PlatformFile? _incidentFile;
  bool _isRunning = false;
  String? _error;
  bool _isDbConnected = false;

  bool _isDraggingPolicy = false;
  bool _isDraggingIncident = false;

  @override
  void initState() {
    super.initState();
    _tryAutoConnect();
  }

  /// Attempt to connect using saved database config on app start.
  Future<void> _tryAutoConnect() async {
    final config = await DbConfigStorage.load();
    if (config == null) return;

    try {
      final isValid = await EHospitalApiService.validateDatabaseConnection(
        hostname: config.hostname,
        username: config.username,
        password: config.password,
        port: config.port,
        databasename: config.databaseName,
      );
      if (mounted && isValid) {
        setState(() => _isDbConnected = true);
      }
    } catch (_) {
      // Saved config is stale or server unreachable; user can reconnect manually.
    }
  }

  Future<void> _pickFile({required bool isPolicy}) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      _setFile(result.files.first, isPolicy);
    }
  }

  void _setFile(PlatformFile file, bool isPolicy) {
    setState(() {
      if (isPolicy) {
        _policyFile = file;
      } else {
        _incidentFile = file;
      }
    });
  }

  Future<void> _analyze() async {
    final loc = AppLocalizations.of(context)!;
    if (!_isDbConnected) {
      setState(() => _error = loc.pleaseConfigureDatabase);
      return;
    }

    if (_policyFile?.bytes == null || _incidentFile?.bytes == null) {
      setState(() => _error = loc.pleaseUploadBothFiles);
      return;
    }

    setState(() {
      _isRunning = true;
      _error = null;
    });

    try {
      final data = await EHospitalApiService.analyze(
        policyBytes: _policyFile!.bytes!,
        policyName: _policyFile!.name,
        incidentBytes: _incidentFile!.bytes!,
        incidentName: _incidentFile!.name,
        language: (widget.currentLocale ?? const Locale('en')).languageCode,
      );

      if (!mounted) return;
      Navigator.pushNamed(context, '/results', arguments: data);
    } catch (e) {
      setState(() => _error = AppLocalizations.of(context)!.errorWhileAnalyzing(e.toString()));
    } finally {
      if (mounted) setState(() => _isRunning = false);
    }
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
                  const SizedBox(height: 32),
                  if (_error != null) ...[
                    _errorBanner(_error!),
                    const SizedBox(height: 24),
                  ],
                  _buildUploadSection(),
                  const SizedBox(height: 40),
                  _buildActionSection(),
                  if (_isRunning) ...[
                    const SizedBox(height: 32),
                    _analyzingBanner(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTopNav() {
    final loc = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          const Icon(Icons.medical_services, color: Color(0xFF1E40AF), size: 28),
          const SizedBox(width: 12),
          Text(
            loc.eHospital,
            style: TextStyle(
              color: Color(0xFF1E40AF),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            loc.pharmaceuticals,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey.shade200, height: 1),
      ),
      actions: [
        // Language Selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              value: widget.currentLocale ?? const Locale('en'),
              icon: const Icon(Icons.language, color: Color(0xFF1E40AF)),
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
              onChanged: (locale) {
                if (locale != null) {
                  widget.onLocaleChanged(locale);
                }
              },
            ),
          ),
        ),
        // Database Connection Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Tooltip(
            message: _isDbConnected ? loc.databaseConnectedTooltip : loc.configureDatabaseTooltip,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DatabaseConnectionDialog(
                    onConnectionStatusChanged: (isConnected) {
                      setState(() => _isDbConnected = isConnected);
                    },
                  ),
                );
              },
              icon: Icon(
                _isDbConnected ? Icons.storage : Icons.storage_outlined,
                size: 18,
              ),
              label: Text(loc.database),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDbConnected
                    ? Colors.green.shade600
                    : Colors.grey.shade400,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: Icon(Icons.person_outline, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Image Section
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Container(
                height: 340,
                width: double.infinity,
                color: const Color(0xFFE8EEF8),
                child: Image.asset(
                  'assets/images/loginhome.png',
                  height: 340,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 340,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF1E40AF).withOpacity(0.8),
                      const Color(0xFF1E40AF).withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.medical_services, color: Colors.white, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      loc.eHospitalPharmaceuticals,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.complianceSubtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          loc.complianceAuditDashboard,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          loc.automatedPolicyDescription,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    final loc = AppLocalizations.of(context)!;
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWide = constraints.maxWidth > 700;
      return Flex(
        direction: isWide ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isWide ? 1 : 0,
            child: _uploadCard(
              title: loc.hospitalPolicy,
              subtitle: loc.hospitalPolicySubtitle,
              file: _policyFile,
              isDragging: _isDraggingPolicy,
              onDragEntered: () => setState(() => _isDraggingPolicy = true),
              onDragExited: () => setState(() => _isDraggingPolicy = false),
              onFileDropped: (file) => _setFile(file, true),
              onPick: () => _pickFile(isPolicy: true),
              onClear: () => setState(() => _policyFile = null),
            ),
          ),
          SizedBox(width: isWide ? 24 : 0, height: isWide ? 0 : 24),
          Expanded(
            flex: isWide ? 1 : 0,
            child: _uploadCard(
              title: loc.incidentReport,
              subtitle: loc.incidentReportSubtitle,
              file: _incidentFile,
              isDragging: _isDraggingIncident,
              onDragEntered: () => setState(() => _isDraggingIncident = true),
              onDragExited: () => setState(() => _isDraggingIncident = false),
              onFileDropped: (file) => _setFile(file, false),
              onPick: () => _pickFile(isPolicy: false),
              onClear: () => setState(() => _incidentFile = null),
            ),
          ),
        ],
      );
    });
  }

  Widget _uploadCard({
    required String title,
    required String subtitle,
    required PlatformFile? file,
    required bool isDragging,
    required VoidCallback onDragEntered,
    required VoidCallback onDragExited,
    required Function(PlatformFile) onFileDropped,
    required VoidCallback onPick,
    required VoidCallback onClear,
  }) {
    return DropTarget(
      onDragDone: (detail) async {
        if (detail.files.isNotEmpty) {
          final file = detail.files.first;
          final bytes = await file.readAsBytes();
          onFileDropped(PlatformFile(
            name: file.name,
            size: bytes.length,
            bytes: bytes,
          ));
        }
      },
      onDragEntered: (detail) => onDragEntered(),
      onDragExited: (detail) => onDragExited(),
      child: Card(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDragging ? const Color(0xFFEFF6FF) : Colors.white,
            border: Border.all(
              color: isDragging ? const Color(0xFF1E40AF) : const Color(0xFFE2E8F0),
              width: isDragging ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.upload_file, color: Color(0xFF1E40AF)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: onPick,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200, width: 2, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isDragging ? Icons.add_circle_outline : Icons.cloud_upload_outlined,
                        size: 40,
                        color: isDragging ? const Color(0xFF1E40AF) : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isDragging
                            ? AppLocalizations.of(context)!.dropFileHere
                            : (file == null ? AppLocalizations.of(context)!.dragDropOrClick : file.name),
                        style: TextStyle(
                          color: (file == null && !isDragging) ? Colors.grey.shade600 : const Color(0xFF1E40AF),
                          fontWeight: (file == null && !isDragging) ? FontWeight.normal : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (file != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.documentReady, style: const TextStyle(color: Colors.green, fontSize: 13)),
                    const Spacer(),
                    TextButton(
                      onPressed: onClear,
                      child: Text(AppLocalizations.of(context)!.remove, style: const TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionSection() {
    return Center(
      child: SizedBox(
        width: 400,
        height: 56,
        child: FilledButton(
          onPressed: _isRunning ? null : _analyze,
          child: _isRunning
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  AppLocalizations.of(context)!.runComplianceAnalysis,
                  style: const TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget _analyzingBanner() {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Color(0xFF1E40AF)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.agentPipelineExecuting,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E40AF)),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.processingSemanticLayers,
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorBanner(String msg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(msg, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
