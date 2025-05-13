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
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.format_list_numbered_rounded,
            color: AppColors.primaryDeep,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '$currentQuestion/$totalQuestions',
            style: TextStyle(
              color: AppColors.primaryDeep,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
