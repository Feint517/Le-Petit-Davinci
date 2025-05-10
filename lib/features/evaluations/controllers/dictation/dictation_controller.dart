import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_question.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class DicteeInteractiveController extends GetxController with GetSingleTickerProviderStateMixin {
  //* Observable variables
  final RxList<DicteeQuestion> questions = <DicteeQuestion>[].obs;
  final RxInt currentQuestionIndex = 0.obs;
  final RxList<String> selectedWords = <String>[].obs;
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  
  //* Non-observable variables
  late AnimationController animationController;
  final AudioPlayer audioPlayer = AudioPlayer();
  
  //* Computed property for the current question
  DicteeQuestion get currentQuestion => 
      questions.isNotEmpty ? questions[currentQuestionIndex.value] : DicteeQuestion.getSampleQuestions().first;
  
  @override
  void onInit() {
    super.onInit();
    
    //* Load sample questions
    questions.assignAll(DicteeQuestion.getSampleQuestions());
    
    //* Initialize animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    //* Load audio for the first question
    _loadAudio();
  }
  
  @override
  void onClose() {
    audioPlayer.dispose();
    animationController.dispose();
    super.onClose();
  }
  
  //* Audio handling methods
  Future<void> _loadAudio() async {
    try {
      await audioPlayer.setAsset(currentQuestion.audioPath);
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }
  
  void playAudio() async {
    try {
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }
  
  //* Word selection methods
  void addWord(String word) {
    selectedWords.add(word);
    update(); //? Force UI update if needed
  }
  
  void removeWord(String word) {
    selectedWords.remove(word);
    update(); //? Force UI update if needed
  }
  
  //* Answer checking methods
  bool checkAnswer() {
    //* Compare selected words with correct answer
    if (selectedWords.length != currentQuestion.correctAnswer.length) {
      return false;
    }
    
    for (int i = 0; i < selectedWords.length; i++) {
      if (selectedWords[i] != currentQuestion.correctAnswer[i]) {
        return false;
      }
    }
    
    return true;
  }
  
  //* Navigation methods
  void checkAndContinue(BuildContext context) {
    final isCorrect = checkAnswer();
    
    //* Update score and correct answers count if correct
    if (isCorrect) {
      score.value += currentQuestion.points;
      correctAnswers.value++;
    }
    
    //* Calculate question XP
    final questionXp = isCorrect ? currentQuestion.points : 0;
    
    //* Show the lesson result screen
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect,
      totalXp: questionXp,
      correctAnswers: isCorrect ? 1 : 0,
      totalQuestions: 1,
      customMessage: isCorrect 
          ? 'Tu as bien écrit la phrase correctement !' 
          : 'Essaie encore, tu as presque trouvé la bonne réponse !',
      onContinue: () {
        //* Move to next question or show completion
        if (currentQuestionIndex.value < questions.length - 1) {
          //* Move to next question
          currentQuestionIndex.value++;
          selectedWords.clear();
          _loadAudio();
        } else {
          //* Show final results
          showFinalResults(context);
        }
      },
    );
  }
  
  void goToPreviousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      selectedWords.clear();
      _loadAudio();
    }
  }
  
  void showFinalResults(BuildContext context) {
    //* Calculate overall performance
    final bool isPerfect = correctAnswers.value == questions.length;
    final int percentage = (correctAnswers.value / questions.length * 100).toInt();
    
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: questions.length,
      customMessage: isPerfect 
          ? 'Tu as terminé toutes les dictées parfaitement !'
          : 'Tu as terminé les dictées avec $percentage% de réussite !',
      onContinue: () {
        //* Return to previous screen
        Get.back();
      },
    );
  }
}