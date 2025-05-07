// lib/utils/popups/lesson_result_helper.dart
import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/feedback/lesson_result_screen.dart';

class LessonResultHelper {
  static void showResultScreen({
    required BuildContext context,
    required bool isPerfect,
    required int totalXp,
    required int correctAnswers,
    required int totalQuestions,
    required VoidCallback onContinue,
    String? customMessage,
  }) {
    // Push a new route
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          return LessonResultScreen(
            isPerfect: isPerfect,
            totalXp: totalXp,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions,
            onContinue: () {
              // Pop the result screen first
              Navigator.of(context).pop();
              // Then call the provided callback
              onContinue();
            },
            customMessage: customMessage,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Fade transition
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}