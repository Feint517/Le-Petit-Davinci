import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/dictee_interactive_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/category_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class EvaluationCards {
  static List<Widget> getDicteeCards() {
    return [
      CategoryCard(
        number: "01",
        points: "30",
        title: "Dictées interactives",
        content: "5 Exercices",
        time: "30 Minutes",
        color: AppColors.purple,
        onTap: () => Get.to(() => const DicteeInteractiveScreen()),
      ),
      CategoryCard(
        number: "02",
        points: "25",
        title: "Quiz à choix multiples",
        content: "4 Exercices",
        time: "25 Minutes",
        color: AppColors.orange,
        onTap: () {
          // Navigate to your multiple choice quiz screen
        },
      ),
      CategoryCard(
        number: "03",
        points: "35",
        title: "Exercices d'association",
        content: "6 Exercices",
        time: "40 Minutes",
        color: AppColors.accent,
        onTap: () {
          // Navigate to your matching exercises screen
        },
      ),
    ];
  }
}