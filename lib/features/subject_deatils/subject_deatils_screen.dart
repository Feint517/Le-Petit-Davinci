import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/features/subject_deatils/detail_introduction_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/learning_card.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/lesson_category_card.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/subject_description.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/sunject_stats_row.dart';
import 'package:kids_learning_app/features/subjects/evaluate_details.dart';
import 'package:kids_learning_app/features/subjects/learn_subject.dart';
import 'package:kids_learning_app/features/subjects/practice_deatils.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> lessonCards = [
      LessonCategoryCard(
        number: "01",
        title: "Alphabet & Prononciation",
        content: "5 Contenu",
        time: "2 Heures 30 Minutes",
        points: 40,
        backgroundColor: AppColors.primaryDeep,
        onTap: () => Get.to(() => const AlphabetLessonScreen()),
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "02",
        title: "Vocabulaire Thématique",
        content: "4 Contenu",
        time: "1 Heures 20 Minutes",
        points: 35,
        backgroundColor: AppColors.secondary,
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "03",
        title: "Construction De Phrases Simples",
        content: "6 Contenu",
        time: "1 Heures 45 Minutes",
        points: 52,
        backgroundColor: AppColors.accent,
      ),
    ];
    final List<Widget> practiceCards = [
      LessonCategoryCard(
        number: "01",
        title: "Exercices d’écriture et de lecture",
        content: "5 Contenu",
        time: "2 Heures 30 Minutes",
        points: 20,
        backgroundColor: AppColors.primaryDeep,
        onTap: () => Get.to(() => const WritingPracticeScreen()),
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "02",
        title: "Activités d'association",
        content: "5 Contenu",
        time: "3 Heures 45 Minutes",
        points: 15,
        backgroundColor: AppColors.secondary,
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "03",
        title: "Jeux de structuration de phrases",
        content: "3 Contenu",
        time: "3 Heures 30 Minutes",
        points: 15,
        backgroundColor: AppColors.accent,
      ),
    ];
    final List<Widget> quizCards = [
      LessonCategoryCard(
        number: "01",
        title: "Dictées interactives",
        content: "5 Contenu",
        time: "2 Heures 30 Minutes",
        points: 60,
        backgroundColor: AppColors.primaryDeep,
        onTap: () => Get.to(() => const QuizEvaluationScreen()),
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "02",
        title: "Quiz à choix multiples",
        content: "4 Contenu",
        time: "2 Heures 30 Minutes",
        points: 48,
        backgroundColor: AppColors.secondary,
      ),
      const Gap(AppSizes.spaceBtwItems),
      const LessonCategoryCard(
        number: "03",
        title: "Exercices d'appariement",
        content: "6 Contenu",
        time: "2 Heures 30 Minutes",
        points: 55,
        backgroundColor: AppColors.accent,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(activeIcon: false),
              const Gap(AppSizes.spaceBtwSections),

              SubjectDescription(),
              const Gap(AppSizes.spaceBtwSections),

              const SubjectStatsRow(),
              const Gap(AppSizes.spaceBtwSections),

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
                        lessonCards: [...lessonCards],
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
                        illustrationPath: ImageAssets.practice,
                        introductionTitle: 'Exercices interactifs',
                        totalLessons: 10,
                        completedLessons: 7,
                        lessonCards: [...practiceCards],
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
                        illustrationPath: ImageAssets.evaluate,
                        introductionTitle: "Types d’évaluations",
                        totalLessons: 10,
                        completedLessons: 1,
                        lessonCards: [...quizCards],
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
