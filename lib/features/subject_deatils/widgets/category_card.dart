import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CategoryCard extends StatelessWidget {
  final String number;
  final String points;
  final String title;
  final String content;
  final String time;
  final Color color;
  final void Function()? onTap;

  const CategoryCard({
    Key? key,
    required this.number,
    required this.points,
    required this.title,
    required this.content,
    required this.time,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 36,
                color: AppColors.accent2,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accent3,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Obtenez $points points',
                      style: TextStyle(color: AppColors.orange, fontSize: 10),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'BricolageGrotesque',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(spacing: 8,
                    children: [
                      Text(
                        content,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.accent3,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/svgs/arrow-right.svg', color: Colors.white, width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}