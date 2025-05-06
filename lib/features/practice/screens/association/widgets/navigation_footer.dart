// navigation_footer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NavigationFooter extends GetView<AssociationController> {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Change button text and color based on position in the series
      final bool isLastInSeries = controller.isLastExerciseInSeries;
      final buttonColor =
          isLastInSeries
              ? AppColors
                  .primary // Different color for series navigation
              : AppColors.secondary; // Original color for exercise navigation

      final nextText = isLastInSeries ? "Série suivante" : "Exercice suivant";
      final previousText = "Exercice précédent";

      // Enhanced navigation footer with elevation and improved layout
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30),
          // Add subtle shadow for depth
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous exercise button with ripple effect
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.navigateToPreviousExercise(),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(30),
                ),
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        previousText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Series progress indicator (pill shaped)
            Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "${controller.currentExerciseIndex.value + 1}/${controller.currentExercises.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Next exercise/series button with ripple effect
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => controller.navigateToNextExercise(),
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        nextText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
