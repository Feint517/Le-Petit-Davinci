import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const Header({super.key, required this.title, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onBackPressed,
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF6C6C6C),
                    size: 18,
                  ),
                  Gap(2),
                  Text(
                    "Retour",
                    style: TextStyle(
                      fontFamily: 'Archivo',
                      fontSize: 12,
                      color: Color(0xFF6C6C6C),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 20,
                letterSpacing: -0.06 * 20,
                color: Color(0xFFFC715A), // Main Color/Orange - Secondary
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(IconAssets.avatar),
        ),
      ],
    );
  }
}
