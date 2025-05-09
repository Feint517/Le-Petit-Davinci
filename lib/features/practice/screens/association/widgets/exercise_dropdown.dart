import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_data.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import '../../../controllers/association/association_controller.dart';

class ExerciseDropdown extends GetView<AssociationController> {
  const ExerciseDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _showExerciseSelectionModal(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primaryDeep,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.selectedExercise.value
                      .split(' ')
                      .take(2)
                      .join(' '),
                  style: const TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showExerciseSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sélectionnez un exercice",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDeep,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: exercisesList.length,
                    itemBuilder: (context, index) {
                      return _buildExerciseOption(
                        exercisesList[index],
                        context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildExerciseOption(String exercise, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changeExercise(exercise);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color:
              controller.selectedExercise.value == exercise
                  ? AppColors.primaryLight
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          exercise,
          style: TextStyle(
            fontFamily: 'Archivo',
            fontSize: 12,
            color:
                controller.selectedExercise.value == exercise
                    ? AppColors.primaryDeep
                    : Colors.black87,
          ),
        ),
      ),
    );
  }
}
