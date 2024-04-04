import 'package:flutter/material.dart';
import 'package:gerasenha/src/preferences/password_entity.dart';
import 'package:gerasenha/src/preferences/preferences_repository.dart';

class PasswordHistoryController extends ChangeNotifier {
  final PreferencesRepository preferencesRepository;
  PasswordHistoryController(this.preferencesRepository);

  List<PasswordEntity> passwords = [];

  Future<void> getPasswordHistory() async {
    passwords = await preferencesRepository.getPasswords();
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }
}
