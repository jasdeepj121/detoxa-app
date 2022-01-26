import 'package:detoxa/app/ui_constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static final TextStyle headerTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  static final TextStyle text2 = TextStyle(
    fontSize: 18.0,
    letterSpacing: -0.5,
  );

  static final TextStyle text3 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static final TextStyle text4 = TextStyle(
    fontSize: 17.0,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w600,
  );

   static final TextStyle errorMessage = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.red,
  );

    static final TextStyle description1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 19,
    // color: AppColors.textColor,
  );

    static final TextStyle description2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    // color: AppColors.textColor,
  );
}
