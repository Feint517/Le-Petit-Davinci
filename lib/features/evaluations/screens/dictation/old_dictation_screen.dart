import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_question.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/dictee_header.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/points_badge.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_card.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_progress.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/qui_navigation_footer.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/quiz_dropdown.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class DictationInteractiveScreen extends StatefulWidget {
  const DictationInteractiveScreen({super.key});

  @override
  State<DictationInteractiveScreen> createState() =>
      _DicteeInteractiveScreenState();
}

class _DicteeInteractiveScreenState extends State<DictationInteractiveScreen>
    with SingleTickerProviderStateMixin {
  final List<DicteeQuestion> _questions = DicteeQuestion.getSampleQuestions();
  int _currentQuestionIndex = 0;
  final List<String> _selectedWords = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _animationController;
  int _score = 0;
  int _correctAnswers = 0;

  DicteeQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  @override
  void initState() {
    super.initState();
    _loadAudio();

    // Animation controller for background elements
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset(_currentQuestion.audioPath);
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void _playAudio() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _addWord(String word) {
    setState(() {
      _selectedWords.add(word);
    });
  }

  void _removeWord(String word) {
    setState(() {
      _selectedWords.remove(word);
    });
  }

  // Check answer correctness
  bool _checkAnswer() {
    // Compare selected words with correct answer
    // Simple check: same length and all words match (in order)
    if (_selectedWords.length != _currentQuestion.correctAnswer.length) {
      return false;
    }

    for (int i = 0; i < _selectedWords.length; i++) {
      if (_selectedWords[i] != _currentQuestion.correctAnswer[i]) {
        return false;
      }
    }

    return true;
  }

  // Check and show results before moving to next question
  void _checkAndContinue() {
    final isCorrect = _checkAnswer();

    // Update score and correct answers count if correct
    if (isCorrect) {
      _score += _currentQuestion.points;
      _correctAnswers++;
    }

    // Calculate question XP
    final questionXp = isCorrect ? _currentQuestion.points : 0;

    // Show the lesson result screen
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect,
      totalXp: questionXp,
      correctAnswers: isCorrect ? 1 : 0,
      totalQuestions: 1,
      customMessage:
          isCorrect
              ? 'Tu as bien écrit la phrase correctement !'
              : 'Essaie encore, tu as presque trouvé la bonne réponse !',
      onContinue: () {
        // Move to next question or show completion
        if (_currentQuestionIndex < _questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _selectedWords.clear();
          });
          _loadAudio();
        } else {
          _showFinalResults();
        }
      },
    );
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedWords.clear();
      });
      _loadAudio();
    }
  }

  // Show final results after completing all questions
  void _showFinalResults() {
    // Calculate overall performance
    final bool isPerfect = _correctAnswers == _questions.length;
    final int percentage = (_correctAnswers / _questions.length * 100).toInt();

    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: _score,
      correctAnswers: _correctAnswers,
      totalQuestions: _questions.length,
      customMessage:
          isPerfect
              ? 'Tu as terminé toutes les dictées parfaitement !'
              : 'Tu as terminé les dictées avec $percentage% de réussite !',
      onContinue: () {
        // Return to previous screen
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF2FF),
      body: Stack(
        children: [
          // Main content (removed animated background elements for better performance)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > 600 ? 24.0 : 12.0,
                vertical: isSmallScreen ? 8.0 : 12.0,
              ),
              child: Column(
                children: [
                  // Header with back button and title (made more compact)
                  DicteeHeader(onBackPressed: () => Navigator.pop(context)),
                  SizedBox(height: isSmallScreen ? 10 : 14),

                  // Combined row for quiz selection and progress/points
                  isNarrowScreen
                      // For very narrow screens, stack the elements vertically
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Quiz dropdown selector
                          QuizDropdown(
                            title: 'Dictée interactive',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 8),
                          // Progress and points in a row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QuestionProgress(
                                currentQuestion: _currentQuestionIndex + 1,
                                totalQuestions: _questions.length,
                              ),
                              PointsBadge(points: _currentQuestion.points),
                            ],
                          ),
                        ],
                      )
                      // For wider screens, keep the row layout but with better flex distribution
                      : Row(
                        children: [
                          // Quiz dropdown selector (made more compact)
                          Expanded(
                            flex: 2,
                            child: QuizDropdown(
                              title: 'Dictée interactive',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Question progress and points
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                QuestionProgress(
                                  currentQuestion: _currentQuestionIndex + 1,
                                  totalQuestions: _questions.length,
                                ),
                                PointsBadge(points: _currentQuestion.points),
                              ],
                            ),
                          ),
                        ],
                      ),
                  SizedBox(height: isSmallScreen ? 8 : 12),

                  // Question card (most of the screen space)
                  Expanded(
                    child: QuestionCard(
                      question: _currentQuestion,
                      selectedWords: _selectedWords,
                      onWordSelected: _addWord,
                      onWordRemoved: _removeWord,
                      onAudioPlay: _playAudio,
                    ),
                  ),
                  Gap(isSmallScreen ? 8 : 12),

                  // Navigation buttons row - Modified to use check and continue
                  NavigationButtons(
                    onPrevious: _goToPreviousQuestion,
                    onNext: _checkAndContinue, // Changed to _checkAndContinue
                    isFirstQuestion: _currentQuestionIndex == 0,
                    isLastQuestion:
                        _currentQuestionIndex == _questions.length - 1,
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),

                  // Quiz navigation footer
                  QuizNavigationFooter(
                    onPreviousQuiz: () {},
                    onNextQuiz: () {},
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
