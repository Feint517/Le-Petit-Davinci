import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.tag,
    required this.title,
    required this.contentCount,
    required this.duration,
    required this.iconPath,
  });

  final String tag;
  final String title;
  final int contentCount;
  final String duration;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFDF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xffFC715A),
                      fontSize: 12,
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(6),
                Row(
                  children: [
                    Text(
                      "$contentCount Contenu",
                      style: const TextStyle(fontSize: 11),
                    ),
                    const Gap(5),
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffFDCFFE),
                    ),
                    const Gap(5),
                    Text(duration, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const Gap(16),
          Image.asset(iconPath, height: 88),
        ],
      ),
    );
  }
}
