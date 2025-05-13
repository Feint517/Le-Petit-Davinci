import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/lessons/models/math_operation_question.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class MathOperationController extends GetxController {
  // Observable variables
  final RxList<MathOperationQuestion> questions = <MathOperationQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final Rx<int?> selectedAnswer = Rx<int?>(null);
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxBool isAnswerChecked = false.obs;
  final RxBool isCorrectAnswer = false.obs;
  
  // Computed property for the current question
  MathOperationQuestion get currentQuestion => 
      questions.isNotEmpty ? questions[currentQuestionIndex.value] : MathOperationQuestion.getSampleQuestions().first;
  
  @override
  void onInit() {
    super.onInit();
    
    // Load sample questions
    questions.assignAll(MathOperationQuestion.getSampleQuestions());
  }
  
  // Answer selection method
  void selectAnswer(int answer) {
    if (!isAnswerChecked.value) {
      selectedAnswer.value = answer;
      update();
    }
  }
  
  // Check if the selected answer is correct
  bool checkAnswer() {
    if (selectedAnswer.value == null) {
      return false;
    }
    return selectedAnswer.value == currentQuestion.correctAnswer;
  }
  
  // Check the answer and show result popup
  void checkAndContinue(BuildContext context) {
    if (selectedAnswer.value == null) {
      // Show message to select an answer first
      Get.snackbar(
        'Attention',
        'Veuillez sélectionner une réponse avant de continuer.',
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    
    final isCorrect = checkAnswer();
    isAnswerChecked.value = true;
    isCorrectAnswer.value = isCorrect;
    
    // Update score and correct answers count if correct
    if (isCorrect) {
      score.value += currentQuestion.points;
      correctAnswers.value++;
    }
    
    // Calculate question XP
    final questionXp = isCorrect ? currentQuestion.points : 0;
    
    // Show the lesson result screen
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect,
      totalXp: questionXp,
      correctAnswers: isCorrect ? 1 : 0,
      totalQuestions: 1,
      customMessage: isCorrect 
          ? 'Bravo ! Tu as correctement résolu cette opération !' 
          : 'Essaie encore, la réponse était ${currentQuestion.correctAnswer}. ${currentQuestion.explanation ?? ""}',
      onContinue: () {
        // Reset for next question
        isAnswerChecked.value = false;
        selectedAnswer.value = null;
        
        // Move to next question or show completion
        if (currentQuestionIndex.value < questions.length - 1) {
          // Move to next question
          currentQuestionIndex.value++;
        } else {
          // Show final results
          showFinalResults(context);
        }
      },
    );
  }
  
  void goToPreviousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      selectedAnswer.value = null;
      isAnswerChecked.value = false;
    }
  }
  
  void showFinalResults(BuildContext context) {
    // Calculate overall performance
    final bool isPerfect = correctAnswers.value == questions.length;
    final int percentage = (correctAnswers.value / questions.length * 100).toInt();
    
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: questions.length,
      customMessage: isPerfect 
          ? 'Tu as parfaitement réussi toutes les opérations mathématiques !'
          : 'Tu as terminé la leçon avec $percentage% de réussite !',
      onContinue: () {
        // Return to previous screen
        Get.back();
      },
    );
  }
}