import 'package:flutter/material.dart';

///
class BuukMeNowSnackBar {
  ///
  static void showErrorSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ///
  static void showSuccessSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
