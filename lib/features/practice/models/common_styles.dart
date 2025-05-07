// styles.dart
import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AppStyles {
  // Card styling
  static BoxDecoration mainCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.1),
        blurRadius: 15,
        offset: const Offset(0, 8),
        spreadRadius: 2,
      ),
    ],
    border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
  );

  // Inner content area
  static BoxDecoration innerContentDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFE5CBFF), width: 2),
  );

  // Word bank / options area
  static BoxDecoration optionsAreaDecoration = BoxDecoration(
    color: const Color(0xFFF7F7FF),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFFFD6C9), width: 2),
  );

  // Main titles
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Bricolage Grotesque',
    fontSize: 20,
    letterSpacing: -0.06 * 20,
    color: Color(0xFF6A3EA1),
  );

  // Content text
  static const TextStyle contentStyle = TextStyle(
    fontFamily: 'Bricolage Grotesque',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  // Button text
  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Bricolage Grotesque',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Small info text
  static const TextStyle smallInfoStyle = TextStyle(
    fontFamily: 'Archivo',
    fontSize: 10,
    color: Color(0xFF272727),
  );
}
