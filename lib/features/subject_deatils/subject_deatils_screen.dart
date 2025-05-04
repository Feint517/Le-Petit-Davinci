import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/dictee_interactive_screen.dart';
import 'package:kids_learning_app/features/evaluations/quiz_choix_multiples/models/quiz_question.dart';
import 'package:kids_learning_app/features/evaluations/quiz_choix_multiples/screens/quiz_screen.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/features/subject_deatils/detail_introduction_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/category_card.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/learning_card.dart'; 
import 'package:kids_learning_app/features/subject_deatils/widgets/subject_description.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/sunject_stats_row.dart';
import 'package:kids_learning_app/features/subjects/learn_subject/AlphabetLesson.dart';
import 'package:kids_learning_app/features/subjects/learn_subject/ConstructionLesson.dart';
import 'package:kids_learning_app/features/subjects/learn_subject/VocabulaireLesson.dart'; 
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

import '../evaluations/exercices_appariement/screens/exercices_appariement_screen.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> lessonCards = [
      CategoryCard(
                            number: "01",
                            points: "40",
                            title: "Alphabet et Prononciation",
                            content: "5 Contenues",
                            time: "2 Heures 30 Minutes",
                            color: AppColors.purple,
                            onTap: () => Get.to(() => const AlphabetLessonScreen()),
                          ),
                          CategoryCard(
                            number: "02",
                            points: "35",
                            title: "Vocabulaire Thématique",
                            content: "4 Contenues",
                            time: "1 Heure 20 minutes",
                            color: AppColors.orange,
                            onTap: ()  => Get.to(() => const VocabulaireLessonScreen()),
                          ),
                          CategoryCard(
                            number: "03",
                            points: "52",
                            title: "Construction De Phrases Simples",
                            content: "6 Contenues",
                            time: "1 Heure 45 minutes",
                            color: AppColors.accent,
                            onTap: ()  => Get.to(() => const ConstructionLessonScreen()),
                          ),
    ];
    final List<Widget> practiceCards = [
      CategoryCard(
                          number: "01",
                          points: "20",
                          title: "Exercices d’écriture et de lecture",
                          content: "4 Exercices",
                          time: "2 Heures 50 Minutes",
                          color: AppColors.purple,
                          onTap: () { 
                          },
                        ),
                          CategoryCard(
                            number: "02",
                            points: "15",
                            title: "Activités d’association",
                            content: "4 Exercices",
                            time: "3 Heures 45 Minutes",
                            color: AppColors.orange,
                            onTap: () { 
                            },
                          ),
                          CategoryCard(
                            number: "03",
                            points: "52",
                            title: "Jeux de structuration de phrases",
                            content: "6 Exercices",
                            time: "3 Heures 30 Minutes",
                            color: AppColors.accent,
                            onTap: () { 
                            },
                          ),
    ];
    final List<Widget> quizCards = [
      CategoryCard(
                            number: "01",
                            points: "40",
                            title: "Dictées interactives",
                            content: "5 Contenues",
                            time: "2 Heures 30 Minutes",
                            color: AppColors.purple,
                            onTap: () => Get.to(() => const DicteeInteractiveScreen()),
                          ),
                          CategoryCard(
                            number: "02",
                            points: "35",
                            title: "Quiz à choix multiples",
                            content: "4 Contenues",
                            time: "1 Heure 20 minutes",
                            color: AppColors.orange,
                            onTap: () => Get.to(() => QuizScreen(
                              title: "Quiz à choix multiples",
                              questions: QuizQuestion.getSampleQuestions(),
                            )),
                          ),
                          CategoryCard(
                            number: "03",
                            points: "52",
                            title: "Exercices d'appariement",
                            content: "6 Contenues",
                            time: "1 Heure 45 minutes",
                            color: AppColors.accent,
                            onTap: () => Get.to(() => const ExercicesAppariementScreen()),
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
                        title: 'Apprendre - Français',
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
                        title: 'Pratiquer - Francais',
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
                        title: 'Évaluer - Français',
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
