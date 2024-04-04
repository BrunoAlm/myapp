import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerasenha/src/preferences/preferences_repository.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_helper.dart';

class DifficultyController extends ChangeNotifier {
  PreferencesRepository preferencesRepository;
  DifficultyController(this.preferencesRepository);

  Future<void> generatePassword(BuildContext context, String level) async {
    final passwordSize = DifficultyHelper.passwordSizes[level]!;
    final generatedPassword = _generatePasswordString(
      passwordSize,
      _getCharacters(level),
    );
    Clipboard.setData(ClipboardData(text: generatedPassword));
    _savePassword(level, generatedPassword);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Senha $level copiada para a área de transferência.'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _savePassword(String level, String generatedPassword) async {
    await preferencesRepository.savePassword(level, generatedPassword);
    notifyListeners();
  }

  String _generatePasswordString(int length, List<String> characters) {
    final random = Random();
    final List<String> password = List.generate(
        length, (index) => characters[random.nextInt(characters.length)]);
    password.shuffle();
    return password.join();
  }

  List<String> _getCharacters(String level) {
    switch (level) {
      case 'Fácil':
        return _lowerCaseLetters + _upperCaseLetters;
      case 'Médio':
        return _lowerCaseLetters +
            _upperCaseLetters +
            _numbers +
            _getSpecialCharactersForMedium();
      case 'Difícil':
        return _lowerCaseLetters +
            _upperCaseLetters +
            _numbers +
            _getSpecialCharactersForHard();
      case 'Dificíssima':
        return _lowerCaseLetters +
            _upperCaseLetters +
            _numbers +
            _getSpecialCharactersForDificissima();
      default:
        return [];
    }
  }

  List<String> _getSpecialCharactersForMedium() {
    final random = Random();
    final List<String> extraSpecialCharacters = [
      _specialCharacters[random.nextInt(_specialCharacters.length)]
    ];
    return _specialCharacters + extraSpecialCharacters;
  }

  List<String> _getSpecialCharactersForHard() {
    final random = Random();
    final List<String> extraSpecialCharacters = List.generate(3,
        (_) => _specialCharacters[random.nextInt(_specialCharacters.length)]);
    return _specialCharacters + extraSpecialCharacters;
  }

  List<String> _getSpecialCharactersForDificissima() {
    final random = Random();
    final List<String> extraSpecialCharacters = List.generate(24,
        (_) => _specialCharacters[random.nextInt(_specialCharacters.length)]);
    return _specialCharacters + extraSpecialCharacters;
  }

  final List<String> _lowerCaseLetters = List.generate(
      26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));
  final List<String> _upperCaseLetters = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  final List<String> _numbers = List.generate(10, (index) => '$index');
  final List<String> _specialCharacters = [
    '!',
    '@',
    '#',
    '\$',
    '%',
    '&',
    '*',
    '+',
    '-',
    '?'
  ];
}
