import 'package:flutter/material.dart';

class QuizNavigator extends StatelessWidget {
  final VoidCallback? onPreviousQuiz;
  final VoidCallback? onNextQuiz;

  const QuizNavigator({
    super.key,
    this.onPreviousQuiz,
    this.onNextQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFC715A), // Main Color/Orange - Secondary
        borderRadius: BorderRadius.circular(80),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onPreviousQuiz,
            child: Row(
              children: const [
                Icon(Icons.arrow_back, size: 18),
                SizedBox(width: 2),
                Text(
                  'Quiz précédent',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 12,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onNextQuiz,
            child: Row(
              children: const [
                Text(
                  'Quiz suivant',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 12,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
