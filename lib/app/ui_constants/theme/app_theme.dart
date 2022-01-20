import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  ThemeData get themeData {
    return ThemeData(
      primaryColor: Colors.black87,
      // primaryTextTheme: const TextTheme(
      //     // headline1:
      //     //     isTablet ? TextStyles.cardHeaderTablet : TextStyles.cardHeader,
      //     // bodyText1: isTablet ? TextStyles.cardTextTablet : TextStyles.cardText,
      //     ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        actionsIconTheme: IconThemeData(color: Colors.black87),
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        centerTitle: true,
        // color: greyColor,
      ),
      colorScheme: const ColorScheme.light(
          primary: Colors.black45, secondary: Colors.black45),
      accentColor: Colors.black45,
      cardTheme: CardTheme(
        elevation: 16,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      ),
    );
  }
}
