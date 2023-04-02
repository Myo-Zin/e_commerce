import 'package:e_commerce/util/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primaryColor,
        titleTextStyle: const TextStyle(fontSize: 14.0)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.secondaryColor,
      unselectedItemColor: AppColor.whiteColor,
      backgroundColor: AppColor.primaryColor,
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        textStyle:  TextStyle(
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        fixedSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );

  static InputDecoration authTextFieldDecoration = InputDecoration(
    errorMaxLines: 2,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(5),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor,width: 2),
      borderRadius: BorderRadius.circular(5),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(5),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.secondaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

class AppTextStyle {
  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 17,
    color: Colors.green,
    fontWeight: FontWeight.bold,
  );
// static TextStyle yellowMedium = TextStyle(
//   fontSize: 14,
//   color: AppColor.accentColor,
//   fontWeight: FontWeight.bold,
// );
}
