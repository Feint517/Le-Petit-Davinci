import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/counting_lesson_screen.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/math_operation_screen.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/shapes_colors_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/category_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class MathDetailController extends GetxController {
  final List<Widget> lessonCards = [
    CategoryCard(
      number: "01",
      points: "40",
      title: "Les nombres et le comptage",
      content: "5 Contenues",
      time: "2 Heures 30 Minutes",
      color: AppColors.purple,
      onTap: () => Get.to(() => const CountingLessonScreen()),
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      points: "35",
      title: "Addition et Soustraction",
      content: "6 Contenues",
      time: "1 Heure 20 minutes",
      color: AppColors.orange,
      onTap: () => Get.to(() => const MathOperationScreen()),
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "03",
      points: "52",
      title: "Formes et Couleurs",
      content: "10 Contenues",
      time: "1 Heure 45 minutes",
      color: AppColors.accent,
      onTap: () => Get.to(() => const ShapesColorsScreen()),
    ),
  ];
  
  final List<Widget> practiceCards = [
    CategoryCard(
      number: "01",
      title: "Exercices de comptage",
      content: "5 Contenu",
      time: "2 Heures 30 Minutes",
      points: '20',
      color: AppColors.primaryDeep,
      onTap: () {
        // Will be connected to math practices later
      },
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      title: "Calcul mental",
      content: "5 Contenu",
      time: "3 Heures 45 Minutes",
      points: '15',
      color: AppColors.secondary,
      onTap: () {
        // Will be connected to math practices later
      },
    ),
    const Gap(AppSizes.spaceBtwItems),
    const CategoryCard(
      number: "03",
      title: "Reconnaissance des formes",
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
      title: "Quiz de comptage",
      content: "5 Contenues",
      time: "2 Heures 30 Minutes",
      color: AppColors.purple,
      onTap: () {
        // Will be connected to math quizzes later
      },
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "02",
      points: "35",
      title: "Problèmes mathématiques",
      content: "4 Contenues",
      time: "1 Heure 20 minutes",
      color: AppColors.orange,
      onTap: () {
        // Will be connected to math quizzes later
      },
    ),
    const Gap(AppSizes.spaceBtwItems),
    CategoryCard(
      number: "03",
      points: "52",
      title: "Exercices de comparaison",
      content: "6 Contenues",
      time: "1 Heure 45 minutes",
      color: AppColors.accent,
      onTap: () {
        // Will be connected to math quizzes later
      },
    ),
  ];
}