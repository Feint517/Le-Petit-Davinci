import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/models/pairing/appariement_interactif_model.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ElementAppariementCard extends StatelessWidget {
  final ElementAppariement element;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isGlowing;
  final double? size;
  final double opacity;

  const ElementAppariementCard({
    Key? key,
    required this.element,
    this.isSelected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.isGlowing = false,
    this.size,
    this.opacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Définir les couleurs en fonction de l'état
    Color backgroundColor;
    Color borderColor;

    if (isCorrect) {
      backgroundColor = AppColors.accent.withValues(alpha: 0.2);
      borderColor = AppColors.accent;
    } else if (isIncorrect) {
      backgroundColor = AppColors.secondary.withValues(alpha: 0.2);
      borderColor = AppColors.secondary;
    } else if (isSelected) {
      backgroundColor = AppColors.primary.withValues(alpha: 0.1);
      borderColor = AppColors.primary;
    } else {
      backgroundColor =
          element.couleur?.withValues(alpha: 0.1) ??
          AppColors.purple.withValues(alpha: 0.05);
      borderColor = element.couleur ?? AppColors.purple.withValues(alpha: 0.3);
    }

    // Dimensions et style adaptatives
    final cardSize = size ?? 90.0;

    return Opacity(
      opacity: opacity,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: cardSize,
          maxHeight: cardSize,
          minWidth: 60.0, // Taille minimale pour assurer la lisibilité
          minHeight: 60.0, // Taille minimale pour assurer la lisibilité
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(cardSize / 6),
          border: Border.all(
            color: borderColor,
            width: isSelected || isCorrect || isIncorrect ? 2 : 1,
          ),
          boxShadow:
              isGlowing || isSelected
                  ? [
                    BoxShadow(
                      color: (isCorrect
                              ? Colors.green
                              : (isIncorrect ? Colors.red : borderColor))
                          .withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image si disponible
                if (element.imagePath != null)
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Builder(
                        builder: (context) {
                          try {
                            return Image.asset(
                              element.imagePath!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                debugPrint(
                                  'Erreur chargement image ${element.imagePath}: $error',
                                );
                                // Fallback avec une icône
                                return Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.grey,
                                  size: 40,
                                );
                              },
                            );
                          } catch (e) {
                            debugPrint('Exception chargement image: $e');
                            return Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.grey,
                              size: 40,
                            );
                          }
                        },
                      ),
                    ),
                  ),

                // Espace entre l'image et le texte
                if (element.imagePath != null && element.texte.isNotEmpty)
                  const SizedBox(height: 4),

                // Texte si disponible
                if (element.texte.isNotEmpty)
                  Flexible(
                    flex: element.imagePath != null ? 1 : 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          element.texte,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                isCorrect
                                    ? AppColors.accent
                                    : (isIncorrect
                                        ? AppColors.secondary
                                        : AppColors.textPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Couleur si disponible mais pas d'image ou de texte
                if (element.couleur != null &&
                    element.imagePath == null &&
                    element.texte.isEmpty)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: cardSize / 2,
                        height: cardSize / 2,
                        decoration: BoxDecoration(
                          color: element.couleur,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
