import 'package:flutter/material.dart';
import 'package:gerasenha/src/password_history/password_history_page.dart';
import 'package:gerasenha/src/select_difficulty/select_difficulty_page.dart';

class PasswordGenerator extends StatelessWidget {
  final String title;
  const PasswordGenerator({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selecione a dificuldade:',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SelectDifficultyPage(),
              SizedBox(height: 20),
              Expanded(child: PasswordHistoryPage()),
            ],
          ),
        ),
      ),
    );
  }
}
