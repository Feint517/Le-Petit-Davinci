import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* Title
        const Text(
          "Langue d'apprentissage",
          style: TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A202C),
          ),
        ),

        const Gap(8),

        //* Description
        const Text(
          "Choisissez la langue dans laquelle vous souhaitez apprendre",
          style: TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 14,
            color: Color(0xFF4A5568),
          ),
        ),
      ],
    );
  }
}
