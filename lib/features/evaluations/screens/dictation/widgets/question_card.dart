import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_question.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/answer_area.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/word_bank.dart';

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
    // Check if we need to adjust layout for small screens
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.purple.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Content area with positioned audio icon - reduced height
          SizedBox(
            height: isSmallScreen ? 110 : 130,
            child: Stack(
              children: [
                // Character Image positioned in the center
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Hero(
                      tag: question.id,
                      child: Image.asset(
                        question.imagePath,
                        fit: BoxFit.contain,
                        height: isSmallScreen ? 100 : 120,
                      ),
                    ),
                  ),
                ),
                
                // Audio icon positioned at the top right
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onAudioPlay,
                      borderRadius: BorderRadius.circular(30),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7E5FF),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.volume_up_rounded,
                            color: Colors.purple,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Flexible layout for answer and word bank areas
          Expanded(
            child: Column(
              children: [
                // Answer Area - adaptive flex based on screen size
                Expanded(
                  flex: isSmallScreen ? 3 : 4,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE5CBFF),
                        width: 2,
                      ),
                    ),
                    child: AnswerArea(
                      selectedWords: selectedWords,
                      onWordRemoved: onWordRemoved,
                    ),
                  ),
                ),
                
                // Word Bank - larger flex value to make it more prominent
                Expanded(
                  flex: isSmallScreen ? 4 : 5,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFD6C9),
                        width: 2,
                      ),
                    ),
                    child: WordBank(
                      words: question.wordBank,
                      selectedWords: selectedWords,
                      onWordSelected: onWordSelected,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}