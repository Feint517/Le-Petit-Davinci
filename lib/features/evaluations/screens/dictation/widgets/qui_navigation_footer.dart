import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class QuizNavigationFooter extends StatelessWidget {
  final VoidCallback onPreviousQuiz;
  final VoidCallback onNextQuiz;
  
  const QuizNavigationFooter({
    Key? key,
    required this.onPreviousQuiz,
    required this.onNextQuiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous quiz button
          GestureDetector(
            onTap: onPreviousQuiz,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF272727),
                  size: 18,
                ),
                const SizedBox(width: 2),
                Text(
                  "Quiz précédent",
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
              ],
            ),
          ),
          
          // Next quiz button
          GestureDetector(
            onTap: onNextQuiz,
            child: Row(
              children: [
                Text(
                  "Quiz suivant",
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF272727),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}