import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NavigationFooter extends GetView<AssociationController> {
  const NavigationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => controller.navigateToPreviousExercise(),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, color: Color(0xFF272727), size: 18),
                const SizedBox(width: 2),
                Text(
                  "Quiz précédent",
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => controller.navigateToNextExercise(),
            child: Row(
              children: [
                Text(
                  "Quiz suivant",
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF272727),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
