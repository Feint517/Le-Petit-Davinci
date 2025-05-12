import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_interactive_model.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

// Pour la compatibilité avec l'ancien controleur
class DictationController extends DicteeInteractiveController {
  // Cette classe hérite de toutes les fonctionnalités de DicteeInteractiveController
  // pour assurer la compatibilité avec l'ancien code qui utilise ce nom de contrôleur
}

class DicteeInteractiveController extends GetxController with GetSingleTickerProviderStateMixin {
  // Observable variables
  final RxList<DicteeInteractiveModel> dictees = <DicteeInteractiveModel>[].obs;
  final RxInt currentDicteeIndex = 0.obs;
  final RxList<String> selectedWords = <String>[].obs;
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxInt incorrectAttempts = 0.obs;
  final RxBool isAudioPlaying = false.obs;
  final RxBool isHintVisible = false.obs;
  final RxBool hasShownHint = false.obs;
  final RxDouble progressValue = 0.0.obs;
  final RxBool shouldShowCelebration = false.obs;
  final RxBool isCheckingAnswer = false.obs;
  final RxBool isCorrect = false.obs;
  final RxString feedbackMessage = ''.obs;
  final RxBool isWordBankShuffled = false.obs;
  
  // Filtre des dictées par niveau de difficulté
  final Rx<DifficultySetting?> difficultyFilter = Rx<DifficultySetting?>(null);
  
  // Pour le mode guidé - mots qui devraient être en surbrillance
  final RxList<int> highlightedIndices = <int>[].obs;
  
  // Non-observable variables
  late AnimationController animationController;
  final AudioPlayer audioPlayer = AudioPlayer();
  
  // Accès à la mascotte
  late MascotController _mascotController;
  
  // Timer pour la lecture périodique
  RxInt audioAutoPlayCount = 0.obs;
  
  // Couleurs pour les mots
  final List<Color> wordColors = [
    const Color(0xFFFFD6E0),  // Light Pink
    const Color(0xFFFFEFB5),  // Light Yellow
    const Color(0xFFB5EAFF),  // Light Blue
    const Color(0xFFD1FFBD),  // Light Green
    const Color(0xFFE5CBFF),  // Light Purple
    const Color(0xFFFFD6C9),  // Light Orange
  ];
  
  // Computed property pour la dictée actuelle
  DicteeInteractiveModel get currentDictee => 
      dictees.isNotEmpty ? dictees[currentDicteeIndex.value] : DicteeInteractiveModel.getSampleDictees().first;
  
  // Liste de mots mélangée pour la banque de mots
  RxList<String> get shuffledWordBank {
    if (!isWordBankShuffled.value) {
      final List<String> allWords = [...currentDictee.wordBank];
      
      // Ajouter des distracteurs si la difficulté le justifie
      if (currentDictee.difficulty == DifficultySetting.moyen) {
        allWords.addAll(currentDictee.distractors.take(2));
      } else if (currentDictee.difficulty == DifficultySetting.difficile) {
        allWords.addAll(currentDictee.distractors.take(4));
      }
      
      // Mélanger les mots
      allWords.shuffle();
      
      // Marquer comme mélangé
      isWordBankShuffled.value = true;
      
      return RxList<String>.from(allWords);
    }
    
    return RxList<String>.from(currentDictee.wordBank);
  }
  
