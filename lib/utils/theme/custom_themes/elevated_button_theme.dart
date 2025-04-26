import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  //*light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    // style: ElevatedButton.styleFrom(
    //   elevation: 0,
    //   foregroundColor: Colors.white,
    //   backgroundColor: AppColors.primary,
    //   disabledForegroundColor: Colors.grey,
    //   disabledBackgroundColor: Colors.grey,
    //   side: const BorderSide(color: AppColors.primary),
    //   padding: const EdgeInsets.symmetric(vertical: 18),
    //   textStyle: const TextStyle(
    //     fontSize: 16,
    //     color: Colors.white,
    //     fontWeight: FontWeight.w600,
    //   ),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
    // ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.grey,
      disabledBackgroundColor: AppColors.grey,
      minimumSize: Size(130, 40),
      padding: EdgeInsets.symmetric(horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
  );

  //*dark theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    // style: ElevatedButton.styleFrom(
    //   elevation: 0,
    //   foregroundColor: Colors.white,
    //   backgroundColor: AppColors.primary,
    //   disabledForegroundColor: Colors.grey,
    //   disabledBackgroundColor: Colors.grey,
    //   side: const BorderSide(color: AppColors.primary),
    //   padding: const EdgeInsets.symmetric(vertical: 18),
    //   textStyle: const TextStyle(
    //     fontSize: 16,
    //     color: Colors.white,
    //     fontWeight: FontWeight.w600,
    //   ),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
    // ),
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.grey,
      disabledBackgroundColor: AppColors.grey,
      minimumSize: Size(130, 40),
      padding: EdgeInsets.symmetric(horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
  );
}
