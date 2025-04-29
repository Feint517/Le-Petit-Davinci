// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ProfileMenuTile extends StatefulWidget {
  ProfileMenuTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    this.onTap,
    required this.trailingType,
    this.trailingText,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final VoidCallback? onTap;
  String trailingType = 'normal';
  final String? trailingText;

  @override
  State<ProfileMenuTile> createState() => _ProfileMenuTileState();
}

class _ProfileMenuTileState extends State<ProfileMenuTile> {
  bool soundAndMusicEnabled = true;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minVerticalPadding: 0,
      visualDensity: VisualDensity.compact,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: widget.iconBackgroundColor.withValues(alpha: 0.082),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(widget.icon, color: widget.iconColor, size: 20),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          //fontFamily: 'Bricolage Grotesque',
          fontSize: 13.6,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A202C),
        ),
      ),
      trailing: switch (widget.trailingType) {
        'texted' => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.trailingText!,
              style: TextStyle(
                //fontFamily: 'Bricolage Grotesque',
                fontSize: 12,
                color: Color(0xFF718096),
              ),
            ),
            Gap(8),
            Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF1A202C)),
          ],
        ),
        'normal' => const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Color(0xFF1A202C),
        ),
        'switch' => Switch(
          value: soundAndMusicEnabled,
          onChanged: (value) {
            setState(() {
              soundAndMusicEnabled = value;
            });
          },
          activeColor: AppColors.primaryDeep,
          activeTrackColor: AppColors.primaryDeep.withValues(alpha: 0.5),
          inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
          inactiveThumbColor: Colors.white,
        ),
        _ => const SizedBox.shrink(),
      },
      onTap: widget.onTap,
    );
  }
}
