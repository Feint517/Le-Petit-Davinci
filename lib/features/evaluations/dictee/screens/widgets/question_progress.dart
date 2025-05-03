import 'package:flutter/material.dart';

class QuestionProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  
  const QuestionProgress({
    Key? key,
    required this.currentQuestion,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Question $currentQuestion/$totalQuestions",
      style: const TextStyle(
        fontFamily: 'Archivo',
        fontSize: 10,
        color: Color(0xFF272727),
      ),
    );
  }
}