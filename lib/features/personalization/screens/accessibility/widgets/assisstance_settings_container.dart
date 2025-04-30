import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/list_tiles/menu_tile.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AssisstanceSettingsContainer extends StatelessWidget {
  const AssisstanceSettingsContainer({super.key});

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
        mainAxisSize: MainAxisSize.min, //? Ensure it doesn't take extra space
        children: [
          MenuTile(
            icon: Icons.record_voice_over,
            iconColor: AppColors.primaryDeep,
            iconBackgroundColor: AppColors.primaryDeep,
            title: "Texte à parole",
            activeSubtitle: true,
            subtitle: "Lit le contenu à haute voix pour aider la compréhension",
            trailingType: 'switch',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
          MenuTile(
            icon: Icons.closed_caption,
            iconColor: AppColors.secondary,
            iconBackgroundColor: AppColors.secondary,
            title: "Sous-titres",
            activeSubtitle: true,
            subtitle: "Options pour les sous-titres dans les vidéos",
            trailingType: 'normal',
          ),
        ],
      ),
    );
  }
}
