import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/list_tiles/profile_menu_tile.dart';
import 'package:kids_learning_app/features/profile/language_screen.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LearningSettingsContainer extends StatefulWidget {
  const LearningSettingsContainer({super.key});

  @override
  State<LearningSettingsContainer> createState() =>
      _LearningSettingsContainerState();
}

class _LearningSettingsContainerState extends State<LearningSettingsContainer> {
  bool soundAndMusicEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //* Language settings - more compact
          ProfileMenuTile(
            icon: Icons.language,
            iconColor: AppColors.primaryDeep,
            iconBackgroundColor: Color(0xFF9F83F9),
            title: "Langue d'apprentissage",
            trailingType: 'texted',
            trailingText: "Français",
            onTap: () {
              Get.to(() => const LanguageScreen());
            },
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),

          //* Sound and Music - more compact
          ProfileMenuTile(
            icon: Icons.music_note,
            title: 'Son et musique',
            iconColor: Color(0xFFFC715A),
            iconBackgroundColor: Color(0xFFFF7E5F),
            trailingType: 'switch',
          ),
        ],
      ),
    );
  }
}
