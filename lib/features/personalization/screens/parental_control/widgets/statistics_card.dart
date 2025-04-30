import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.statName,
    required this.statValue,
    required this.statDescription,
    required this.icon,
    required this.iconColor,
  });

  final String statName;
  final String statValue;
  final String statDescription;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
            //* Icon and title
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.082),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const Gap(12),
                Flexible(
                  child: Text(
                    statName,
                    style: TextStyle(fontSize: 11.9, color: Color(0xFF4A5568)),
                  ),
                ),
              ],
            ),
            const Gap(12),

            //* value
            Text(
              statValue,
              style: TextStyle(
                fontSize: 20.4,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const Gap(4),

            //* Period
            Text(
              statDescription,
              style: TextStyle(fontSize: 11.9, color: Color(0xFF718096)),
            ),
          ],
        ),
      ),
    );
  }
}
