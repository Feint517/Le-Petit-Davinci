import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/application_container.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/learning_settings_container.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/notifications_container.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_container.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/section_header.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/version_display.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/popups/popup_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool soundAndMusicEnabled = true;
  bool dailyRemindersEnabled = true;
  bool newLessonsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Header with back button and logout
              CommonHeader(
                trailing: Icon(
                  Icons.logout,
                  color: Color(0xFF494949),
                  size: 24,
                ),
                onTapTrailing: () {
                  PopupHelper.showLogoutConfirmation(
                    context: context,
                    onConfirm: () {
                      Navigator.of(context).pop(); //? Close the dialog
                    },
                  );
                },
              ),
              const Gap(16),

              //* Profile container - using a fixed height
              ProfileContainer(),
              const Gap(20),

              //* Remaining content using Expanded to ensure fitting in screen
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Section headers and containers with equal spacing
                    SectionHeader(title: "Paramètres d'apprentissage"),
                    const Gap(8),
                    LearningSettingsContainer(),

                    const Gap(12),
                    SectionHeader(title: "Notifications"),
                    const Gap(8),
                    NotificationsContainer(),

                    const Gap(12),
                    SectionHeader(title: 'Application'),
                    const Gap(8),
                    ApplicationContainer(),

                    const Spacer(),

                    //* Version at bottom
                    VersionDisplay(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//TODO: Switch to stateless widget and use Getx for state management