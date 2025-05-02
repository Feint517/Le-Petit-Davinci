import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class StatBox extends StatelessWidget {
  final String title;
  final String iconPath;
  final List<TextSpan> valueRich;
  final double width;

  const StatBox({
    super.key,
    required this.title,
    required this.iconPath,
    required this.valueRich,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontSize: 9)),
              const Spacer(),
              SvgPicture.asset(iconPath, height: 16),
            ],
          ),
          const Gap(12),
          RichText(text: TextSpan(children: valueRich)),
        ],
      ),
    );
  }
}
