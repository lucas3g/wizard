import 'package:flutter/material.dart';
import 'package:wizard/app/utils/navigation_service.dart';

enum TypeSnackBar {
  success,
  error,
}

class MySnackBar {
  final String message;
  final TypeSnackBar type;

  late Animation<Offset> animation;

  MySnackBar({
    required this.message,
    required this.type,
  }) {
    _showSnackBar();
  }

  _showSnackBar() {
    late SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: type == TypeSnackBar.success ? Colors.green : Colors.red,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
