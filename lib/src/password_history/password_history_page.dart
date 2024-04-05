import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerasenha/main.dart';
import 'package:gerasenha/src/helpers.dart';
import 'package:gerasenha/src/password_history/password_history_controller.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_controller.dart';

class PasswordHistoryPage extends StatefulWidget {
  const PasswordHistoryPage({super.key});

  @override
  State<PasswordHistoryPage> createState() => _PasswordHistoryPageState();
}

class _PasswordHistoryPageState extends State<PasswordHistoryPage> {
  final ct = di<PasswordHistoryController>();
  final ctDiff = di<DifficultyController>();

  @override
  void initState() {
    ctDiff.addListener(() {
      if (mounted) {
        setState(() {
          ct.getPasswordHistory();
          
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Últimas senhas geradas:',
          style: TextStyle(fontSize: 16),
        ),
        Expanded(
            child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: ct.passwords.map<Widget>((e) {
              final level = e.level;
              final password = e.password;
              final date = e.createdAt;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Card.filled(
                  color: Theme.of(context).colorScheme.onSecondary,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: password));
                      Helpers.snackBar(
                        context,
                        'Senha $level copiada para a área de transferência.',
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(level),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(password),
                              const Spacer(),
                              Text(
                                  "${date.hour}:${date.minute} ${date.day}/${date.month}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )),
      ],
    );
  }
}
