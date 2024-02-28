import 'package:flutter/material.dart';

class SnackBarApp {
  static void success(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ??= ''),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void danger(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ??= ''),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void warning(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ??= ''),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  static void info(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ??= ''),
        backgroundColor: Colors.blue,
      ),
    );
  }

  static void loader(BuildContext context, bool show) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (show) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          // duration: Duration(seconds: 1),
          duration: Duration(days: 365),
        ),
      );
    }
  }
}
