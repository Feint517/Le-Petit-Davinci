import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/features/games/views/snake/snake.dart';
import 'package:kids_learning_app/features/games/views/tic-tac-toe/tic_tac_toe(updated).dart';
import 'package:kids_learning_app/features/home/screens/widgets/game_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class GamesSection extends StatelessWidget {
  const GamesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Choisissez des jeux éducatifs",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ShowAllButton(callback: () {}),
          ],
        ),
        const Gap(10),

        //* Game Cards
        GameCard(
          title: 'Échecs',
          subtitle: 'Développez votre meilleure stratégie',
          iconPath: IconAssets.echecs,
          color: AppColors.primaryDeep,
        ),
        GameCard(
          title: 'Tic-Tac-Toe',
          subtitle: 'Développez votre meilleure stratégie',
          iconPath: IconAssets.ticTacToe,
          color: AppColors.accent,
          onTap: () => Get.to(() => const TicTacToe()),
        ),
        GameCard(
          title: 'Serpents et échelles',
          subtitle: 'Développez votre meilleure stratégie',
          iconPath: IconAssets.echles,
          color: AppColors.secondary,
          onTap: () => Get.to(() => const SnakeGame()),
        ),
      ],
    );
  }
}
