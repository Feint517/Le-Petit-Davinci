import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/lessons/models/shapes_colors_question.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class ShapesColorsController extends GetxController {
  // Observable variables
  final RxList<ShapesColorsQuestion> questions = <ShapesColorsQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final Rx<String?> selectedAnswer = Rx<String?>(null);
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxBool isAnswerChecked = false.obs;
  final RxBool isCorrectAnswer = false.obs;

  // Mascot related variables
  late MascotController mascotController;
  final RxBool showHint = false.obs;

  // Computed property for the current question
  ShapesColorsQuestion get currentQuestion =>
      questions.isNotEmpty ? questions[currentQuestionIndex.value] : ShapesColorsQuestion.getSampleQuestions().first;

  @override
  void onInit() {
    super.onInit();

    // Load sample questions
    questions.assignAll(ShapesColorsQuestion.getSampleQuestions());

    // Initialize mascot controller
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }
    mascotController = Get.find<MascotController>();

    // Set initial mascot state
    Future.delayed(const Duration(milliseconds: 500), () {
      mascotController.askQuestion();
    });
  }

  // Answer selection method
  void selectAnswer(String answer) {
    if (!isAnswerChecked.value) {
      selectedAnswer.value = answer;
      update();

      // Make mascot think when answer is selected
      mascotController.startThinking();
    }
  }

  // Check if the selected answer is correct
  bool checkAnswer() {
    if (selectedAnswer.value == null) {
      return false;
    }
    return selectedAnswer.value == currentQuestion.correctAnswer;
  }

  // Toggle hint display
  void toggleHint() {
    showHint.toggle();
    if (showHint.value) {
      // Show mascot with hint
      MascotHelper.showMascotDialog(
        title: "Conseil",
        message: _getHintForCurrentQuestion(),
        state: MascotState.thinking,
        buttonText: "J'ai compris",
      );
    }
  }

  // Get appropriate hint for current question
  String _getHintForCurrentQuestion() {
    switch (currentQuestion.type) {
      case QuestionType.shapeIdentification:
        return "Observe bien les côtés et les angles de la forme. Chaque forme a des caractéristiques uniques !";
      case QuestionType.colorIdentification:
        return "Regarde attentivement la couleur de la forme et pense aux objets que tu connais de cette couleur.";
      case QuestionType.combinedQuestion:
        return "Cherche la forme indiquée et vérifie sa couleur, ou cherche la couleur indiquée et vérifie quelle forme a cette couleur.";
      default:
        return "Observe bien l'image et prends ton temps pour répondre.";
    }
  }

  // Check the answer and show result popup
  void checkAndContinue(BuildContext context) {
    if (selectedAnswer.value == null) {
      // Show message to select an answer first
      MascotHelper.showMascotDialog(
        title: "Attention",
        message: "Veuillez sélectionner une réponse avant de continuer.",
        state: MascotState.question,
        buttonText: "D'accord",
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

      // Make mascot happy or celebrate for correct answer
      mascotController.reactToCorrectAnswer();
      if (currentQuestionIndex.value == questions.length - 1) {
        // Last question and correct - celebrate!
        mascotController.celebrate();
      }
    } else {
      // Make mascot sad for incorrect answer
      mascotController.reactToIncorrectAnswer();
    }

    // Calculate question XP
    final questionXp = isCorrect ? currentQuestion.points : 0;

    // Get appropriate feedback message based on question type
    String feedbackMessage = isCorrect
        ? 'Bravo ! Tu as trouvé la bonne réponse !'
        : 'Essaie encore, la réponse était ${currentQuestion.correctAnswer}. ${currentQuestion.explanation ?? ""}';

    if (isCorrect && currentQuestion.type == QuestionType.shapeIdentification) {
      feedbackMessage = 'Bravo ! Tu as correctement identifié la forme !';
    } else if (isCorrect && currentQuestion.type == QuestionType.colorIdentification) {
      feedbackMessage = 'Bravo ! Tu as correctement identifié la couleur !';
    } else if (isCorrect && currentQuestion.type == QuestionType.combinedQuestion) {
      feedbackMessage = 'Excellent ! Tu as bien trouvé la forme et sa couleur !';
    }

    // Show the lesson result screen
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect,
      totalXp: questionXp,
      correctAnswers: isCorrect ? 1 : 0,
      totalQuestions: 1,
      customMessage: feedbackMessage,
      onContinue: () {
        // Reset for next question
        isAnswerChecked.value = false;
        selectedAnswer.value = null;
        showHint.value = false;

        // Move to next question or show completion
        if (currentQuestionIndex.value < questions.length - 1) {
          // Move to next question
          currentQuestionIndex.value++;

          // Change mascot state to questioning for new question
          mascotController.askQuestion();
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
      showHint.value = false;

      // Reset mascot state for the previous question
      mascotController.askQuestion();
    }
  }

  void showFinalResults(BuildContext context) {
    // Calculate overall performance
    final bool isPerfect = correctAnswers.value == questions.length;
    final int percentage = (correctAnswers.value / questions.length * 100).toInt();

    // Set appropriate mascot state
    if (isPerfect) {
      mascotController.celebrate();
    } else if (percentage >= 70) {
      mascotController.reactToCorrectAnswer();
    } else {
      mascotController.askQuestion();
    }

    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: questions.length,
      customMessage: isPerfect
          ? 'Tu as parfaitement réussi toutes les questions sur les formes et les couleurs !'
          : 'Tu as terminé la leçon sur les formes et les couleurs avec $percentage% de réussite !',
      onContinue: () {
        // Return to previous screen
        Get.back();
      },
    );
  }
}