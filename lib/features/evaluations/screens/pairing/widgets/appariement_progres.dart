import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/models/pairing/appariement_interactif_model.dart';

class AppariementProgres extends StatelessWidget {
  final int currentIndex;
  final int totalExercices;
  final double progress;
  final NiveauDifficulte difficulte;

  const AppariementProgres({
    super.key,
    required this.currentIndex,
    required this.totalExercices,
    required this.progress,
    required this.difficulte,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Indicateur d'exercice et difficulté
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Compteur d'exercices
            Text(
              'Exercice $currentIndex sur $totalExercices',
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),

            // Badge de difficulté
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: _getDifficultyColor(difficulte).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getDifficultyIcon(difficulte),
                    size: 14,
                    color: _getDifficultyColor(difficulte),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _getDifficultyText(difficulte),
                    style: TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getDifficultyColor(difficulte),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Barre de progression
        Stack(
          children: [
            // Fond de la barre
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),

            // Progression remplie
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculer la largeur en fonction de la largeur disponible
                final progressWidth = constraints.maxWidth * progress;
                // S'assurer que la largeur n'est jamais négative
                final safeWidth = progressWidth > 0 ? progressWidth : 0.0;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: safeWidth,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(difficulte),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: _getDifficultyColor(
                          difficulte,
                        ).withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Texte de progression
        Text(
          '${(progress * 100).toInt()}% complété',
          style: TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _getDifficultyColor(difficulte),
          ),
        ),
      ],
    );
  }

  // Helper pour obtenir la couleur en fonction de la difficulté
  Color _getDifficultyColor(NiveauDifficulte difficulte) {
    switch (difficulte) {
      case NiveauDifficulte.facile:
        return Colors.green;
      case NiveauDifficulte.moyen:
        return Colors.amber.shade700;
      case NiveauDifficulte.difficile:
        return Colors.red;
    }
  }

  // Helper pour obtenir le texte en fonction de la difficulté
  String _getDifficultyText(NiveauDifficulte difficulte) {
    switch (difficulte) {
      case NiveauDifficulte.facile:
        return "Facile";
      case NiveauDifficulte.moyen:
        return "Moyen";
      case NiveauDifficulte.difficile:
        return "Difficile";
    }
  }

  // Helper pour obtenir l'icône en fonction de la difficulté
  IconData _getDifficultyIcon(NiveauDifficulte difficulte) {
    switch (difficulte) {
      case NiveauDifficulte.facile:
        return Icons.sentiment_satisfied_rounded;
      case NiveauDifficulte.moyen:
        return Icons.sentiment_neutral_rounded;
      case NiveauDifficulte.difficile:
        return Icons.sentiment_very_dissatisfied_rounded;
    }
  }
}