  @override
  void onInit() {
    super.onInit();
    
    // Charger les dictées
    dictees.assignAll(DicteeInteractiveModel.getSampleDictees());
    
    // Initialiser l'animation controller
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    // Charger l'audio pour la première dictée
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
    
    // Commencer la lecture automatique
    _scheduleAutoPlay();
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
  
  // Planifier la lecture automatique
  void _scheduleAutoPlay() {
    if (audioAutoPlayCount.value < 1) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        playAudio();
        audioAutoPlayCount.value++;
      });
    }
  }
  
  // Filtrer les dictées par niveau de difficulté
  void filterByDifficulty(DifficultySetting? difficulty) {
    difficultyFilter.value = difficulty;
    
    if (difficulty == null) {
      dictees.assignAll(DicteeInteractiveModel.getSampleDictees());
    } else {
      dictees.assignAll(
        DicteeInteractiveModel.getSampleDictees()
          .where((d) => d.difficulty == difficulty)
          .toList()
      );
    }
    
    // Réinitialiser l'index et d'autres valeurs
    currentDicteeIndex.value = 0;
    selectedWords.clear();
    isWordBankShuffled.value = false;
    _loadAudio();
    audioAutoPlayCount.value = 0;
    _scheduleAutoPlay();
  }
  
  // Audio handling methods
  Future<void> _loadAudio() async {
    try {
      // Vérifier le fichier audio
      final audioPath = currentDictee.audioPath;
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

          // Si tout échoue, utiliser un son de secours
          await audioPlayer.setAsset('assets/sfx/winner.mp3');
          debugPrint('Audio de secours chargé: assets/sfx/winner.mp3');
        }
      }
    } catch (e) {
      debugPrint('Erreur générale lors du chargement audio: $e');
    }
  }
  
  void playAudio() async {
    try {
      // Mettre à jour l'état
      isAudioPlaying.value = true;
      _mascotController.startThinking();

      // Vérifier que l'audio est chargé
      if (audioPlayer.duration == null) {
        debugPrint('Rechargement de l\'audio: ${currentDictee.audioPath}');
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
        debugPrint('État audio: ${state.processingState}, playing: ${state.playing}');
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
  
  // Word selection methods
  void addWord(String word) {
    selectedWords.add(word);
    update();
    
    // Mise à jour de la progression
    progressValue.value = selectedWords.length / currentDictee.correctWords.length;
    
    // Vérifier automatiquement si la phrase est complète
    if (selectedWords.length == currentDictee.correctWords.length) {
      Future.delayed(const Duration(milliseconds: 500), () {
        // Utiliser Get.context de façon sécurisée
        final context = Get.context;
        if (context != null) {
          checkAndContinue(context);
        }
      });
    }
    
    // Faire réagir la mascotte pendant que l'utilisateur compose
    _updateMascotDuringComposition();
  }
  
  void removeWord(String word) {
    final int index = selectedWords.indexOf(word);
    if (index != -1) {
      selectedWords.removeAt(index);
      update();
      
      // Mise à jour de la progression
      progressValue.value = selectedWords.length / currentDictee.correctWords.length;
    }
  }
  
  // Faire réagir la mascotte pendant que l'utilisateur compose
  void _updateMascotDuringComposition() {
    // Si la phrase est presque complète, la mascotte montre de l'enthousiasme
    if (selectedWords.length > currentDictee.correctWords.length * 0.7) {
      if (currentDictee.isStartCorrect(selectedWords.toList())) {
        _mascotController.changeState(MascotState.happy);
      }
    } 
    // Si l'utilisateur fait une erreur évidente
    else if (selectedWords.length > 1 && !currentDictee.isStartCorrect(selectedWords.toList())) {
      _mascotController.changeState(MascotState.question);
    }
    // Pendant la composition
    else {
      _mascotController.changeState(MascotState.thinking);
    }
  }
  
  // Montrer un indice
  void showHint() {
    isHintVisible.value = true;
    hasShownHint.value = true;
    
    String hintMessage;
    
    // Si aucun mot n'est encore sélectionné, montrer l'indice général
    if (selectedWords.isEmpty) {
      hintMessage = currentDictee.hint ?? "Écoutez attentivement la phrase.";
    } 
    // Sinon, donner un indice sur le prochain mot
    else {
      hintMessage = currentDictee.getNextWordHint(selectedWords.toList());
    }
    
    // Afficher l'indice avec la mascotte
    MascotHelper.showMascotDialog(
      title: "Indice",
      message: hintMessage,
      state: MascotState.thinking,
      buttonText: "J'ai compris",
      onConfirm: () {
        playAudio(); // Rejouer l'audio après l'indice
      }
    );
  }
  
  // Answer checking methods
  bool checkAnswer() {
    return currentDictee.checkAnswer(selectedWords.toList());
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
      score.value += currentDictee.points - hintPenalty;
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
    String customMessage;
    if (isCorrect.value) {
      if (currentDictee.difficulty == DifficultySetting.facile) {
        customMessage = 'Bravo ! Tu as parfaitement écrit la phrase !';
      } else if (currentDictee.difficulty == DifficultySetting.moyen) {
        customMessage = 'Excellent ! Tu maîtrises les phrases de niveau moyen !';
      } else {
        customMessage = 'Impressionnant ! Tu as réussi une dictée difficile !';
      }
    } else {
      final accuracy = currentDictee.calculateAccuracy(selectedWords.toList());
      if (accuracy > 70) {
        customMessage = 'Presque ! Tu as bien écrit ${accuracy.toInt()}% de la phrase correctement.';
      } else if (accuracy > 40) {
        customMessage = 'Continue tes efforts ! Tu as écrit ${accuracy.toInt()}% de la phrase correctement.';
      } else {
        customMessage = 'Essaie encore ! Écoute attentivement la dictée.';
      }
    }
    
    // Stocker le message de feedback
    feedbackMessage.value = customMessage;
    
    // Montrer les résultats
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isCorrect.value,
      totalXp: isCorrect.value ? currentDictee.points : 0,
      correctAnswers: isCorrect.value ? 1 : 0,
      totalQuestions: 1,
      customMessage: customMessage,
      onContinue: () {
        // Réinitialiser les valeurs
        isCheckingAnswer.value = false;
        shouldShowCelebration.value = false;
        hasShownHint.value = false;
        incorrectAttempts.value = 0;
        
        // Passer à la dictée suivante ou montrer les résultats finaux
        if (currentDicteeIndex.value < dictees.length - 1) {
          goToNextDictee();
        } else {
          showFinalResults(context);
        }
      },
    );
  }
  
  void goToNextDictee() {
    if (currentDicteeIndex.value < dictees.length - 1) {
      // Passer à la dictée suivante
      currentDicteeIndex.value++;
      selectedWords.clear();
      progressValue.value = 0.0;
      isWordBankShuffled.value = false;
      isCheckingAnswer.value = false;
      isCorrect.value = false;
      shouldShowCelebration.value = false;
      hasShownHint.value = false;
      incorrectAttempts.value = 0;
      _loadAudio();

      // Lire automatiquement la nouvelle dictée après un court délai
      audioAutoPlayCount.value = 0;
      _scheduleAutoPlay();

      // Préparer la mascotte pour la nouvelle dictée
      _mascotController.askQuestion();
    }
  }
  
  void goToPreviousDictee() {
    if (currentDicteeIndex.value > 0) {
      // Revenir à la dictée précédente
      currentDicteeIndex.value--;
      selectedWords.clear();
      progressValue.value = 0.0;
      isWordBankShuffled.value = false;
      isCheckingAnswer.value = false;
      isCorrect.value = false;
      shouldShowCelebration.value = false;
      hasShownHint.value = false;
      incorrectAttempts.value = 0;
      _loadAudio();

      // Lire automatiquement après un court délai
      audioAutoPlayCount.value = 0;
      _scheduleAutoPlay();

      // Réinitialiser l'état de la mascotte
      _mascotController.askQuestion();
    }
  }
  
  void showFinalResults(BuildContext context) {
    // Calculer la performance globale
    final bool isPerfect = correctAnswers.value == dictees.length;
    final int percentage = (correctAnswers.value / dictees.length * 100).toInt();
    
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
      finalMessage = 'Parfait ! Tu as réussi toutes les dictées ! Tu es un champion !';
    } else if (percentage >= 80) {
      finalMessage = 'Excellent ! Tu as réussi $percentage% des dictées !';
    } else if (percentage >= 60) {
      finalMessage = 'Bien joué ! Tu as réussi $percentage% des dictées. Continue comme ça !';
    } else {
      finalMessage = 'Tu as terminé la session avec $percentage% des dictées réussies. Essaie encore pour t\'améliorer !';
    }
    
    // Afficher les résultats finaux
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: dictees.length,
      customMessage: finalMessage,
      onContinue: () {
        // Revenir à l'écran précédent
        Get.back();
      },
    );
  }
  
  // Fonction pour obtenir une couleur aléatoire mais cohérente pour un mot
  Color getWordColor(String word) {
    final int hash = word.hashCode;
    return wordColors[hash % wordColors.length];
  }
}