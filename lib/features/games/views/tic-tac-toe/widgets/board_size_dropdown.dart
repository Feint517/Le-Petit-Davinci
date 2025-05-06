import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/games/controllers/tic_tac_toe/tic_tac_toe_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class BoardSizeDropdown extends GetView<TicTacToeController> {
  const BoardSizeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.kDarkBlue,
        border: Border.all(color: AppColors.purple, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() => DropdownButton<String>(
          items: [
            DropdownMenuItem(
              value: '3',
              child: Text(
                '3 x 3',
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownMenuItem(
              value: '4',
              child: Text(
                '4 x 4',
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.changeBoardSize(int.parse(value));
            }
          },
          dropdownColor: AppColors.kDarkBlue,
          isExpanded: false,
          value: controller.boardSize.toString(),
          iconSize: 30,
          iconEnabledColor: AppColors.kWhite,
          focusColor: AppColors.kBlue,
          borderRadius: BorderRadius.circular(10),
          underline: Container(height: 0),
        ),
      ),
    );
  }
}