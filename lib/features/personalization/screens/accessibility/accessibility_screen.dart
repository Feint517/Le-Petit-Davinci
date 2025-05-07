import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/personalization/screens/accessibility/widgets/assisstance_settings_container.dart';
import 'package:kids_learning_app/features/personalization/screens/accessibility/widgets/guide_card.dart';
import 'package:kids_learning_app/features/personalization/screens/accessibility/widgets/visual_settings_container.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/section_header.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool textToSpeechEnabled = true;
  bool highContrastEnabled = false;
  bool largerTextEnabled = false;
  bool reduceAnimationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(),
                const Gap(8),

                //* Description
                const Text(
                  "Personnalisez l'expérience d'apprentissage pour tous les besoins",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    color: Color(0xFF4A5568),
                  ),
                ),

                const Gap(24),

                SectionHeader(title: 'Paramètres visuels'),
                const Gap(12),
                VisualSettingsContainer(),

                const Gap(24),

                SectionHeader(title: "Paramètres d'assistance"),
                const Gap(12),

                //* Assistance settings
                AssisstanceSettingsContainer(),
                const Gap(24),
                SectionHeader(title: "Guide d'accessibilité"),
                const Gap(12),

                //* Guide card
                GuideCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
