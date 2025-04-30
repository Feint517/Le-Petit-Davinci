import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key, required this.activeIcon});

  bool activeIcon = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF6C6C6C),
                size: 18,
              ),
              const Gap(5),
              const Text(
                "Retour",
                style: TextStyle(fontSize: 12, color: Color(0xFF6C6C6C)),
              ),
            ],
          ),
        ),
        if (activeIcon)
          const Icon(Icons.logout, color: Color(0xFF494949), size: 24)
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
