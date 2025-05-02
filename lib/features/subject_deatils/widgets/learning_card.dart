import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({
    super.key,
    required this.title,
    required this.description,
    required this.stats,
    required this.color,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String description;
  final String stats;
  final Color color;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  description,
                  style: const TextStyle(color: AppColors.white, fontSize: 12),
                ),
                const Gap(12),
                Text(
                  stats,
                  style: const TextStyle(color: AppColors.white, fontSize: 10),
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Apprenez maintenant',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Image.asset(imagePath, height: 120, width: 120, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
