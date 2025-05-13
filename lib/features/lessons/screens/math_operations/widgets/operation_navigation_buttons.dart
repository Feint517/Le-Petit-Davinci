import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class OperationNavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isFirstQuestion;
  final bool isLastQuestion;

  const OperationNavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    required this.isFirstQuestion,
    required this.isLastQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous button
        ElevatedButton(
          onPressed: isFirstQuestion ? null : onPrevious,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.orange,
            disabledBackgroundColor: Colors.white.withValues(alpha: 0.5),
            disabledForegroundColor: Colors.grey.withValues(alpha: 0.5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color:
                    isFirstQuestion
                        ? Colors.grey.withValues(alpha: 0.3)
                        : AppColors.orange.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color:
                    isFirstQuestion
                        ? Colors.grey.withValues(alpha: 0.5)
                        : AppColors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                'Précédent',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'BricolageGrotesque',
                  color:
                      isFirstQuestion
                          ? Colors.grey.withValues(alpha: 0.5)
                          : AppColors.orange,
                ),
              ),
            ],
          ),
        ),

        // Next/Check button
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            shadowColor: AppColors.orange.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isLastQuestion ? 'Terminer' : 'Vérifier',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'BricolageGrotesque',
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isLastQuestion
                    ? Icons.check_circle_outline
                    : Icons.arrow_forward_rounded,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
