import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/common/widgets/custom_dropdown.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/quiz_dropdown.dart';
import 'package:kids_learning_app/features/practice/screens/writing/writing_practice.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import '../../models/multiple_choice/quiz_question.dart';
import 'widgets/quiz_header.dart';
import 'widgets/question_counter.dart';
import 'widgets/question_box.dart';
import 'widgets/navigation_buttons.dart';
import 'widgets/quiz_navigator.dart';

class QuizScreen extends StatefulWidget {
  final String title;
  final List<QuizQuestion> questions;

  const QuizScreen({super.key, required this.title, required this.questions});

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Quiz terminé! Score: $score')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(pageTitle: 'Quiz à choix multiples'),
              const Gap(24),
              
              QuizDropdown(title: '', onPressed: (){}),
              const Gap(16),

              //* Question number and points
              QuestionCounter(
                currentIndex: currentQuestionIndex,
                totalQuestions: widget.questions.length,
                points: question.points,
              ),
              const Gap(16),

              //* Question box
              QuestionBox(
                question: question,
                selectedAnswer: selectedAnswer,
                onOptionSelected: _handleOptionSelected,
              ),

              const Spacer(),

              //* Navigation buttons
              NavigationButtons(
                canGoBack: currentQuestionIndex > 0,
                canGoForward: selectedAnswer != null,
                onPrevious: _goToPreviousQuestion,
                onNext: _goToNextQuestion,
              ),

              const Gap(16),

              //* Quiz navigation
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
      ),
    );
  }
}
