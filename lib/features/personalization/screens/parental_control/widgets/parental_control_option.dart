import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ParentalControlOption extends StatelessWidget {
  const ParentalControlOption({
    super.key,
    required this.title,
    required this.description,
    required this.titleColor,
  });

  final String title;
  final String description;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 13.6,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          const Gap(4),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 11.9,
              fontWeight: FontWeight.w600,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}
