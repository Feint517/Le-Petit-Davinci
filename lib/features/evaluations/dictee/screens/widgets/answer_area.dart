import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/word_chip.dart';

class AnswerArea extends StatelessWidget {
  final List<String> selectedWords;
  final Function(String) onWordRemoved;
  
  const AnswerArea({
    Key? key,
    required this.selectedWords,
    required this.onWordRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 16, bottom: 20),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: selectedWords.map((word) {
                return WordChip(
                  text: word,
                  isSelected: true,
                  isInAnswer: true,
                  onTap: () => onWordRemoved(word),
                );
              }).toList(),
            ),
          ),
          // Decorative lines representing blank spaces for words
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // First line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFF494949),
                  margin: const EdgeInsets.only(bottom: 20),
                ),
                // Second line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFF494949),
                  margin: const EdgeInsets.only(bottom: 20),
                ),
                // Third line (shorter)
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 1,
                  color: const Color(0xFF494949),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}