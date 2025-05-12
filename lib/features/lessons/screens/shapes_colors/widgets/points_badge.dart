import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class PointsBadge extends StatelessWidget {
  final int points;

  const PointsBadge({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Star icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.orange.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.star_rounded,
              color: AppColors.orange,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          
          // Points text
          Text(
            '$points XP',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}