import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/evaluations/controllers/multiple_choice/quiz_interactive_controller.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/dictation_interactive_screen.dart';
import 'package:kids_learning_app/features/evaluations/screens/multiple_choice/quiz_interactive_screen.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/exercices_appariement_screen.dart';
import 'package:kids_learning_app/features/lessons/screens/alphabets/alphabet_lesson.dart';
import 'package:kids_learning_app/features/lessons/screens/construction/construction_introduction_lesson.dart';
import 'package:kids_learning_app/features/lessons/screens/vocabulary/vocabulaire_lesson.dart';
import 'package:kids_learning_app/features/practice/screens/association/association_practice.dart';
import 'package:kids_learning_app/features/practice/screens/writing/writing_practice.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/category_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectDetailController extends GetxController {
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
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      points: "35",
      title: "Vocabulaire Thématique",
      content: "4 Contenues",
      time: "1 Heure 20 minutes",
      color: AppColors.orange,
      onTap: () => Get.to(() => const VocabularyLessonScreen()),
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "03",
      points: "52",
      title: "Construction De Phrases Simples",
      content: "6 Contenues",
      time: "1 Heure 45 minutes",
      color: AppColors.accent,
      onTap: () => Get.to(() =>  ConstructionIntroductionLesson()),
    ),
  ];
  final List<Widget> practiceCards = [
    CategoryCard(
      number: "01",
      title: "Exercices d'écriture et de lecture",
      content: "5 Contenu",
      time: "2 Heures 30 Minutes",
      points: '20',
      color: AppColors.primaryDeep,
      onTap: () => Get.to(() => const WritingPracticeScreen()),
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      title: "Activités d'association",
      content: "5 Contenu",
      time: "3 Heures 45 Minutes",
      points: '15',
      color: AppColors.secondary,
      onTap: () => Get.to(() => AssociationActivitiesScreen()),
    ),
    const Gap(AppSizes.spaceBtwItems),
    const CategoryCard(
      number: "03",
      title: "Jeux de structuration de phrases",
      content: "3 Contenu",
      time: "3 Heures 30 Minutes",
      points: '15',
      color: AppColors.accent,
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
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      points: "35",
      title: "Quiz Interactifs",
      content: "4 Contenues",
      time: "1 Heure 20 minutes",
      color: AppColors.orange,
      onTap: () {
        // Enregistrer le contrôleur de quiz interactif
        Get.put(QuizInteractiveController());
        // Naviguer vers l'écran de quiz interactif
        Get.to(() => const QuizInteractiveScreen());
      },
    ),
    const Gap(AppSizes.spaceBtwItems),
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
}