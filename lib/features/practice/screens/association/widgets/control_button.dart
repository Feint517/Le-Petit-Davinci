import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class ControlButtons extends GetView<AssociationController> {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            // Retry button
            Expanded(
              child: ElevatedButton.icon(
                onPressed:
                    controller.isAnswerValidated.value
                        ? controller.resetExercise
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA593F5),
                  disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text("Réessayer", style: TextStyle(fontSize: 14)),
              ),
            ),
            const SizedBox(width: 16),

            // Check/Next button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (!controller.isAnswerValidated.value) {
                    // Validate the answer
                    controller.validateAnswer();
                  } else {
                    // Move to next exercise
                    controller.nextExercise();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22B07D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: Icon(
                  controller.isAnswerValidated.value
                      ? Icons.arrow_forward
                      : Icons.check,
                  size: 18,
                ),
                label: Text(
                  controller.isAnswerValidated.value ? "Passer" : "Vérifier",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}