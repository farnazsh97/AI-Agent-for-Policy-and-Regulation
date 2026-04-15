import 'package:shared_preferences/shared_preferences.dart';

/// Handles persisting and retrieving database connection configuration.
/// Credentials are stored locally using SharedPreferences.
class DbConfigStorage {
  static const _keyHostname = 'db_hostname';
  static const _keyUsername = 'db_username';
  static const _keyPassword = 'db_password';
  static const _keyPort = 'db_port';
  static const _keyDatabaseName = 'db_database_name';

  /// Save all database connection fields.
  static Future<void> save({
    required String hostname,
    required String username,
    required String password,
    required int port,
    required String databaseName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyHostname, hostname);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
    await prefs.setInt(_keyPort, port);
    await prefs.setString(_keyDatabaseName, databaseName);
  }

  /// Load saved config. Returns null if any required field is missing.
  static Future<DbConfig?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final hostname = prefs.getString(_keyHostname);
    final username = prefs.getString(_keyUsername);
    final password = prefs.getString(_keyPassword);
    final port = prefs.getInt(_keyPort);
    final databaseName = prefs.getString(_keyDatabaseName);

    if (hostname == null ||
        hostname.isEmpty ||
        username == null ||
        username.isEmpty ||
        password == null ||
        password.isEmpty ||
        port == null ||
        databaseName == null ||
        databaseName.isEmpty) {
      return null;
    }

    return DbConfig(
      hostname: hostname,
      username: username,
      password: password,
      port: port,
      databaseName: databaseName,
    );
  }

  /// Clear all saved database config.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHostname);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyPassword);
    await prefs.remove(_keyPort);
    await prefs.remove(_keyDatabaseName);
  }
}

/// Simple data class for database connection config.
class DbConfig {
  final String hostname;
  final String username;
  final String password;
  final int port;
  final String databaseName;

  const DbConfig({
    required this.hostname,
    required this.username,
    required this.password,
    required this.port,
    required this.databaseName,
  });
}
