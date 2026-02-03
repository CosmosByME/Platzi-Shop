import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { accessToken, refreshToken }

class LocalService {
  static Future<void> store(StorageKey key, String data) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(key.name, data);
  }

  static Future<String?> read(StorageKey key) async {
    final prefs = SharedPreferencesAsync();
    return prefs.getString(key.name);
  }

  static Future<void> remove(StorageKey key) async {
    final prefs = SharedPreferencesAsync();
    await prefs.remove(key.name);
  }
}
