import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import 'option_item.dart';
import 'question_image.dart';

class QuestionBox extends StatelessWidget {
  final QuizQuestion question;
  final String? selectedAnswer;
  final Function(String) onOptionSelected;

  const QuestionBox({
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question text
          Text(
            question.question,
            style: const TextStyle(
              color: Color(0xFF494949), // Neutral Color/Dark Grey
              fontSize: 10,
              fontFamily: 'Archivo',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          
          // Question image
          QuestionImage(imagePath: question.imagePath),
          const SizedBox(height: 24),
          
          // Answer options
          ...question.options.map((option) => OptionItem(
            option: option,
            isSelected: selectedAnswer == option,
            onTap: () => onOptionSelected(option),
          )).toList(),
          
          // Astuce (Tip)
          const SizedBox(height: 24),
          const Text(
            '💡 Astuce : Ne te précipite pas ! Prends ton temps pour bien comprendre chaque question avant de choisir ta réponse.',
            style: TextStyle(
              color: Color(0xFF494949),
              fontSize: 10,
              fontFamily: 'Archivo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
