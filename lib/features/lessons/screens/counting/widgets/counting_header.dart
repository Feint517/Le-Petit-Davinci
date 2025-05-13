import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CountingHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String title;

  const CountingHeader({
    super.key,
    required this.onBackPressed,
    this.title = 'Les nombres et le comptage',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button with shadow and animation
        GestureDetector(
          onTap: onBackPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primaryDeep,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Title with styling
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'BricolageGrotesque',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
