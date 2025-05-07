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
                Icon(Icons.arrow_back, size: 18, color: Color(0xFF272727)),
                SizedBox(width: 2),
                Text(
                  'Quiz précédent',
                  style: TextStyle(
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
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
                    fontFamily: 'Archivo',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.arrow_forward, size: 18, color: Color(0xFF272727)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
