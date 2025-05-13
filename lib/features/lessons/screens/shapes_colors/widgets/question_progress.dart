import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class QuestionProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuestionProgress({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress icon
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.quiz_rounded,
              color: AppColors.accent,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),

          // Progress text
          Text(
            '$currentQuestion/$totalQuestions',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}
