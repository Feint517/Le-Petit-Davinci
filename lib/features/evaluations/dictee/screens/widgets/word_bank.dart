import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/word_chip.dart';

class WordBank extends StatelessWidget {
  final List<String> words;
  final List<String> selectedWords;
  final Function(String) onWordSelected;
  
  const WordBank({
    Key? key,
    required this.words,
    required this.selectedWords,
    required this.onWordSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: words.map((word) {
          final isSelected = selectedWords.contains(word);
          return WordChip(
            text: word,
            isSelected: isSelected,
            onTap: () {
              if (!isSelected) {
                onWordSelected(word);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}