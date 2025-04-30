import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/activity_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActivityCard(
          icon: Icons.book,
          iconBgColor: AppColors.accent.withValues(alpha: 0.082),
          iconColor: AppColors.accent,
          title: "Leçon de mathématiques",
          time: "Aujourd'hui, 14:30",
          status: "Terminé",
          statusBgColor: const Color(0xFFC6F6D5),
          statusTextColor: AppColors.accent,
        ),
        const Gap(12),
        ActivityCard(
          icon: Icons.quiz,
          iconBgColor: AppColors.primaryDeep.withValues(alpha: 0.082),
          iconColor: AppColors.primaryDeep,
          title: "Quiz de français",
          time: "Aujourd'hui, 15:45",
          status: "En cours",
          statusBgColor: const Color(0xFFE9D8FD),
          statusTextColor: AppColors.primaryDeep,
        ),
      ],
    );
  }
}
