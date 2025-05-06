import 'package:flutter/material.dart';
import '../../models/pairing/appariement_question.dart';
import 'widgets/header.dart';
import 'widgets/quiz_dropdown.dart';
import 'widgets/question_counter.dart';
import 'widgets/points_badge.dart';
import 'widgets/question_box.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/quiz_navigator.dart';

class ExercicesAppariementScreen extends StatefulWidget {
  const ExercicesAppariementScreen({super.key});

  @override
  State<ExercicesAppariementScreen> createState() => _ExercicesAppariementScreenState();
}

class _ExercicesAppariementScreenState extends State<ExercicesAppariementScreen> {
  final List<AppariementQuestion> _questions = AppariementQuestion.getSampleQuestions();
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  
  AppariementQuestion get _currentQuestion => _questions[_currentQuestionIndex];

  void _handleOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedOption = null;
      });
    }
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
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
                  "Tu as terminé tous les exercices d'appariement !",
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
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2FF), // Neutral Color/Background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Header(
                title: 'Exercices d\'appariement',
                onBackPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 30),
              
              // Quiz selection dropdown
              QuizDropdown(
                title: 'Quiz 1 - Quiz de correspondance image et mot',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              
              // Question counter and points
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuestionCounter(
                    currentIndex: _currentQuestionIndex + 1,
                    totalQuestions: _questions.length,
                  ),
                  PointsBadge(
                    points: _currentQuestion.points,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Question box
              Expanded(
                child: QuestionBox(
                  imagePath: _currentQuestion.imagePath,
                  options: _currentQuestion.options,
                  onOptionSelected: _handleOptionSelected,
                  selectedOption: _selectedOption,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Navigation buttons
              NavigationButtons(
                onPrevious: _goToPreviousQuestion,
                onNext: _goToNextQuestion,
                isFirstQuestion: _currentQuestionIndex == 0,
                isLastQuestion: _currentQuestionIndex == _questions.length - 1,
              ),
              
              const SizedBox(height: 16),
              
              // Quiz navigation
              QuizNavigator(
                onPreviousQuiz: () {},
                onNextQuiz: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
