import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/games/controllers/tic_tac_toe/tic_tac_toe_controller.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/board_size_dropdown.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class GameControls extends GetView<TicTacToeController> {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Sound toggle button
        Container(
          margin: const EdgeInsets.fromLTRB(15, 9, 0, 9),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Obx(() => IconButton(
              icon: Icon(
                controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                size: 24,
                color: Colors.white,
              ),
              onPressed: controller.toggleSound,
            ),
          ),
        ),
        
        BoardSizeDropdown(),
        
        //* Reset button
        GestureDetector(
          onTap: controller.clearGame,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 9, 15, 9),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.refresh_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}