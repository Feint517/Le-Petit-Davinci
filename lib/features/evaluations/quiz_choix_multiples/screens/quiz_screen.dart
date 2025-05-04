import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../widgets/quiz_header.dart';
import '../widgets/question_counter.dart';
import '../widgets/question_box.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/quiz_navigator.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<QuizQuestion> questions;

  const QuizScreen({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int score = 0;

  void _handleOptionSelected(String option) {
    setState(() {
      selectedAnswer = option;
    });
  }

  void _goToPreviousQuestion() {
    setState(() {
      currentQuestionIndex--;
      selectedAnswer = null;
    });
  }

  void _goToNextQuestion() {
    final question = widget.questions[currentQuestionIndex];
    
    // Check if the answer is correct and update score
    if (selectedAnswer == question.correctAnswer) {
      score += question.points;
    }
    
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      // Show results or navigate to results page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quiz terminé! Score: $score')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFFDF2FF), // Neutral Color/Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6C6C6C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Retour',
              style: TextStyle(
                color: Color(0xFF6C6C6C),
                fontSize: 12,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFFFC715A), // Main Color/Orange - Secondary
                fontSize: 20,
                fontFamily: 'Bricolage Grotesque',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          // Profile avatar could be added here
          const CircleAvatar(radius: 20),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz selection dropdown
            QuizHeader(title: 'Quiz 1 - Quiz de correspondance image et mot'),
            const SizedBox(height: 16),
            
            // Question number and points
            QuestionCounter(
              currentIndex: currentQuestionIndex,
              totalQuestions: widget.questions.length,
              points: question.points,
            ),
            const SizedBox(height: 16),
            
            // Question box
            QuestionBox(
              question: question,
              selectedAnswer: selectedAnswer,
              onOptionSelected: _handleOptionSelected,
            ),
            
            const Spacer(),
            
            // Navigation buttons
            NavigationButtons(
              canGoBack: currentQuestionIndex > 0,
              canGoForward: selectedAnswer != null,
              onPrevious: _goToPreviousQuestion,
              onNext: _goToNextQuestion,
            ),
            
            const SizedBox(height: 16),
            
            // Quiz navigation
            QuizNavigator(
              onPreviousQuiz: () {
                // Handle previous quiz logic
              },
              onNextQuiz: () {
                // Handle next quiz logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
