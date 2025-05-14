import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/models/pairing/appariement_interactif_model.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/helpers/asset_helper.dart';

class ElementAppariementCard extends StatelessWidget {
  final ElementAppariement element;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isGlowing;
  final double? size;
  final double opacity;

  const ElementAppariementCard({
    super.key,
    required this.element,
    this.isSelected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.isGlowing = false,
    this.size,
    this.opacity = 1.0,
  });

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
                          // Debug print to track image path
                          debugPrint('Loading image: ${element.imagePath}');
                          
                          // Check if imagePath is valid
                          if (element.imagePath == null || element.imagePath!.isEmpty) {
                            debugPrint('CRITICAL ERROR: Image path is null or empty');
                            return const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 40,
                            );
                          }
                          
                          // No need to validate path format as AssetHelper will handle normalization
                          
                          try {
                            // Add more debugging info
                            debugPrint('ElementAppariementCard - Element ID: ${element.id}');
                            debugPrint('ElementAppariementCard - Element Text: ${element.texte}');
                            
                            // First exercise fix - use the ImageAssets constants for more reliable loading
                            if (element.id == 'cercle_rouge' || element.id == 'cercle_simple') {
                              debugPrint('Using constants for red circle');
                              return AssetHelper.loadFromImageAssets(
                                imageConstant: ImageAssets.red_circle,
                                fit: BoxFit.contain,
                              );
                            } else if (element.id == 'carre_bleu' || element.id == 'carre_simple') {
                              debugPrint('Using constants for blue square');
                              return AssetHelper.loadFromImageAssets(
                                imageConstant: ImageAssets.blue_square,
                                fit: BoxFit.contain,
                              );
                            } else if (element.id == 'triangle_vert' || element.id == 'triangle_simple') {
                              debugPrint('Using constants for green triangle');
                              return AssetHelper.loadFromImageAssets(
                                imageConstant: ImageAssets.green_triangle,
                                fit: BoxFit.contain,
                              );
                            } else if (element.id == 'rectangle_jaune' || element.id == 'rectangle_simple') {
                              debugPrint('Using constants for yellow rectangle');
                              return AssetHelper.loadFromImageAssets(
                                imageConstant: ImageAssets.yellow_rectangle,
                                fit: BoxFit.contain,
                              );
                            }
                            
                            // Use AssetHelper to load image with proper path handling
                            return AssetHelper.loadImageAsset(
                              path: element.imagePath!,
                              fit: BoxFit.contain,
                              placeholder: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  Text(
                                    'Path: ${element.imagePath}',
                                    style: const TextStyle(fontSize: 8, color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          } catch (e) {
                            debugPrint('EXCEPTION loading image: $e');
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                Text(
                                  'Exception: ${e.toString().substring(0, math.min(e.toString().length, 30))}',
                                  style: const TextStyle(fontSize: 6, color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
