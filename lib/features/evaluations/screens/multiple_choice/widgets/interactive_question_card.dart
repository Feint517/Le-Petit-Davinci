import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kids_learning_app/features/evaluations/models/multiple_choice/quiz_interactive_model.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/animated_audio_button.dart';

class InteractiveQuestionCard extends StatelessWidget {
  final QuizInteractiveModel quiz;
  final String selectedAnswer;
  final Function(String) onOptionSelected;
  final VoidCallback onAudioPlay;
  final bool isAudioPlaying;
  final bool isCheckingAnswer;
  final bool isCorrect;
  final bool showCelebration;
  final Map<String, List<String>> categorizedItems;
  final Function(String, String) onCategoryAssign;
  final Map<String, Color> optionColors;

  const InteractiveQuestionCard({
    super.key,
    required this.quiz,
    required this.selectedAnswer,
    required this.onOptionSelected,
    required this.onAudioPlay,
    required this.isAudioPlaying,
    this.isCheckingAnswer = false,
    this.isCorrect = false,
    this.showCelebration = false,
    required this.categorizedItems,
    required this.onCategoryAssign,
    required this.optionColors,
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
            color: Colors.deepPurple.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Header area with title, difficulty, and question
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.05),
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
                            quiz.title,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(quiz.difficulty),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getDifficultyText(quiz.difficulty),
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
                    
                    // Question text
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      child: Text(
                        quiz.question,
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content area with image, audio button, and options
              Expanded(
                child: Column(
                  children: [
                    // Image with audio button - reduced height
                    if (quiz.imagePath != null)
                      SizedBox(
                        height: isSmallScreen ? 120 : 140,
                        child: Stack(
                          children: [
                            // Image positioned in the center
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Hero(
                                  tag: quiz.id,
                                  child: Image.asset(
                                    quiz.imagePath!,
                                    fit: BoxFit.contain,
                                    height: isSmallScreen ? 100 : 120,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Audio button positioned at the top right (if audio available)
                            if (quiz.audioPath != null)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: AnimatedAudioButton(
                                  onTap: onAudioPlay,
                                  isPlaying: isAudioPlaying,
                                  repeatCount: 0,
                                ),
                              ),
                          ],
                        ),
                      ),
                    
                    // Options area depends on quiz type
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildQuizContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Celebration animation overlay
          if (showCelebration && isCorrect)
            Positioned.fill(
              child: IgnorePointer(
                child: Lottie.asset(
                  'assets/lottie/misc/confetti.json',
                  fit: BoxFit.cover,
                  animate: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  // Build the content based on quiz type and mode
  Widget _buildQuizContent() {
    try {
      // Base default implementation for all quiz types
      return _buildStandardQuiz();
    } catch (e) {
      // Graceful fallback in case of errors with specific quiz types
      debugPrint('Error building quiz content: $e');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Impossible d\'afficher ce quiz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Erreur: ${e.toString()}',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
  
  // Standard multiple choice quiz
  Widget _buildStandardQuiz() {
    return SingleChildScrollView(
      child: Column(
        children: quiz.options.map((option) {
          final isOptionSelected = selectedAnswer == option.value;
          final color = optionColors[option.value] ?? Colors.grey.shade200;
          
          return _buildOptionItem(
            option: option.value, 
            isSelected: isOptionSelected, 
            color: color,
            imagePath: option.imagePath,
          );
        }).toList(),
      ),
    );
  }
  
  // Helper method to build an option item
  Widget _buildOptionItem({
    required String option,
    required bool isSelected,
    required Color color,
    String? imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : color,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: InkWell(
          onTap: isCheckingAnswer ? null : () => onOptionSelected(option),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Selection indicator
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.deepPurple : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                
                // Option image if available
                if (imagePath != null) ...[
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                
                // Option text
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper methods for difficulty display
  Color _getDifficultyColor(QuizDifficultySetting difficulty) {
    switch (difficulty) {
      case QuizDifficultySetting.facile:
        return Colors.green;
      case QuizDifficultySetting.moyen:
        return Colors.amber.shade700;
      case QuizDifficultySetting.difficile:
        return Colors.red;
    }
  }
  
  String _getDifficultyText(QuizDifficultySetting difficulty) {
    switch (difficulty) {
      case QuizDifficultySetting.facile:
        return "Facile";
      case QuizDifficultySetting.moyen:
        return "Moyen";
      case QuizDifficultySetting.difficile:
        return "Difficile";
    }
  }
  
  // Get category color from metadata
  Color _getCategoryColor(String category) {
    if (quiz.metadata != null && 
        quiz.metadata!.containsKey('categoryColors') && 
        quiz.metadata!['categoryColors'] is Map &&
        quiz.metadata!['categoryColors'].containsKey(category)) {
      
      final colorValue = quiz.metadata!['categoryColors'][category];
      if (colorValue is int) {
        return Color(colorValue);
      }
    }
    
    // Default colors based on category name hash
    final hash = category.hashCode;
    final colors = [
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.orange.shade200,
      Colors.purple.shade200,
      Colors.red.shade200,
      Colors.teal.shade200,
    ];
    
    return colors[hash % colors.length];
  }
}