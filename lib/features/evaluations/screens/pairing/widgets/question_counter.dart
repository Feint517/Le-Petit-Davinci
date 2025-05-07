import 'package:flutter/material.dart';

class QuestionCounter extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;

  const QuestionCounter({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Question $currentIndex/$totalQuestions",
      style: const TextStyle(
        fontFamily: 'Archivo',
        fontSize: 10,
        color: Color(0xFF272727),
      ),
    );
  }
}
