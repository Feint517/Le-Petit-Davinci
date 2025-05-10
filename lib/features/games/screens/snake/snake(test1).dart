import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/games/controllers/snake/snake_game_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX dependency injection
    final SnakeController controller = Get.put(SnakeController());

    return Scaffold(
      backgroundColor: AppColors.light,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AnimatedBuilder(
          animation: controller.backgroundColorAnimation,
          builder: (context, child) {
            return Container(
              decoration: const BoxDecoration(),
              child: SafeArea(
                child: Column(
                  children: [
                    _buildHeader(context),

                    const Gap(20),
                    _buildProgressSection(controller),

                    // Header with sound control
                    _buildSoundControl(controller),

                    // Game board
                    _buildGameBoard(controller),

                    // Control buttons
                    _buildControlButtons(controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      // Mode selection popup at the bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () =>
            controller.showModeSelection.value
                ? _buildModeSelectionPopup(controller)
                : const SizedBox(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Retour',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'BricolageGrotesque',
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Snake Game',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BricolageGrotesque',
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundImage: AssetImage(IconAssets.avatar),
          radius: 24,
        ),
      ],
    );
  }

  Widget _buildProgressSection(SnakeController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Niveau Maitre 🔥',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () =>
                  !controller.showModeSelection.value
                      ? Text(
                        'Score: ${controller.score.value}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BricolageGrotesque',
                          color: AppColors.accent,
                        ),
                      )
                      : Text(
                        '1542',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BricolageGrotesque',
                          color: AppColors.accent,
                        ),
                      ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: LinearProgressIndicator(
            value: 0.68, // Replace with your value
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation(AppColors.accent),
            minHeight: 16,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget _buildSoundControl(SnakeController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 9, 0, 9),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Obx(
              () => IconButton(
                icon: Icon(
                  controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: controller.toggleSound,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(SnakeController controller) {
    return Expanded(
      child: Center(
        child: AspectRatio(
          // Using a square aspect ratio for the game board
          aspectRatio: 1.1,
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green[100],
              border: Border.all(color: AppColors.accent, width: 3),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Obx(
              () => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: SnakeController.squaresPerRow,
                ),
                itemCount:
                    SnakeController.squaresPerRow *
                    SnakeController.squaresPerCol,
                itemBuilder: (context, index) {
                  if (controller.snake.isNotEmpty &&
                      controller.snake.first == index) {
                    // Snake head
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.buttonPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  } else if (controller.snake.contains(index)) {
                    // Snake body
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.buttonPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  } else if (controller.food.value == index) {
                    // Food (apple)
                    return Center(
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: FittedBox(
                          child: Image.asset(
                            'assets/images/tictactoe/apple.png',
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Empty space
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButtons(SnakeController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Up button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ControlButton(
                icon: Icons.arrow_upward,
                onPressed: () => controller.changeDirection('up'),
              ),
            ],
          ),
          // Left, right buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ControlButton(
                icon: Icons.arrow_back,
                onPressed: () => controller.changeDirection('left'),
              ),
              const Gap(70),
              ControlButton(
                icon: Icons.arrow_forward,
                onPressed: () => controller.changeDirection('right'),
              ),
            ],
          ),
          // Down button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ControlButton(
                icon: Icons.arrow_downward,
                onPressed: () => controller.changeDirection('down'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeSelectionPopup(SnakeController controller) {
    return SlideTransition(
      position: controller.slideAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sélectionner le mode',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(15),

            Obx(
              () => Row(
                children: [
                  _buildDifficultyButton(controller, 'easy', 'Facile'),
                  const Gap(10),
                  _buildDifficultyButton(controller, 'medium', 'Moyen'),
                  const Gap(10),
                  _buildDifficultyButton(controller, 'hard', 'Difficile'),
                ],
              ),
            ),

            const Gap(15),

            Text(
              'Jeu du Serpent',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Bienvenue dans le jeu du Serpent ! Dirigez votre serpent pour manger des pommes et grandir. Attention à ne pas heurter les murs ou votre propre queue ! Plus le niveau est difficile, plus le serpent se déplace rapidement. Bonne chance !',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'BricolageGrotesque',
                color: AppColors.white,
              ),
            ),
            const Gap(25),
            Center(
              child: GestureDetector(
                onTap: controller.startGame,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.accent3,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.buttonSecondary.withValues(alpha: 0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Démarrer le jeu',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'BricolageGrotesque',
                          color: Colors.black,
                        ),
                      ),
                      const Gap(8),
                      const Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.black,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
    SnakeController controller,
    String value,
    String label,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setDifficulty(value),
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.white, width: 2),
              color:
                  controller.difficulty.value == value
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
                      controller.difficulty.value == value
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

  void _showGameOverDialog(BuildContext context, SnakeController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Game Over!',
              style: TextStyle(
                fontFamily: 'BricolageGrotesque',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Score: ${controller.score.value}',
                  style: TextStyle(
                    fontFamily: 'BricolageGrotesque',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.startGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                      fontFamily: 'BricolageGrotesque',
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.returnToMenu();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontFamily: 'BricolageGrotesque',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ControlButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}