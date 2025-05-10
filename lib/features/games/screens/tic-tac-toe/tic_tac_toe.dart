import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/games/controllers/tic_tac_toe/tic_tac_toe_controller.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/dialog_winner.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/game_board.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/game_controls.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/mode_selection_popup.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/progress_section.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/widgets/turn_indicator.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class TicTacToe extends GetView<TicTacToeController> {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TicTacToeController());

    //* Listen for winner state changes
    ever(controller.winnerO, (isWinner) {
      if (isWinner) {
        controller.playSound('winner.mp3');
        _showWinnerDialog(context, controller);
      }
    });

    ever(controller.winnerX, (isWinner) {
      if (isWinner) {
        controller.playSound('winner.mp3');
        _showGameOverDialog(context, controller);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            //* Main game content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  CommonHeader(pageTitle: 'Tic Tac Toe'),
                  const Gap(20),

                  ProgressSection(),

                  GameControls(),
                  const Gap(20),

                  TurnIndicator(),
                  const Gap(20),

                  GameBoard(),
                ],
              ),
            ),

            // Mode selection popup at the bottom
            Obx(
              () =>
                  controller.showModeSelection.value
                      ? ModeSelectionPopup()
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

void _showWinnerDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => CongratulationsDialog(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
  );
}

void _showGameOverDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => GameOverDialog(
          onPlayAgain: () {
            Navigator.pop(context);
            controller.clearGame();
          },
          onMenu: () {
            Navigator.pop(context);
            controller.backToMenu();
          },
        ),
  );
}

void _showDrawDialog(BuildContext context, TicTacToeController controller) {
  showDialog(
    context: context,
    builder:
        (context) => CongratulationsDialogEqual(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
  );
}


//TODO: Fix the issue where the draw screen doesn't show up
