import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showConfirmDialog(BuildContext context, String message, Function() onTap) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Delete"),
          content: Text(
            message,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              onPressed: onTap,
              child: const Text("Yes"),
            ),
          ],
        );
      });
}
