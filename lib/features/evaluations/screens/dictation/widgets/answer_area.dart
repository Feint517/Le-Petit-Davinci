import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/word_chip.dart';

class AnswerArea extends StatelessWidget {
  final List<String> selectedWords;
  final Function(String) onWordRemoved;

  const AnswerArea({
    super.key,
    required this.selectedWords,
    required this.onWordRemoved,
  });

  @override
  Widget build(BuildContext context) {
    // Check for small screen to adjust spacing
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 6,
        vertical: isSmallScreen ? 2 : 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected words area (expanded to take most of the space)
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Center(
                  child:
                      selectedWords.isEmpty
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Using a different icon instead of the missing giraffe image
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.amber,
                                size: isSmallScreen ? 24 : 28,
                              ),
                              Gap(isSmallScreen ? 4 : 6),
                              const Text(
                                "Choisis les mots",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Bricolage Grotesque',
                                  fontSize: 13,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          )
                          : Wrap(
                            spacing: isSmallScreen ? 5 : 8,
                            runSpacing: isSmallScreen ? 5 : 8,
                            alignment: WrapAlignment.center,
                            children:
                                selectedWords.map((word) {
                                  return WordChip(
                                    text: word,
                                    isSelected: true,
                                    isInAnswer: true,
                                    onTap: () => onWordRemoved(word),
                                  );
                                }).toList(),
                          ),
                ),
              ),
            ),
          ),

          // Decorative lines - reduced vertical height
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First line - simplified
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: const Color(0xFFE5CBFF),
                  ),
                  Gap(isSmallScreen ? 6 : 8),

                  // Second line
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: const Color(0xFFE5CBFF),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
