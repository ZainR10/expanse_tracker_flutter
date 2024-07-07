import 'package:flutter/material.dart';

class GeneralUtils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        dismissDirection: DismissDirection.horizontal,
        elevation: 100,
        content: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
