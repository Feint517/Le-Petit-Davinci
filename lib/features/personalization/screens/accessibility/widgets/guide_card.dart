import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class GuideCard extends StatelessWidget {
  const GuideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryDeep.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline, color: AppColors.primaryDeep, size: 20),
              Gap(8),
              Expanded(
                //? Wrap text in Expanded to prevent overflow
                child: Text(
                  "Guide d'accessibilité",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          const Text(
            "Découvrez comment utiliser au mieux nos fonctionnalités d'accessibilité pour personnaliser l'expérience d'apprentissage en fonction des besoins spécifiques de votre enfant.",
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 12,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 12),
          // Align button to ensure proper sizing
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to accessibility guide
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9281FF),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Voir le guide",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}