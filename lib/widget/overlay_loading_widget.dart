import 'package:flutter/material.dart';

mixin LoadingOverlay {
  OverlayEntry showLoadingOverlay(
      BuildContext context, OverlayEntry? overlayEntry) {
    overlayEntry = OverlayEntry(builder: (context) {
      return const Align(
        alignment: Alignment.center,
        child: Card(
          child: SizedBox(
              height: 80,
              width: 100,
              //color: Colors.grey,
              child: SizedBox(
                  width: 30, height: 30, child: Center(child: CircularProgressIndicator()))),
        ),
      );
    });
    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry);
    return overlayEntry;
  }
}
