import 'package:flutter/material.dart';

extension BuildContextUI on BuildContext {
  showErrorSnackBar(String content) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    //fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
        ),
      );
  }

  showSuccessSnackBar(String content) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 20),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.white,
                  //fontSize: 16,
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

extension StringExtension on String {
  String get hardCoded => this;
}
