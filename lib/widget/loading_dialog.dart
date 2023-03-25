
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        width: 50,
        height: 50,
        child: const Center(
          child: CupertinoActivityIndicator(
            animating: true,
            radius: 25,
          ),
        ),
      ),
    ),
  );
}