import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/subject_deatils/controllers/math_detail_controller.dart';
import 'package:kids_learning_app/features/subject_deatils/detail_introduction_screen.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/cheat_sheet_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/learning_card.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/subject_description.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/sunbect_stats_row.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class MathDetailScreen extends GetView<MathDetailController> {
  const MathDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MathDetailController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(),
              const Gap(AppSizes.spaceBtwSections),

              // Custom Math subject description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mathématiques",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BricolageGrotesque',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Découvrez le monde fascinant des nombres, des formes et des opérations mathématiques de manière amusante et interactive.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSizes.spaceBtwSections),

              const SubjectStatsRow(),
              const Gap(AppSizes.spaceBtwSections),

              LearningCard(
                title: 'Apprendre',
                description:
                    'Découvrir les concepts de base des mathématiques avec des leçons interactives.',
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
                        title: 'Apprendre - Mathématiques',
                      ),
                    ),
              ),
              const Gap(AppSizes.spaceBtwItems),

              LearningCard(
                title: 'Pratiquer',
                description:
                    'Renforcez votre compréhension des mathématiques avec des exercices interactifs et ludiques.',
                stats: '12 Pratiquer · 35 Exercices · 120 Heures',
                color: AppColors.secondary,
                imagePath: ImageAssets.practice,
                onTap:
                    () => Get.to(
                      () => DetailIntroductionScreen(
                        title: 'Pratiquer - Mathématiques',
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
                    'Testez vos connaissances mathématiques avec des quiz et des problèmes à résoudre.',
                stats: '16 Quiz · 320 Question · 60 Heures',
                color: AppColors.accent,
                imagePath: ImageAssets.evaluate,
                onTap:
                    () => Get.to(
                      () => DetailIntroductionScreen(
                        title: 'Évaluer - Mathématiques',
                        illustrationPath: ImageAssets.evaluate,
                        introductionTitle: "Types d'évaluations",
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
                    'Fiches de référence pour les formules et concepts mathématiques essentiels.',
                stats: '5 Fiches · 120 Formules · Référence Rapide',
                color: AppColors.accent2,
                imagePath: ImageAssets.cheat,
                onTap: () => Get.to(() => const CheatSheetScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}