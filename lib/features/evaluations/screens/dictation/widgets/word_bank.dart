import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/word_chip.dart';

class WordBank extends StatelessWidget {
  final List<String> words;
  final List<String> selectedWords;
  final Function(String) onWordSelected;
  
  const WordBank({
    super.key,
    required this.words,
    required this.selectedWords,
    required this.onWordSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Check for small screen to adjust spacing
    final isSmallScreen = MediaQuery.of(context).size.height < 700;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the word bank (more compact)
          Padding(
            padding: EdgeInsets.only(
              left: 12, 
              top: isSmallScreen ? 4 : 6, 
              bottom: isSmallScreen ? 2 : 4
            ),
            child: const Row(
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
          
          // Words container - maximizes available space
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF7F7FF),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                  child: Center(
                    child: Wrap(
                      spacing: isSmallScreen ? 6 : 8,
                      runSpacing: isSmallScreen ? 6 : 8,
                      alignment: WrapAlignment.center,
                      children: words.map((word) {
                        final isSelected = selectedWords.contains(word);
                        return Transform.scale(
                          // Slightly smaller chips on small screens
                          scale: isSmallScreen ? 0.95 : 1.0,
                          child: WordChip(
                            text: word,
                            isSelected: isSelected,
                            onTap: () {
                              if (!isSelected) {
                                onWordSelected(word);
                              }
                            },
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