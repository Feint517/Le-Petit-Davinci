// exercise_content.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/options_grid.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/size_comparaison_content.dart';
// Import the new size comparison content widget
import 'package:kids_learning_app/utils/constants/colors.dart';

class ExerciseContent extends GetView<AssociationController> {
  const ExerciseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Choose which content to display based on series
      if (controller.isInSeries2) {
        // Use the enhanced size comparison content for Series 2
        return const SizeComparisonContent();
      }

      // Use the enhanced content for Series 1
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          // Add subtle shadow for depth
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Series title with icon
            Row(
              children: [
                _getIconForSeries(),
                const SizedBox(width: 10),
                Text(
                  _getSeriesTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeep,
                  ),
                ),
              ],
            ),
            const Gap(15),

            //* Instruction text with improved styling
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.secondary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.currentExercise.instruction,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),

            //* Image with enhanced container
            Center(
              child: Container(
                height: 180,
                width: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  controller.currentExercise.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    //* Enhanced fallback image if asset doesn't exist
                    return Container(
                      color: Colors.grey[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Image non disponible",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Gap(20),

            //* Options grid with smoother animation
            const OptionsGrid(),

            // Progress indicator
            const Gap(15),
            LinearProgressIndicator(
              value:
                  (controller.currentExerciseIndex.value + 1) /
                  controller.currentExercises.length,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            const Gap(5),
            Center(
              child: Text(
                "${controller.currentExerciseIndex.value + 1}/${controller.currentExercises.length}",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper to get appropriate icon for series
  Widget _getIconForSeries() {
    final seriesName = controller.selectedExercise.value;

    if (seriesName.contains("couleur")) {
      return Icon(Icons.color_lens, size: 24, color: AppColors.primary);
    } else if (seriesName.contains("animaux")) {
      return Icon(Icons.pets, size: 24, color: AppColors.primary);
    } else if (seriesName.contains("fruits")) {
      return Icon(Icons.apple, size: 24, color: AppColors.primary);
    }

    return Icon(Icons.extension, size: 24, color: AppColors.primary);
  }

  // Helper to get formatted series title
  String _getSeriesTitle() {
    final seriesName = controller.selectedExercise.value;

    if (seriesName.contains("la bonne couleur")) {
      return "Les Couleurs";
    } else if (seriesName.contains("les animaux")) {
      return "Les Animaux";
    } else if (seriesName.contains("les fruits")) {
      return "Les Fruits";
    }

    return "Exercice d'Association";
  }
}
