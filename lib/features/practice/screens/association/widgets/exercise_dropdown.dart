import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

import '../../../controllers/association/association_controller.dart';

class ExerciseDropdown extends GetView<AssociationController> {
  const ExerciseDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedExercise.value,
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
            iconSize: 24,
            elevation: 16,
            dropdownColor: AppColors.primaryDeep,
            style: const TextStyle(color: Colors.white),
            onChanged: controller.changeExercise,
            items:
                controller.exercisesList.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(value, style: const TextStyle(fontSize: 14)),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}