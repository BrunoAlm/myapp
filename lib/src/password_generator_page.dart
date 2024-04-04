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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectDifficultyPage(),
              SizedBox(height: 40),
              Flexible(
                child: PasswordHistoryPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
