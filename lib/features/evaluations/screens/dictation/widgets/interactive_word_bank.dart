import 'package:flutter/material.dart';

class InteractiveWordBank extends StatelessWidget {
  final List<String> words;
  final List<String> selectedWords;
  final Function(String) onWordSelected;
  final bool isCheckingAnswer;
  final Map<String, Color> wordColors;

  const InteractiveWordBank({
    Key? key,
    required this.words,
    required this.selectedWords,
    required this.onWordSelected,
    this.isCheckingAnswer = false,
    required this.wordColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filtrer les mots qui ne sont pas déjà sélectionnés
    final availableWords = words.where((word) => !selectedWords.contains(word)).toList();
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFFD6C9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre pour la banque de mots
          const Padding(
            padding: EdgeInsets.only(
              left: 12,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Color(0xFFFF9E80),
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "Banque de mots",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A3EA1),
                  ),
                ),
              ],
            ),
          ),

          // Words container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF7F7FF),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: availableWords.map((word) {
                        return GestureDetector(
                          onTap: isCheckingAnswer ? null : () => onWordSelected(word),
                          child: Container(
                            margin: const EdgeInsets.only(right: 6, bottom: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: wordColors[word]?.withOpacity(0.6) ?? Colors.purple.shade100.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              word,
                              style: const TextStyle(
                                fontFamily: 'Bricolage Grotesque',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}