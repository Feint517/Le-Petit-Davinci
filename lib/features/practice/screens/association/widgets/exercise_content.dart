// Update to exercise_content.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/animated_score_display.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_eight_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_five_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_one_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_seven_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_six_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_three_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_two_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/series/series_four_content.dart'; // New import

class ExerciseContent extends GetView<AssociationController> {
  const ExerciseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.purple.withOpacity(0.2), width: 2),
      ),
      duration: const Duration(milliseconds: 300),
      child: Obx(() {
        // Show the appropriate content based on the series
        if (controller.isInSeriesEight) {
          return const SeriesEightContent();
        } else if (controller.isInSeries7) {
          return const SeriesSevenContent();
        } else if (controller.isInSeries6) {
          return SeriesSixContent();
        } else if (controller.isInSeries5) {
          return const SeriesFiveContent();
        } else if (controller.isInSeries4) {
          return const SeriesFourContent();
        } else if (controller.isInSeries3) {
          return const SeriesThreeContent();
        } else if (controller.isInSeries2) {
          return const SeriesTwoContent();
        } else {
          return const SeriesOneContent();
        }
      }),
    );
  }
}
