import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/options_grid.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ExerciseContent extends GetView<AssociationController> {
  const ExerciseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Instruction text
            Text(
              controller.currentExercise.instruction,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const Gap(20),

            //* Image
            Center(
              child: SizedBox(
                height: 160,
                width: 160,
                child: Image.asset(
                  controller.currentExercise.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    //* Fallback image if asset doesn't exist
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 50),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Gap(20),

            //* Options grid
            const OptionsGrid(),
          ],
        ),
      ),
    );
  }
}