import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.avatarPath,
    required this.name,
    required this.age,
    required this.level,
    required this.progress,
    required this.xp,
    required this.xpGoal,
  });

  final String avatarPath;
  final String name;
  final String age;
  final String level;
  final double progress;
  final String xp;
  final String xpGoal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryDeep, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Avatar
            Container(
              width: 69,
              height: 69,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(avatarPath, fit: BoxFit.cover),
              ),
            ),
            const Gap(8),

            //* Name
            Text(
              name,
              style: TextStyle(
                fontSize: 13.6,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const Gap(4),

            //* Age and level
            Text(
              "$age • Niveau $level",
              style: TextStyle(fontSize: 11.9, color: Color(0xFF718096)),
            ),
            const Gap(8),

            //* Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 8,
                backgroundColor: const Color(0xFFEDF2F7),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryDeep,
                ),
              ),
            ),
            const Gap(8),

            //* XP display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "XP",
                  style: TextStyle(fontSize: 10.2, color: Color(0xFF718096)),
                ),
                Text(
                  "$xp/$xpGoal",
                  style: TextStyle(fontSize: 10.2, color: Color(0xFF718096)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
