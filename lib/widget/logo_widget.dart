import 'package:e_commerce/util/asset_string.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child:  const Image(
          image: AssetImage(AssetString.logo),
          fit: BoxFit.fill,
        ));
  }
}