import 'package:flutter/material.dart';
import 'package:gerasenha/dependencies.dart';
import 'package:gerasenha/src/password_history/password_history_controller.dart';

class PasswordHistoryPage extends StatefulWidget {
  const PasswordHistoryPage({super.key});

  @override
  State<PasswordHistoryPage> createState() => _PasswordHistoryPageState();
}

class _PasswordHistoryPageState extends State<PasswordHistoryPage> {
  final ct = di<PasswordHistoryController>();

  @override
  void initState() {
    super.initState();
    ct.getPasswordHistory();
    ct.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Últimas senhas geradas:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ct.passwords.length,
              itemBuilder: (context, index) {
                final passwords = ct.passwords;
                final level = passwords[index].level;
                final password = passwords[index].password;
                return ListTile(
                  title: Text('Nível: $level'),
                  subtitle: Text('Senha: $password'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
