import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/list_tiles/menu_tile.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NotificationsContainer extends StatefulWidget {
  const NotificationsContainer({super.key});

  @override
  State<NotificationsContainer> createState() => _NotificationsContainerState();
}

class _NotificationsContainerState extends State<NotificationsContainer> {
  bool newLessonsEnabled = true;
  bool dailyRemindersEnabled = true;

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
          //* Daily Reminders - more compact
          MenuTile(
            icon: Icons.notifications,
            iconColor: Color(0xFF4CD964),
            iconBackgroundColor: Color(0xFF4CD964),
            title: 'Rappels quotidiens',
            activeSubtitle: false,
            trailingType: 'switch',
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),

          //* New Lessons - more compact
          MenuTile(
            icon: Icons.notifications,
            iconColor: Color(0xFF4CD964),
            iconBackgroundColor: Color(0xFF4CD964),
            title: 'Nouvelles leçons',
            activeSubtitle: false,
            trailingType: 'switch',
          ),
        ],
      ),
    );
  }
}
