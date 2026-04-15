import 'package:flutter/material.dart';
import '../l10n/generated/app_localizations.dart';
import '../services/api_service.dart';
import '../services/db_config_storage.dart';

class DatabaseConnectionDialog extends StatefulWidget {
  final Function(bool) onConnectionStatusChanged;

  const DatabaseConnectionDialog({
    super.key,
    required this.onConnectionStatusChanged,
  });

  @override
  State<DatabaseConnectionDialog> createState() =>
      _DatabaseConnectionDialogState();
}

class _DatabaseConnectionDialogState extends State<DatabaseConnectionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _hostnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _portController = TextEditingController(text: '3306');
  final _databaseController = TextEditingController();

  bool _isConnecting = false;
  String? _errorMessage;
  String? _successMessage;
  bool _hasSavedConfig = false;

  @override
  void initState() {
    super.initState();
    _loadSavedConfig();
  }

  /// Pre-fill text fields with previously saved database config.
  Future<void> _loadSavedConfig() async {
    final config = await DbConfigStorage.load();
    if (config != null && mounted) {
      setState(() {
        _hostnameController.text = config.hostname;
        _usernameController.text = config.username;
        _passwordController.text = config.password;
        _portController.text = config.port.toString();
        _databaseController.text = config.databaseName;
        _hasSavedConfig = true;
      });
    }
  }

  @override
  void dispose() {
    _hostnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _portController.dispose();
    _databaseController.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isConnecting = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final port = int.parse(_portController.text);
      final isValid = await EHospitalApiService.validateDatabaseConnection(
        hostname: _hostnameController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        port: port,
        databasename: _databaseController.text,
      );

      if (!mounted) return;

      if (isValid) {
        // Persist credentials on successful connection
        await DbConfigStorage.save(
          hostname: _hostnameController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          port: port,
          databaseName: _databaseController.text,
        );

        setState(() {
          _successMessage = AppLocalizations.of(context)!.databaseConnectedSuccess;
          _errorMessage = null;
        });
        widget.onConnectionStatusChanged(true);
        
        // Close dialog after 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        setState(() {
          _errorMessage = AppLocalizations.of(context)!.databaseConnectionFailed;
          _successMessage = null;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _successMessage = null;
      });
    } finally {
      if (mounted) {
        setState(() => _isConnecting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(Icons.storage, size: 28, color: Color(0xFF1E40AF)),
                    const SizedBox(width: 12),
                    Text(
                      loc.databaseConnection,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  loc.enterDatabaseCredentials,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),

                // Hostname
                TextFormField(
                  controller: _hostnameController,
                  decoration: InputDecoration(
                    labelText: loc.hostname,
                    hintText: loc.hostnameHint,
                    prefixIcon: const Icon(Icons.computer),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return loc.hostnameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Username
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: loc.username,
                    hintText: loc.usernameHint,
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return loc.usernameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: loc.password,
                    hintText: loc.passwordHint,
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return loc.passwordRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Port and Database Name (side by side)
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _portController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: loc.port,
                          prefixIcon: const Icon(Icons.router),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return loc.portRequired;
                          }
                          if (int.tryParse(value!) == null) {
                            return loc.invalidPort;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _databaseController,
                        decoration: InputDecoration(
                          labelText: loc.databaseName,
                          prefixIcon: const Icon(Icons.storage),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return loc.databaseNameRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Success Message
                if (_successMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _successMessage!,
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (_errorMessage != null || _successMessage != null)
                  const SizedBox(height: 16),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_hasSavedConfig)
                      TextButton.icon(
                        onPressed: _isConnecting
                            ? null
                            : () async {
                                await DbConfigStorage.clear();
                                widget.onConnectionStatusChanged(false);
                                setState(() {
                                  _hostnameController.clear();
                                  _usernameController.clear();
                                  _passwordController.clear();
                                  _portController.text = '3306';
                                  _databaseController.clear();
                                  _hasSavedConfig = false;
                                  _successMessage = null;
                                  _errorMessage = null;
                                });
                              },
                        icon: const Icon(Icons.delete_outline, size: 18),
                        label: const Text('Clear Saved'),
                        style: TextButton.styleFrom(foregroundColor: Colors.red.shade600),
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: _isConnecting ? null : () => Navigator.pop(context),
                      child: Text(loc.cancel),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.tonal(
                      onPressed: _isConnecting ? null : _connect,
                      child: _isConnecting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(loc.connect),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
