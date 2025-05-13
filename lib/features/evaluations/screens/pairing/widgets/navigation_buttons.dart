import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback? onReset;
  final bool isFirstQuestion;
  final bool isLastQuestion;
  final bool hasStartedExercice;
  final bool isCheckingAnswer;

  const NavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    this.onReset,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
    this.hasStartedExercice = false,
    this.isCheckingAnswer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous button
        Expanded(
          child: ElevatedButton(
            onPressed: isFirstQuestion || isCheckingAnswer ? null : onPrevious,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF9281FF,
              ), // Main Color/Purple - Primary
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF272727),
                  size: 14,
                ),
                Gap(6),
                Text(
                  "Précédent",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Gap(10),

        // Reset button
        if (hasStartedExercice && onReset != null && !isCheckingAnswer)
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: onReset,
              icon: const Icon(Icons.refresh_rounded, color: Colors.red),
              tooltip: "Recommencer",
            ),
          ),

        if (hasStartedExercice && onReset != null && !isCheckingAnswer)
          const Gap(10),

        // Next button
        Expanded(
          child: ElevatedButton(
            onPressed: isCheckingAnswer ? null : onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF13BB87), // Main Color/Green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastQuestion ? "Terminer" : "Suivant",
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
                const Gap(6),
                Icon(
                  isLastQuestion
                      ? Icons.check_circle
                      : Icons.arrow_forward_rounded,
                  color: const Color(0xFF272727),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
