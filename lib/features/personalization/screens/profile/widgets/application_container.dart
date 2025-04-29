import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/list_tiles/profile_menu_tile.dart';
import 'package:kids_learning_app/features/personalization/screens/accessibility/accessibility_screen.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ApplicationContainer extends StatelessWidget {
  const ApplicationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          //* Parental Control - more compact
          ProfileMenuTile(
            icon: Icons.shield,
            iconColor: Color(0xFFFF7E5F),
            iconBackgroundColor: Color(0xFFFF7E5F),
            title: 'Contrôle parental',
            trailingType: 'normal',
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),

          //* Accessibility - more compact
          ProfileMenuTile(
            icon: Icons.accessibility_new,
            iconColor: Color(0xFF4CD964),
            iconBackgroundColor: Color(0xFF4CD964),
            title: 'Accessibilité',
            trailingType: 'normal',
            onTap: () => Get.to(() => const AccessibilityScreen()),
          ),
        ],
      ),
    );
  }
}
