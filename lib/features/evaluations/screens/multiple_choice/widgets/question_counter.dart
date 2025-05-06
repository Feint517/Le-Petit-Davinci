import 'package:flutter/material.dart';

class QuestionCounter extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;
  final int points;

  const QuestionCounter({
    Key? key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Question ${currentIndex + 1}/$totalQuestions',
          style: const TextStyle(
            color: Color(0xFF272727),
            fontSize: 10,
            fontFamily: 'Archivo',
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFDCFFE), // Main Color/Pink
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            'Obtenez $points points',
            style: const TextStyle(
              color: Color(0xFFFC715A), // Main Color/Orange - Secondary
              fontSize: 10,
              fontFamily: 'Archivo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
