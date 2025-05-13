import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ShapesColorsHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ShapesColorsHeader({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button
        InkWell(
          onTap: onBackPressed,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryDeep,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Title
        const Text(
          'Formes et Couleurs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            fontFamily: 'BricolageGrotesque',
          ),
        ),
      ],
    );
  }
}
