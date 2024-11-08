import 'package:flutter/material.dart';

class AppColors {
  static const kTitleColor = Color(0xFFECDFCC);
  static const kSubtitleColor = Color(0xFF697565);
  static const kActiveColor = Color(0xFFECDFCC);
  static const kInactiveColor = Color(0xFF3C3D37);
}

class AppStyles {
  static const kTitleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.kTitleColor,
  );

  static const kSubtitleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.kSubtitleColor,
  );

  static const kDescriptionTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.kTitleColor,
  );
}