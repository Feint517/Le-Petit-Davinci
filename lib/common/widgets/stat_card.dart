import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class StatCard extends StatelessWidget {
  final String title;
  final RichText value;
  final String icon;
  final String actionLabel;
  final Color actionColor;

  const StatCard({super.key, 
    required this.title,
    required this.value,
    required this.icon,
    required this.actionLabel,
    required this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 10)),
            SvgPicture.asset(icon, height: 15),
          ],
        ),
        const SizedBox(height: 12),
        value,
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              actionLabel,
              style: TextStyle(
                color: actionColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset(
              SvgAssets.solar_arrow_right_up_linear,
              color: actionColor,
              height: 15,
            ),
          ],
        ),
      ],
    );
  }
}
