import 'package:flutter/material.dart';
import 'package:travel_app/app_theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 18,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static const TextStyle mediumTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
  );

  static const TextStyle normalTextStyle = TextStyle(
    color: AppColors.verticalDividerColor,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle locationTextStyle = TextStyle(
    color: AppColors.greyColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle lightGreyTextStyle = TextStyle(
    color: AppColors.lightGreyColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );


// Add other text styles as needed
}
