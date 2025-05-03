import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/features/evaluations/dictee/models/dictee_question.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/dictee_header.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/points_badge.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/question_card.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/question_progress.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/qui_navigation_footer.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/quiz_dropdown.dart';
//import 'package:kids_learning_app/utils/constants/colors.dart';

class DicteeInteractiveScreen extends StatefulWidget {
  const DicteeInteractiveScreen({super.key});

  @override
  State<DicteeInteractiveScreen> createState() => _DicteeInteractiveScreenState();
}

class _DicteeInteractiveScreenState extends State<DicteeInteractiveScreen> {
  final List<DicteeQuestion> _questions = DicteeQuestion.getSampleQuestions();
  int _currentQuestionIndex = 0;
  final List<String> _selectedWords = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  DicteeQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset(_currentQuestion.audioPath);
    } catch (e) {
      print('Error loading audio: $e');
      // In a real app, you'd handle this error appropriately
    }
  }

  void _playAudio() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
      // In a real app, you'd handle this error appropriately
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
      // This would be where you'd handle the completion of the quiz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quiz terminé!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header with back button and title
              DicteeHeader(
                onBackPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 30),
              
              // Quiz dropdown selector
              QuizDropdown(
                title: 'Quiz 1 - Quiz de correspondance image et mot',
                onPressed: () {
                  // This would open a dropdown of available quizzes
                },
              ),
              const SizedBox(height: 30),
              
              // Question progress and points
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
              const SizedBox(height: 12),
              
              // Question card
              QuestionCard(
                question: _currentQuestion,
                selectedWords: _selectedWords,
                onWordSelected: _addWord,
                onWordRemoved: _removeWord,
                onAudioPlay: _playAudio,
              ),
              const SizedBox(height: 16),
              
              // Navigation buttons
              NavigationButtons(
                onPrevious: _goToPreviousQuestion,
                onNext: _goToNextQuestion,
                isFirstQuestion: _currentQuestionIndex == 0,
                isLastQuestion: _currentQuestionIndex == _questions.length - 1,
              ),
              const SizedBox(height: 20),
              
              // Quiz navigation footer
              QuizNavigationFooter(
                onPreviousQuiz: () {
                  // This would navigate to the previous quiz
                },
                onNextQuiz: () {
                  // This would navigate to the next quiz
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}