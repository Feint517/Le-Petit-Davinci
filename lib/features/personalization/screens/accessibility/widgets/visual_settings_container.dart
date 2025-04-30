import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/list_tiles/menu_tile.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class VisualSettingsContainer extends StatelessWidget {
  const VisualSettingsContainer({super.key});

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
            icon: Icons.text_fields,
            iconColor: AppColors.primaryDeep,
            iconBackgroundColor: AppColors.primaryDeep,
            title: 'Texte plus grand',
            activeSubtitle: true,
            subtitle: "Augmente la taille du texte dans l'application",
            trailingType: 'switch',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
          MenuTile(
            icon: Icons.contrast,
            iconColor: AppColors.secondary,
            iconBackgroundColor: AppColors.secondary,
            title: "Mode contraste élevé",
            activeSubtitle: true,
            subtitle: "Améliore la lisibilité pour les personnes malvoyantes",
            trailingType: 'switch',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
          MenuTile(
            icon: Icons.animation,
            iconColor: AppColors.accent,
            iconBackgroundColor: AppColors.accent,
            title: "Réduire les animations",
            activeSubtitle: true,
            subtitle: "Désactive ou réduit les effets d'animation",
            trailingType: 'switch',
          ),
        ],
      ),
    );
  }
}
