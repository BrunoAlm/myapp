import 'package:flutter/material.dart';
import 'package:gerasenha/dependencies.dart';
import 'package:gerasenha/src/password_generator_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Dependencies().resgister();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'Gerador de senhas';
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.dark,
      ),
      home: const PasswordGenerator(title: title),
    );
  }
}
