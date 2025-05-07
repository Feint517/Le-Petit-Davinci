import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/activities_section.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/parental_control_section.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/profile_card.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/statistics_card.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/subject_progress_card.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/section_header.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ParentalControlScreen extends StatelessWidget {
  const ParentalControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(),
                const Gap(16),

                //* User profiles row
                Row(
                  children: [
                    ProfileCard(
                      avatarPath: ImageAssets.avatar1,
                      name: 'Alex',
                      age: '8',
                      level: '12',
                      progress: 65,
                      xp: '400',
                      xpGoal: '620',
                    ),
                    const Gap(16),
                    ProfileCard(
                      avatarPath: ImageAssets.avatar2,
                      name: 'Emma',
                      age: '7',
                      level: '15',
                      progress: 84,
                      xp: '520',
                      xpGoal: '620',
                    ),
                  ],
                ),
                const Gap(24),

                //* Statistics cards
                Row(
                  children: [
                    StatisticsCard(
                      statName: "Temps d'apprentissage",
                      statValue: '2h 15min',
                      statDescription: 'Cette semaine',
                      icon: Icons.lock_clock,
                      iconColor: AppColors.primaryDeep,
                    ),
                    const Gap(16),
                    StatisticsCard(
                      statName: "Récompenses",
                      statValue: '12',
                      statDescription: "Badges gagnés",
                      icon: Icons.emoji_events,
                      iconColor: AppColors.secondary,
                    ),
                  ],
                ),
                const Gap(24),

                //* Subject progression section
                SectionHeader(title: 'Progression par matière'),
                const Gap(16),
                SubjectProgressCard(),
                const Gap(24),

                //* Activities section
                SectionHeader(title: 'Progression par matière'),
                const Gap(16),
                ActivitiesSection(),
                const Gap(24),

                //* Parental control options
                SectionHeader(title: 'Progression par matière'),
                const Gap(16),
                ParentalControlSection(),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
