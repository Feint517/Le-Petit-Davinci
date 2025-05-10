// lib/features/games/screens/games_list_screen.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/games/screens/snake/snake.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/tic_tac_toe.dart';
import 'package:kids_learning_app/features/home/screens/widgets/game_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(
                pageTitle: "Jeux d'arcade",
                trailing: CircleAvatar(
                  backgroundImage: AssetImage(IconAssets.avatar),
                  radius: 24,
                ),
              ),
              const Gap(24),

              //* Game cards list
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GameCard(
                        title: 'Tic-Tac-Toe',
                        subtitle: 'Développez votre meilleure stratégie',
                        iconPath: IconAssets.ticTacToe,
                        color: AppColors.accent,
                        onTap: () => Get.to(() => const TicTacToe()),
                      ),
                      GameCard(
                        title: 'Serpent',
                        subtitle: 'Développez votre meilleure stratégie',
                        iconPath: IconAssets.snake_game,
                        color: AppColors.secondary,
                        onTap: () => Get.to(() => const SnakeGame()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
