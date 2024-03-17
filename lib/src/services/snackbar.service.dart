import 'package:flutter/material.dart';

class SnackbarService {
  void showSnackbar({required BuildContext context, required String text}) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
