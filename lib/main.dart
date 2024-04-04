import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de senhas',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatelessWidget {
  PasswordGenerator({super.key});

  final List<String> levels = ['Fácil', 'Médio', 'Difícil', 'Dificíssima'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de senhas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: levels
              .map(
                (level) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      generatePassword(context, level);
                    },
                    child: Text(level),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void generatePassword(BuildContext context, String level) {
    final passwordSize = _passwordSizes[level]!;
    final generatedPassword =
        _generatePasswordString(passwordSize, _getCharacters(level));
    Clipboard.setData(ClipboardData(text: generatedPassword));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password copied to clipboard: $generatedPassword'),
      ),
    );
  }

  String _generatePasswordString(int length, List<String> characters) {
    final random = Random();
    final List<String> password = [];

    for (var i = 0; i < length; i++) {
      password.add(characters[random.nextInt(characters.length)]);
    }

    password.shuffle();
    return password.join();
  }

  List<String> _getCharacters(String level) {
    switch (level) {
      case 'Easy':
        return _lowerCaseLetters + _upperCaseLetters;
      case 'Medium':
        return _lowerCaseLetters +
            _upperCaseLetters +
            _numbers +
            _getSpecialCharactersForMedium();
      case 'Hard':
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
    final List<String> extraSpecialCharacters = [];

    // Adiciona pelo menos 1 caractere especial extra
    extraSpecialCharacters
        .add(_specialCharacters[random.nextInt(_specialCharacters.length)]);

    return _specialCharacters + extraSpecialCharacters;
  }

  List<String> _getSpecialCharactersForHard() {
    final random = Random();
    final List<String> extraSpecialCharacters = [];

    // Adiciona pelo menos 3 caracteres especiais extras
    for (var i = 0; i < 3; i++) {
      extraSpecialCharacters
          .add(_specialCharacters[random.nextInt(_specialCharacters.length)]);
    }

    return _specialCharacters + extraSpecialCharacters;
  }

  List<String> _getSpecialCharactersForDificissima() {
    final random = Random();
    final List<String> extraSpecialCharacters = [];

    // Adiciona pelo menos 24 caracteres especiais extras
    for (var i = 0; i < 12; i++) {
      extraSpecialCharacters
          .add(_specialCharacters[random.nextInt(_specialCharacters.length)]);
    }

    return _specialCharacters + extraSpecialCharacters;
  }

  final Map<String, int> _passwordSizes = {
    'Easy': 6,
    'Medium': 10,
    'Hard': 16,
    'Dificíssima': 32,
  };

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
