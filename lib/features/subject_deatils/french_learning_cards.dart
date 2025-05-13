import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/cheat_sheet_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/controllers/subject_detail_controller.dart';
import 'package:kids_learning_app/features/subject_deatils/detail_introduction_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/learning_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

final controller = Get.find<SubjectDetailController>();
List<Widget> frenchLearningCards = [
  LearningCard(
    title: 'Apprendre',
    description:
        'Présenter les notions de base avec des leçons interactives et du contenu audiovisuel.',
    stats: '10 Matériaux · 50 Contenu · 120 Heures',
    color: AppColors.primaryDeep,
    imagePath: ImageAssets.learn,
    onTap:
        () => Get.to(
          () => DetailIntroductionScreen(
            illustrationPath: ImageAssets.learn,
            introductionTitle: 'Catégories de leçons',
            totalLessons: 10,
            completedLessons: 3,
            cardsList: [...controller.lessonCards],
            title: 'Apprendre - Français',
          ),
        ),
  ),
  const Gap(AppSizes.spaceBtwItems),

  LearningCard(
    title: 'Pratiquer',
    description:
        'Permettre aux enfants d’appliquer ce qu’ils ont appris avec des exercices interactifs.',
    stats: '12 Pratiquer · 35 Exercices · 120 Heures',
    color: AppColors.secondary,
    imagePath: ImageAssets.practice,
    onTap:
        () => Get.to(
          () => DetailIntroductionScreen(
            title: 'Pratiquer - Francais',
            illustrationPath: ImageAssets.practice,
            introductionTitle: 'Exercices interactifs',
            totalLessons: 10,
            completedLessons: 7,
            cardsList: [...controller.practiceCards],
          ),
        ),
  ),
  const Gap(AppSizes.spaceBtwItems),

  LearningCard(
    title: 'Évaluer',
    description:
        'Tester les connaissances de l’enfant avec des quiz et des mini-jeux d’évaluation.',
    stats: '16 Quiz · 320 Question · 60 Heures',
    color: AppColors.accent,
    imagePath: ImageAssets.evaluate,
    onTap:
        () => Get.to(
          () => DetailIntroductionScreen(
            title: 'Évaluer - Français',
            illustrationPath: ImageAssets.evaluate,
            introductionTitle: "Types d’évaluations",
            totalLessons: 10,
            completedLessons: 1,
            cardsList: [...controller.quizCards],
          ),
        ),
  ),
  const Gap(AppSizes.spaceBtwItems),

  LearningCard(
    title: 'Aide-mémoire',
    description:
        'Fiches de référence pour un apprentissage rapide et efficace.',
    stats: '5 Fiches · 120 Mots · Référence Rapide',
    color: AppColors.accent2,
    imagePath: ImageAssets.cheat,
    onTap: () => Get.to(() => const CheatSheetScreen()),
  ),
];
