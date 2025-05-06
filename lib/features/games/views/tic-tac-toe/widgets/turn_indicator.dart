import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/games/controllers/tic_tac_toe/tic_tac_toe_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class TurnIndicator extends GetView<TicTacToeController> {
  const TurnIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.isTurnO.value ? 'Tour du joueur' : ' Tour du joueur ',
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.orange,
              fontFamily: 'BricolageGrotesque',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Image.asset(
            controller.isTurnO.value
                ? 'assets/images/tictactoe/o.png'
                : 'assets/images/tictactoe/black-X.png',
            height: 30,
            width: 30,
          ),
        ],
      ),
    );
  }
}