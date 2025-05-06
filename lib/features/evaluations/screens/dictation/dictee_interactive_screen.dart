import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_question.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/dictee_header.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/points_badge.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_card.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_progress.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/qui_navigation_footer.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/quiz_dropdown.dart';

class DicteeInteractiveScreen extends StatefulWidget {
  const DicteeInteractiveScreen({super.key});

  @override
  State<DicteeInteractiveScreen> createState() => _DicteeInteractiveScreenState();
}

class _DicteeInteractiveScreenState extends State<DicteeInteractiveScreen> with SingleTickerProviderStateMixin {
  final List<DicteeQuestion> _questions = DicteeQuestion.getSampleQuestions();
  int _currentQuestionIndex = 0;
  final List<String> _selectedWords = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _animationController;
  
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

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedWords.clear();
      });
      _loadAudio();
    }
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedWords.clear();
      });
      _loadAudio();
    } else {
      _showCompletionDialog();
    }
  }
  
  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/illustrations/lion.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Félicitations !",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A3EA1),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Tu as terminé toutes les dictées !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A3EA1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text("Continuer"),
                ),
              ],
            ),
          ),
        );
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
                  DicteeHeader(
                    onBackPressed: () => Navigator.pop(context),
                  ),
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
                            PointsBadge(
                              points: _currentQuestion.points,
                            ),
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
                              PointsBadge(
                                points: _currentQuestion.points,
                              ),
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
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  
                  // Navigation buttons row
                  NavigationButtons(
                    onPrevious: _goToPreviousQuestion,
                    onNext: _goToNextQuestion,
                    isFirstQuestion: _currentQuestionIndex == 0,
                    isLastQuestion: _currentQuestionIndex == _questions.length - 1,
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