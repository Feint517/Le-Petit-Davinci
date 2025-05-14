import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_interactive_model.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/animated_audio_button.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/animated_progress_bar.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/interactive_answer_area.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/interactive_word_bank.dart';

// Dummy widgets pour compilation temporaire
// À supprimer quand les vrais widgets seront implémentés
class PlaceholderButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPlaying;
  final int repeatCount;

  const PlaceholderButton({
    super.key,
    required this.onTap,
    this.isPlaying = false,
    this.repeatCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_up_outlined),
    );
  }
}

class InteractiveQuestionCard extends StatelessWidget {
  final DicteeInteractiveModel question;
  final List<String> selectedWords;
  final Function(String) onWordSelected;
  final Function(String) onWordRemoved;
  final VoidCallback onAudioPlay;
  final bool isAudioPlaying;
  final bool isCheckingAnswer;
  final bool isCorrect;
  final bool showCelebration;
  final int audioPlayCount;
  final double progressValue;
  final Map<String, Color> wordColors;

  const InteractiveQuestionCard({
    super.key,
    required this.question,
    required this.selectedWords,
    required this.onWordSelected,
    required this.onWordRemoved,
    required this.onAudioPlay,
    required this.isAudioPlaying,
    this.isCheckingAnswer = false,
    this.isCorrect = false,
    this.showCelebration = false,
    required this.audioPlayCount,
    required this.progressValue,
    required this.wordColors,
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header area with title, difficulty, and progress
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                // Title and difficulty row
                Row(
                  children: [
                    // Title
                    Expanded(
                      child: Text(
                        question.title,
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),

                    // Difficulty badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(question.difficulty),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getDifficultyText(question.difficulty),
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // Progress bar
                const SizedBox(height: 10),
                AnimatedProgressBar(
                  progress: progressValue,
                  height: 8,
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  progressColor: Colors.deepPurple,
                  totalSteps: question.correctWords.length,
                  currentStep: selectedWords.length,
                ),
              ],
            ),
          ),

          // Content area with image, audio button, answer area and word bank
          Expanded(
            child: Column(
              children: [
                // Character image with audio button - reduced height
                SizedBox(
                  height: isSmallScreen ? 100 : 110,
                  child: Stack(
                    children: [
                      // Character Image positioned in the center
                      if (question.imagePath != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Hero(
                              tag: question.id,
                              child: Image.asset(
                                question.imagePath!,
                                fit: BoxFit.contain,
                                height: isSmallScreen ? 85 : 100,
                              ),
                            ),
                          ),
                        ),

                      // Audio button positioned at the top right
                      Positioned(
                        top: 10,
                        right: 10,
                        child: AnimatedAudioButton(
                          onTap: onAudioPlay,
                          isPlaying: isAudioPlaying,
                          repeatCount: audioPlayCount,
                        ),
                      ),
                    ],
                  ),
                ),

                // Flexible layout for answer and word bank areas
                Expanded(
                  child: Column(
                    children: [
                      // Answer Area
                      Expanded(
                        flex: isSmallScreen ? 3 : 4,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 0, 12, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InteractiveAnswerArea(
                            selectedWords: selectedWords,
                            onWordRemoved: onWordRemoved,
                            isCheckingAnswer: isCheckingAnswer,
                            isCorrect: isCorrect,
                            showCelebration: showCelebration,
                            correctWords: question.correctWords,
                            wordColors: wordColors,
                          ),
                        ),
                      ),

                      // Word Bank - larger flex value to make it more prominent
                      Expanded(
                        flex: isSmallScreen ? 4 : 5,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InteractiveWordBank(
                            words: question.wordBank,
                            selectedWords: selectedWords,
                            onWordSelected: onWordSelected,
                            isCheckingAnswer: isCheckingAnswer,
                            wordColors: wordColors,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for difficulty display
  Color _getDifficultyColor(DifficultySetting difficulty) {
    switch (difficulty) {
      case DifficultySetting.facile:
        return Colors.green;
      case DifficultySetting.moyen:
        return Colors.amber.shade700;
      case DifficultySetting.difficile:
        return Colors.red;
    }
  }

  String _getDifficultyText(DifficultySetting difficulty) {
    switch (difficulty) {
      case DifficultySetting.facile:
        return "Facile";
      case DifficultySetting.moyen:
        return "Moyen";
      case DifficultySetting.difficile:
        return "Difficile";
    }
  }
}
