// lib/features/games/screens/games_list_screen.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/games/screens/snake/snake.dart';
import 'package:kids_learning_app/features/games/screens/tic-tac-toe/tic_tac_toe(updated).dart';
import 'package:kids_learning_app/features/home/screens/widgets/game_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class GamesListScreen extends StatelessWidget {
  const GamesListScreen({
    super.key,
    required this.categoryTitle,
    required this.categoryColor,
  });

  final String categoryTitle;
  final Color categoryColor;

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
              // Header with back button
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
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
                          categoryTitle,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'BricolageGrotesque',
                            color: categoryColor,
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
              ),
              
              const Gap(24),
              
              // Game cards list
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GameCard(
                      //   title: 'Échecs',
                      //   subtitle: 'Développez votre meilleure stratégie',
                      //   iconPath: IconAssets.echecs,
                      //   color: AppColors.primaryDeep,
                      // ),
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