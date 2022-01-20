import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  ThemeData get themeData {
    return ThemeData(
      primaryColor: AppColors.primarySwatch,
      colorScheme: ColorScheme.light(
        primary: AppColors.primarySwatch,
        secondary: AppColors.secondary.withOpacity(0.4),
        error: Colors.red,
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: AppColors.secondary,
        ),
        actionsIconTheme: IconThemeData(color: AppColors.secondary),
        iconTheme: IconThemeData(color: AppColors.secondary),
        centerTitle: true,
        color: AppColors.primarySwatch,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => AppColors.secondary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: AppColors.secondary,
        ),
      ),
    );
  }
}
