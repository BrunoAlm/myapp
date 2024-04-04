import 'package:gerasenha/src/preferences/password_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  Future<void> savePassword(String key, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> passwords = prefs.getStringList(key) ?? [];
    passwords.add(
        '$password|${DateTime.now().toIso8601String()}'); // Concatenar senha e data
    await prefs.setStringList(key, passwords);
  }

  Future<List<PasswordEntity>> getPasswords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<PasswordEntity> passwordList = [];
    for (final key in prefs.getKeys()) {
      final List<String> passwords = prefs.getStringList(key) ?? [];
      for (final passwordWithDate in passwords) {
        final List<String> parts =
            passwordWithDate.split('|'); // Separar senha e data
        if (parts.length == 2) {
          final password = parts[0];
          final createdAt = DateTime.parse(parts[1]);
          passwordList.add(PasswordEntity(
            level: key,
            password: password,
            createdAt: createdAt,
          ));
        }
      }
    }
    return passwordList;
  }
}
