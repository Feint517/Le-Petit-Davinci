import 'package:flutter/material.dart';

class InteractiveAnswerArea extends StatelessWidget {
  final List<String> selectedWords;
  final Function(String) onWordRemoved;
  final bool isCheckingAnswer;
  final bool isCorrect;
  final bool showCelebration;
  final List<String> correctWords;
  final Map<String, Color> wordColors;

  const InteractiveAnswerArea({
    Key? key,
    required this.selectedWords,
    required this.onWordRemoved,
    this.isCheckingAnswer = false,
    this.isCorrect = false,
    this.showCelebration = false,
    required this.correctWords,
    required this.wordColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre discret
          const Padding(
            padding: EdgeInsets.only(left: 12, top: 4, bottom: 2),
            child: Row(
              children: [
                Icon(
                  Icons.edit_note_rounded, 
                  color: Colors.purple,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "Compose ta phrase",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          
          // Zone de réponse
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCorrect ? Colors.green : (isCheckingAnswer && !isCorrect ? Colors.red : const Color(0xFFE5CBFF)),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  // Contenu normal
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: selectedWords.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Clique sur les mots pour former la phrase",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Bricolage Grotesque',
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              )
                            : Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.center,
                                children: selectedWords.map((word) {
                                  return GestureDetector(
                                    onTap: isCheckingAnswer ? null : () => onWordRemoved(word),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: wordColors[word] ?? Colors.purple.shade100,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        word,
                                        style: const TextStyle(
                                          fontFamily: 'Bricolage Grotesque',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                    ),
                  ),
                  
                  // Overlay for checking status
                  if (isCheckingAnswer)
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.5),
                        child: Center(
                          child: Icon(
                            isCorrect ? Icons.check_circle_outline : Icons.error_outline,
                            color: isCorrect ? Colors.green : Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    
                  // Overlay for celebration
                  if (showCelebration)
                    Positioned.fill(
                      child: Container(
                        color: Colors.yellow.withOpacity(0.2),
                        child: const Center(
                          child: Icon(
                            Icons.celebration,
                            color: Colors.amber,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Lignes décoratives
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Première ligne
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: const Color(0xFFE5CBFF),
                  ),
                  const SizedBox(height: 8),
                  // Deuxième ligne
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