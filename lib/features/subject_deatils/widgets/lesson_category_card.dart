import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class LessonCategoryCard extends StatelessWidget {
  final String number;
  final String title;
  final String content;
  final String time;
  final int points;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const LessonCategoryCard({
    super.key,
    required this.number,
    required this.title,
    required this.content,
    required this.time,
    required this.points,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            //* Number
            Text(
              number,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const Gap(20),

            //* Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Points
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Obtenez $points points",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Gap(6),

                  //* Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Content Info
                  Text(
                    "$content ● $time",
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(SvgAssets.arrow_right),
          ],
        ),
      ),
    );
  }
}
