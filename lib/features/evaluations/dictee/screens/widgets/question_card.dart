import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:kids_learning_app/features/evaluations/dictee/models/dictee_question.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/answer_area.dart';
//import 'package:kids_learning_app/features/evaluations/screens/widgets/dictee_header.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/word_bank.dart';


class QuestionCard extends StatelessWidget {
  final DicteeQuestion question;
  final List<String> selectedWords;
  final Function(String) onWordSelected;
  final Function(String) onWordRemoved;
  final VoidCallback onAudioPlay;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedWords,
    required this.onWordSelected,
    required this.onWordRemoved,
    required this.onAudioPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 433,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 41, top: 25),
            child: Row(
              children: [
                // "Le" text at the beginning of the answer area
                Text(
                  selectedWords.isEmpty ? "Le" : "",
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 18,
                    letterSpacing: -0.04 * 18,
                    color: Color(0xFF272727),
                  ),
                ),
              ],
            ),
          ),
          
          // Audio Button with Image
          Stack(
            alignment: Alignment.center,
            children: [
              // Character Image
              Image.asset(
                question.imagePath,
                height: 168,
                width: 105,
              ),
              
              // Audio button overlay
              Positioned(
                top: 25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: GestureDetector(
                  onTap: onAudioPlay,
                  child: Container(
                    width: 40,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Answer Area
          AnswerArea(
            selectedWords: selectedWords,
            onWordRemoved: onWordRemoved,
          ),
          
          const SizedBox(height: 30),
          
          // Word Bank
          WordBank(
            words: question.wordBank,
            selectedWords: selectedWords,
            onWordSelected: onWordSelected,
          ),
        ],
      ),
    );
  }
}