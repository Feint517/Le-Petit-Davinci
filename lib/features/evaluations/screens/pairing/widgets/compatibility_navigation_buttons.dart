import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/widgets/navigation_buttons.dart';

/// Version compatible de NavigationButtons pour maintenir la rétrocompatibilité
/// avec l'ancien code dans exercices_appariement_screen.dart
class CompatibilityNavigationButtons extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool isFirstQuestion;
  final bool isLastQuestion;

  const CompatibilityNavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
  });

  @override
  Widget build(BuildContext context) {
    // Utilise la nouvelle implémentation tout en masquant les nouveaux paramètres
    return NavigationButtons(
      onPrevious: onPrevious,
      onNext: onNext,
      isFirstQuestion: isFirstQuestion,
      isLastQuestion: isLastQuestion,
      hasStartedExercice: false,
      isCheckingAnswer: false,
    );
  }
}