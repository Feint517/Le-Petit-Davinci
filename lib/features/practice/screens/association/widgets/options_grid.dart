import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class OptionsGrid extends GetView<AssociationController> {
  const OptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.5,
        ),
        itemCount: controller.currentExercise.options.length,
        itemBuilder: (context, index) {
          final option = controller.currentExercise.options[index];

          // Determine button color and style based on option
          Color buttonColor = controller.getColorForOption(option);
          bool isSelected = controller.selectedAnswer.value == option;
          bool isCorrect =
              controller.isAnswerValidated.value &&
              option == controller.currentExercise.correctAnswer;
          bool isIncorrect =
              controller.isAnswerValidated.value &&
              isSelected &&
              option != controller.currentExercise.correctAnswer;

          // Add border when selected or validated
          BoxBorder? border;
          if (isCorrect) {
            border = Border.all(color: Colors.green, width: 2);
          } else if (isIncorrect) {
            border = Border.all(color: Colors.red, width: 2);
          } else if (isSelected) {
            border = Border.all(color: Colors.blue, width: 2);
          }

          return GestureDetector(
            onTap: () {
              // Only allow selection if not already validated
              if (!controller.isAnswerValidated.value) {
                controller.selectedAnswer.value = option;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(30),
                border: border,
              ),
              alignment: Alignment.center,
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}