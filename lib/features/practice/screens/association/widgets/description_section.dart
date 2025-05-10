import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Perfectionne ton écriture et ta lecture",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          Gap(8),
          Text(
            "La lecture et l'écriture sont essentielles pour maîtriser la langue française. Cet exercice interactif t'aide à enrichir ton vocabulaire et à améliorer ta compréhension des phrases.",
            style: TextStyle(fontSize: 12, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
