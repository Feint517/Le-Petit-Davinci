import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/games/controllers/tic_tac_toe/tic_tac_toe_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class DifficultyButton extends GetView<TicTacToeController> {
  const DifficultyButton(this.value, this.label, {super.key});


  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setDifficulty(value),
        child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white,
                width: 2,
              ),
              color:
                  controller.aiDifficulty.value == value
                      ? Colors.white
                      : AppColors.purple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'BricolageGrotesque',
                  color:
                      controller.aiDifficulty.value == value
                          ? AppColors.purple
                          : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}