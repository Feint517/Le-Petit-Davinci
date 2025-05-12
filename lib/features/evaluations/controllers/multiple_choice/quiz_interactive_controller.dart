import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/evaluations/models/multiple_choice/quiz_interactive_model.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class QuizInteractiveController extends GetxController with GetSingleTickerProviderStateMixin {
  // Observable variables
  final RxList<QuizInteractiveModel> quizzes = <QuizInteractiveModel>[].obs;
  final RxInt currentQuizIndex = 0.obs;
  final RxString selectedAnswer = ''.obs;
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxInt incorrectAttempts = 0.obs;
  final RxBool isAudioPlaying = false.obs;
  final RxBool isHintVisible = false.obs;
  final RxBool hasShownHint = false.obs;
  final RxBool shouldShowCelebration = false.obs;
  final RxBool isCheckingAnswer = false.obs;
  final RxBool isCorrect = false.obs;
  final RxString feedbackMessage = ''.obs;
  
  // Filtre des quiz par niveau de difficulté
  final Rx<QuizDifficultySetting?> difficultyFilter = Rx<QuizDifficultySetting?>(null);
  
  // Pour les quiz de catégories
  final RxMap<String, List<String>> categorizedItems = <String, List<String>>{}.obs;
  
  // Animation and audio
  late AnimationController animationController;
  final AudioPlayer audioPlayer = AudioPlayer();

  // Accès à la mascotte
  late MascotController _mascotController;

  // Singleton pour faciliter l'accès depuis n'importe où
  static QuizInteractiveController get to => Get.find<QuizInteractiveController>();
  
  // Timer pour la lecture périodique
  RxInt audioAutoPlayCount = 0.obs;
  
  // Couleurs pour les options
  final List<Color> optionColors = [
    const Color(0xFFF8BBD0),  // Pink
    const Color(0xFFB3E5FC),  // Light Blue
    const Color(0xFFDCEDC8),  // Light Green
    const Color(0xFFFFE0B2),  // Light Orange
    const Color(0xFFE1BEE7),  // Light Purple
    const Color(0xFFFFCDD2),  // Light Red
  ];
  
  // Computed property pour le quiz actuel
  QuizInteractiveModel get currentQuiz => 
      quizzes.isNotEmpty ? quizzes[currentQuizIndex.value] : QuizInteractiveModel.getSampleQuizzes().first;
  
  // Pour les quiz à options multiples, les options avec couleurs
  RxMap<String, Color> get optionWithColors {
    final Map<String, Color> result = {};
    
    for (int i = 0; i < currentQuiz.options.length; i++) {
      final option = currentQuiz.options[i];
      result[option.value] = optionColors[i % optionColors.length];
    }
    
    return RxMap<String, Color>.from(result);
  }
  
  @override
  void onInit() {
    super.onInit();
    
    // Charger les quiz
    quizzes.assignAll(QuizInteractiveModel.getSampleQuizzes());
    
    // Initialiser l'animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    // Charger l'audio si disponible
    _loadAudio();
    
    // Initialiser la mascotte
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }
    _mascotController = Get.find<MascotController>();
    
    // Récupérer un type de mascotte aléatoire
    _mascotController.changeMascot(_getRandomMascot());
    
    // Définir l'état initial de la mascotte
    Future.delayed(const Duration(milliseconds: 500), () {
      _mascotController.askQuestion();
    });
    
    // Initialiser les catégories si nécessaire
    initializeCategories();
  }
  
  @override
  void onClose() {
    audioPlayer.dispose();
    animationController.dispose();
    super.onClose();
  }
  
  MascotType _getRandomMascot() {
    final mascots = [MascotType.elephant, MascotType.owl, MascotType.panda];
    return mascots[Random().nextInt(mascots.length)];
  }
  
  // Initialiser les catégories pour les quiz de type catégorie
  void initializeCategories() {
    if (currentQuiz.type == QuizType.categorySort && currentQuiz.categories != null) {
      final Map<String, List<String>> initialCategories = {};

      // Initialiser chaque catégorie avec une liste vide
      for (final category in currentQuiz.categories!) {
        initialCategories[category] = [];
      }

      categorizedItems.assignAll(initialCategories);
    }
  }
  
  // Filtrer les quiz par niveau de difficulté
  void filterByDifficulty(QuizDifficultySetting? difficulty) {
    difficultyFilter.value = difficulty;
    
    if (difficulty == null) {
      quizzes.assignAll(QuizInteractiveModel.getSampleQuizzes());
    } else {
      quizzes.assignAll(
        QuizInteractiveModel.getSampleQuizzes()
          .where((q) => q.difficulty == difficulty)
          .toList()
      );
    }
    
    // Réinitialiser l'index et d'autres valeurs
    currentQuizIndex.value = 0;
    selectedAnswer.value = '';
    categorizedItems.clear();
    initializeCategories();
    _loadAudio();
    audioAutoPlayCount.value = 0;
  }
  
  // Audio handling methods
  Future<void> _loadAudio() async {
    // Ne charger l'audio que s'il est disponible
    if (currentQuiz.audioPath != null) {
      try {
        // Vérifier le fichier audio
        final audioPath = currentQuiz.audioPath!;
        debugPrint('Tentative de chargement audio: $audioPath');
  
        // Essayer avec setAsset (fichier dans les assets)
        try {
          await audioPlayer.setAsset(audioPath);
          debugPrint('Audio chargé avec succès: $audioPath');
        } catch (assetError) {
          debugPrint('Erreur lors du chargement de l\'asset audio: $assetError');
  
          // Si échec, tenter avec setUrl comme solution de repli (fichier local)
          try {
            await audioPlayer.setUrl(audioPath);
            debugPrint('Audio chargé comme URL: $audioPath');
          } catch (urlError) {
            debugPrint('Erreur lors du chargement de l\'URL audio: $urlError');
          }
        }
      } catch (e) {
        debugPrint('Erreur générale lors du chargement audio: $e');
      }
    }
  }
  
  void playAudio() async {
    // Ne jouer l'audio que s'il est disponible
    if (currentQuiz.audioPath != null) {
      try {
        // Mettre à jour l'état
        isAudioPlaying.value = true;
        _mascotController.startThinking();
  
        // Vérifier que l'audio est chargé
        if (audioPlayer.duration == null) {
          debugPrint('Rechargement de l\'audio: ${currentQuiz.audioPath}');
          await _loadAudio();
        }
  
        // Jouer l'audio depuis le début
        await audioPlayer.seek(Duration.zero);
        await audioPlayer.play();
  
        // Ajouter un délai de sécurité au cas où l'événement de fin ne se déclenche pas
        Future.delayed(const Duration(seconds: 3), () {
          if (isAudioPlaying.value) {
            isAudioPlaying.value = false;
            _mascotController.askQuestion();
          }
        });
  
        // Écouter quand l'audio est terminé
        audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            isAudioPlaying.value = false;
            _mascotController.askQuestion();
          }
        });
      } catch (e) {
        debugPrint('Erreur lors de la lecture audio: $e');
        isAudioPlaying.value = false;
        
        // En cas d'erreur, simuler un son qui a été joué
        Future.delayed(const Duration(milliseconds: 1500), () {
          _mascotController.askQuestion();
        });
      }
    }
  }
  
  // Option selection method
  void selectAnswer(String answer) {
    selectedAnswer.value = answer;
    
    // Faire réagir la mascotte
    _updateMascotDuringSelection();
  }
  
  // Pour les quiz de type catégorie
  void addItemToCategory(String item, String category) {
    // Vérifier d'abord si l'item est déjà dans une autre catégorie
    for (final key in categorizedItems.keys) {
      categorizedItems[key]?.remove(item);
    }
    
    // Ajouter l'item à la catégorie sélectionnée
    if (categorizedItems.containsKey(category)) {
      categorizedItems[category]?.add(item);
    } else {
      categorizedItems[category] = [item];
    }
    
    // Mettre à jour
    categorizedItems.refresh();
  }
  
  // Faire réagir la mascotte pendant la sélection
  void _updateMascotDuringSelection() {
    // Si une réponse est sélectionnée, montrer de l'enthousiasme
    if (selectedAnswer.isNotEmpty) {
      if (currentQuiz.correctAnswer == selectedAnswer.value) {
        _mascotController.changeState(MascotState.happy);
      } else {
        _mascotController.changeState(MascotState.question);
      }
    }
  }
  
  // Montrer un indice
  void showHint() {
    isHintVisible.value = true;
    hasShownHint.value = true;
    
    String hintMessage = currentQuiz.hint ?? "Regarde bien l'image et les options.";
    
    // Afficher l'indice avec la mascotte
    MascotHelper.showMascotDialog(
      title: "Indice",
      message: hintMessage,
      state: MascotState.thinking,
      buttonText: "J'ai compris",
      onConfirm: () {
        if (currentQuiz.audioPath != null) {
          playAudio(); // Rejouer l'audio après l'indice si disponible
        }
      }
    );
  }
  
  // Answer checking methods
  bool checkAnswer() {
    // Pour les quiz de catégories
    if (currentQuiz.type == QuizType.categorySort) {
      bool allCorrect = true;
      
      // Vérifier chaque option catégorisée
      for (final option in currentQuiz.options) {
        final category = option.category;
        if (category == null) continue;
        
        // Vérifier si l'option est dans la bonne catégorie
        final isInCorrectCategory = categorizedItems[category]?.contains(option.value) ?? false;
        if (!isInCorrectCategory) {
          allCorrect = false;
          break;
        }
      }
      
      return allCorrect;
    }
    
    // Pour les quiz standards
    return currentQuiz.checkAnswer(selectedAnswer.value);
  }
  
  // Navigation methods
  void checkAndContinue(BuildContext context) {
    isCheckingAnswer.value = true;

    final bool answerCorrect = checkAnswer();
    isCorrect.value = answerCorrect;

    // Mise à jour du score et des réponses correctes
    if (answerCorrect) {
      // Bonus si réussi sans indice
      final int hintPenalty = hasShownHint.value ? 2 : 0;
      score.value += currentQuiz.points - hintPenalty;
      correctAnswers.value++;

      // Faire réagir la mascotte
      _mascotController.reactToCorrectAnswer();
      shouldShowCelebration.value = true;
    } else {
      incorrectAttempts.value++;

      // Faire réagir la mascotte
      _mascotController.reactToIncorrectAnswer();

      // Après 2 tentatives incorrectes, proposer un indice
      if (incorrectAttempts.value >= 2 && !hasShownHint.value) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          MascotHelper.showMascotDialog(
            title: "Besoin d'aide ?",
            message: "Tu sembles avoir du mal. Veux-tu un indice ?",
            state: MascotState.question,
            buttonText: "Oui, j'aimerais un indice",
            onConfirm: showHint
          );
        });
        return;
      }
    }
    
    // Préparer le message de feedback
    String customMessage = currentQuiz.getExplanation(isCorrect.value);
    
    // Stocker le message de feedback
    feedbackMessage.value = customMessage;
    
    // Montrer les résultats
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect.value,
      totalXp: isCorrect.value ? currentQuiz.points : 0,
      correctAnswers: isCorrect.value ? 1 : 0,
      totalQuestions: 1,
      customMessage: customMessage,
      onContinue: () {
        // Réinitialiser les valeurs
        isCheckingAnswer.value = false;
        shouldShowCelebration.value = false;
        hasShownHint.value = false;
        incorrectAttempts.value = 0;
        
        // Passer au quiz suivant ou montrer les résultats finaux
        if (currentQuizIndex.value < quizzes.length - 1) {
          goToNextQuiz();
        } else {
          showFinalResults(context);
        }
      },
    );
  }
  
  void goToNextQuiz() {
    if (currentQuizIndex.value < quizzes.length - 1) {
      // Passer au quiz suivant
      currentQuizIndex.value++;
      selectedAnswer.value = '';
      categorizedItems.clear();
      isCheckingAnswer.value = false;
      isCorrect.value = false;
      shouldShowCelebration.value = false;
      hasShownHint.value = false;
      incorrectAttempts.value = 0;
      
      // Initialiser les catégories si nécessaire
      initializeCategories();
      
      // Charger le nouvel audio si disponible
      _loadAudio();

      // Préparer la mascotte pour le nouveau quiz
      _mascotController.askQuestion();
    }
  }
  
  void goToPreviousQuiz() {
    if (currentQuizIndex.value > 0) {
      // Revenir au quiz précédent
      currentQuizIndex.value--;
      selectedAnswer.value = '';
      categorizedItems.clear();
      isCheckingAnswer.value = false;
      isCorrect.value = false;
      shouldShowCelebration.value = false;
      hasShownHint.value = false;
      incorrectAttempts.value = 0;
      
      // Initialiser les catégories si nécessaire
      initializeCategories();
      
      // Charger le nouvel audio si disponible
      _loadAudio();

      // Réinitialiser l'état de la mascotte
      _mascotController.askQuestion();
    }
  }
  
  void showFinalResults(BuildContext context) {
    // Calculer la performance globale
    final bool isPerfect = correctAnswers.value == quizzes.length;
    final int percentage = (correctAnswers.value / quizzes.length * 100).toInt();
    
    // Mettre la mascotte dans un état approprié
    if (isPerfect) {
      _mascotController.celebrate();
    } else if (percentage >= 70) {
      _mascotController.reactToCorrectAnswer();
    } else {
      _mascotController.askQuestion();
    }
    
    // Message personnalisé basé sur la performance
    String finalMessage;
    if (isPerfect) {
      finalMessage = 'Parfait ! Tu as réussi tous les quiz ! Tu es un champion !';
    } else if (percentage >= 80) {
      finalMessage = 'Excellent ! Tu as réussi $percentage% des quiz !';
    } else if (percentage >= 60) {
      finalMessage = 'Bien joué ! Tu as réussi $percentage% des quiz. Continue comme ça !';
    } else {
      finalMessage = 'Tu as terminé la session avec $percentage% des quiz réussis. Essaie encore pour t\'améliorer !';
    }
    
    // Afficher les résultats finaux
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: quizzes.length,
      customMessage: finalMessage,
      onContinue: () {
        // Revenir à l'écran précédent
        Get.back();
      },
    );
  }
  
  // Fonction pour obtenir une couleur aléatoire mais cohérente pour une option
  Color getOptionColor(String option) {
    final int hash = option.hashCode;
    return optionColors[hash % optionColors.length];
  }
}