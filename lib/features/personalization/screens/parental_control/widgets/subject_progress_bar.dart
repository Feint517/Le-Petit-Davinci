import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SubjectProgressBar extends StatelessWidget {
  const SubjectProgressBar({
    super.key,
    required this.subject,
    required this.progress,
    required this.progressColor,
  });

  final String subject;
  final double progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontSize: 11.9,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A202C),
              ),
            ),
            Text(
              '${progress * 100}%',
              style: const TextStyle(fontSize: 11.9, color: Color(0xFF718096)),
            ),
          ],
        ),
        const Gap(8),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFEDF2F7),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }
}
