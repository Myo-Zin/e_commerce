import 'package:flutter/cupertino.dart';

Widget loading() => const Center(
    child: CupertinoActivityIndicator(
      animating: true,
      radius: 25,
    ));