import 'package:flutter/material.dart';

class Helpers {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
          BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
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
