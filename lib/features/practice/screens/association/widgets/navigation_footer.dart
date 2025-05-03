import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NavigationFooter extends GetView<AssociationController> {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous exercise button
          TextButton.icon(
            onPressed: () => controller.navigateToPreviousExercise(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 12,
            ),
            label: const Text(
              "Exercice précédent",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),

          // Next exercise button
          TextButton.icon(
            onPressed: () => controller.navigateToNextExercise(),
            label: const Text(
              "Exercice suivant",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}