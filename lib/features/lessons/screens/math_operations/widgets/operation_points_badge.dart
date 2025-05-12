import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class OperationPointsBadge extends StatelessWidget {
  final int points;

  const OperationPointsBadge({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF9966),
            Color(0xFFFF6B6B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '+$points XP',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}