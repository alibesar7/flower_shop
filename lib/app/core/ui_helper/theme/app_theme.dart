import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.blueColor,
    ),

    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pink,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.pink,
        disabledForegroundColor: AppColors.white,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      constraints: BoxConstraints(minHeight: 56, maxWidth: 326),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(fontSize: 16, color: AppColors.grey),
      errorStyle: TextStyle(fontSize: 14, color: AppColors.red),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 20,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(fontSize: 14, color: AppColors.blackColor),
      displayMedium: TextStyle(
        fontSize: 16,
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.grey),
      bodySmall: TextStyle(
        fontSize: 18,
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(fontSize: 16, color: Colors.black54),
      labelMedium: TextStyle(fontSize: 18, color: Colors.black),
    ),
  );
}
