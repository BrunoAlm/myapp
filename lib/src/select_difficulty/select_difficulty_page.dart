import 'package:flutter/material.dart';
import 'package:gerasenha/main.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_controller.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_helper.dart';

class SelectDifficultyPage extends StatefulWidget {
  const SelectDifficultyPage({super.key});

  @override
  State<SelectDifficultyPage> createState() => _SelectDifficultyPageState();
}

class _SelectDifficultyPageState extends State<SelectDifficultyPage> {
  final ct = di<DifficultyController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      children: DifficultyHelper.levels
          .map(
            (level) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  ct.generatePassword(context, level);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 40),
                ),
                child: Text(level),
              ),
            ),
          )
          .toList(),
    );
  }
}
