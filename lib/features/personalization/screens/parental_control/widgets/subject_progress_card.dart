import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/subject_progress_bar.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SubjectProgressCard extends StatelessWidget {
  const SubjectProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          //* Mathematics progress
          SubjectProgressBar(
            subject: 'Mathématiques',
            progress: 0.65,
            progressColor: AppColors.primaryDeep,
          ),
          const Gap(16),

          //* French progress
          SubjectProgressBar(
            subject: 'Français',
            progress: 0.40,
            progressColor: AppColors.secondary,
          ),
          const Gap(16),

          //* English progress
          SubjectProgressBar(
            subject: 'Anglais',
            progress: 0.20,
            progressColor: AppColors.accent,
          ),
        ],
      ),
    );
  }
}
