// lib/features/home/screens/widgets/games_section.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/features/games/screens/games_list_screen.dart';
import 'package:kids_learning_app/features/home/screens/widgets/game_category_card.dart';
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
            const Text(
              "Catégories de jeux",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ShowAllButton(callback: () {}),
          ],
        ),
        const Gap(10),

        //* Game Category Cards
        // GameCategoryCard(
        //   title: 'Jeux de Stratégie',
        //   subtitle: 'Entraînez votre cerveau avec ces jeux',
        //   iconPath: IconAssets.echecs,
        //   color: AppColors.primaryDeep,
        //   gamesCount: 3,
        //   onTap: () => Get.to(() => const GamesListScreen(
        //     categoryTitle: 'Jeux de Stratégie',
        //     categoryColor: AppColors.primaryDeep,
        //   )),
        // ),
        
        // GameCategoryCard(
        //   title: 'Jeux de Réflexion',
        //   subtitle: 'Améliorez votre capacité à réfléchir rapidement',
        //   iconPath: IconAssets.ticTacToe,
        //   color: AppColors.accent,
        //   gamesCount: 2,
        //   onTap: () => Get.to(() => const GamesListScreen(
        //     categoryTitle: 'Jeux de Réflexion',
        //     categoryColor: AppColors.accent,
        //   )),
        // ),
        
        GameCategoryCard(
          title: 'Jeux d\'Arcade',
          subtitle: 'Des jeux classiques réinventés pour l\'apprentissage',
          iconPath: IconAssets.arcade_games,
          color: AppColors.secondary,
          gamesCount: 3,
          onTap: () => Get.to(() => const GamesListScreen(
            categoryTitle: 'Jeux d\'Arcade',
            categoryColor: AppColors.secondary,
          )),
        ),
      ],
    );
  }
}