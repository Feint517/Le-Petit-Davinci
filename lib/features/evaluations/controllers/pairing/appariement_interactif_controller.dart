import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/evaluations/models/pairing/appariement_interactif_model.dart';
import 'package:kids_learning_app/utils/popups/lesson_result_helper.dart';

class AppariementInteractifController extends GetxController with GetSingleTickerProviderStateMixin {
  // Variables observables
  final RxList<AppariementInteractifModel> exercices = <AppariementInteractifModel>[].obs;
  final RxInt currentExerciceIndex = 0.obs;
  final RxInt score = 0.obs;
  final RxInt correctAnswers = 0.obs;
  final RxBool isCheckingAnswer = false.obs;
  final RxBool showCelebration = false.obs;
  final RxDouble progressValue = 0.0.obs;
  
  // Variables pour le mode de jeu "tracerLigne"
  final RxList<Connection> connections = <Connection>[].obs;
  final Rx<ElementAppariement?> selectedLeftElement = Rx<ElementAppariement?>(null);
  
  // Variables pour le mode de jeu "glisserDeposer"
  final RxMap<String, String?> dropTargetValues = <String, String?>{}.obs;
  
  // Variables pour le mode de jeu "selection"
  final Rx<ElementAppariement?> firstSelectedElement = Rx<ElementAppariement?>(null);
  final Rx<ElementAppariement?> secondSelectedElement = Rx<ElementAppariement?>(null);
  final RxList<PaireAppariement> completedPairs = <PaireAppariement>[].obs;
  
  // Variables pour les effets visuels
  final RxList<String> elementsWithGlow = <String>[].obs;
  final RxList<String> correctElements = <String>[].obs;
  final RxList<String> incorrectElements = <String>[].obs;
  
  // Effets sonores
  final AudioPlayer audioPlayer = AudioPlayer();
  
  // Accès à la mascotte
  late MascotController _mascotController;
  
  // Variables non-observables
  late AnimationController animationController;
  final Random random = Random();
  
  // Getter pour l'exercice actuel
  AppariementInteractifModel get currentExercice => 
      exercices.isNotEmpty ? exercices[currentExerciceIndex.value] : AppariementInteractifModel.getExercicesAppariement().first;
  
  @override
  void onInit() {
    super.onInit();
    
    // Charger les exercices
    final allExercises = AppariementInteractifModel.getExercicesAppariement();
    debugPrint('Loaded ${allExercises.length} exercises');
    
    // Log exercise details for debugging
    for (int i = 0; i < allExercises.length; i++) {
      final exercise = allExercises[i];
      debugPrint('Exercise $i: ${exercise.titre}');
      
      // Log image paths for each pair
      for (int j = 0; j < exercise.paires.length; j++) {
        final pair = exercise.paires[j];
        if (pair.gauche.imagePath != null) {
          debugPrint('  Pair $j left image: ${pair.gauche.imagePath}');
        }
        if (pair.droite.imagePath != null) {
          debugPrint('  Pair $j right image: ${pair.droite.imagePath}');
        }
      }
    }
    
    exercices.assignAll(allExercises);
    
    // Initialiser l'animation controller pour les effets visuels
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    
    // Initialiser la mascotte de façon sécurisée
    try {
      if (!Get.isRegistered<MascotController>()) {
        Get.put(MascotController());
      }
      _mascotController = Get.find<MascotController>();
    } catch (e) {
      debugPrint('Erreur initialisation mascotte: $e');
      // Créer un contrôleur de mascotte factice en cas d'erreur
      _mascotController = MascotController();
    }
    
    // Choisir une mascotte aléatoire
    _mascotController.changeMascot(_getRandomMascot());
    
    // Afficher le message de la mascotte
    Future.delayed(const Duration(milliseconds: 500), () {
      if (currentExercice.mascotMessage != null) {
        MascotHelper.showMascotDialog(
          title: currentExercice.titre,
          message: currentExercice.mascotMessage!,
          state: MascotState.happy,
          buttonText: "C'est parti !",
        );
      }
      _mascotController.askQuestion();
    });
    
    // Préparer l'audio
    _prepareAudio();
  }
  
  @override
  void onClose() {
    audioPlayer.dispose();
    animationController.dispose();
    super.onClose();
  }
  
  // Initialiser les sons
  Future<void> _prepareAudio() async {
    try {
      // Vérifier d'abord que l'audio est disponible et traiter les erreurs silencieusement
      await audioPlayer.setAsset('assets/sfx/winner.mp3')
          .catchError((e) {
            debugPrint('Erreur précharge audio: $e');
            // Silence l'erreur pour ne pas planter l'app
            return null;
          });
    } catch (e) {
      debugPrint('Erreur lors du chargement audio: $e');
    }
  }
  
  // Jouer un son de succès
  Future<void> playSuccessSound() async {
    try {
      // Essayer de jouer le son de succès
      await audioPlayer.setAsset('assets/sfx/winner.mp3')
          .catchError((e) {
            debugPrint('Erreur chargement son de succès: $e');
            return null;
          });

      await audioPlayer.play()
          .catchError((e) {
            debugPrint('Erreur lecture son de succès: $e');
            return null;
          });
    } catch (e) {
      // Attraper toutes les autres erreurs
      debugPrint('Erreur générale lors de la lecture audio: $e');
    }
  }
  
  // Jouer un son d'erreur
  Future<void> playErrorSound() async {
    try {
      // Essayer de jouer le son d'erreur avec une approche robuste
      await audioPlayer.setAsset('assets/sfx/x.mp3')
          .catchError((e) {
            debugPrint('Erreur chargement son d\'erreur: $e');
            // Essayer un son alternatif en cas d'échec
            return audioPlayer.setAsset('assets/sfx/reset.mp3')
                .catchError((_) => null); // Ignorer les erreurs du son alternatif
          });

      await audioPlayer.play()
          .catchError((e) {
            debugPrint('Erreur lecture son d\'erreur: $e');
            return null;
          });
    } catch (e) {
      debugPrint('Erreur générale lors de la lecture du son d\'erreur: $e');
    }
  }
  
  // Obtenir une mascotte aléatoire
  MascotType _getRandomMascot() {
    final mascots = [MascotType.elephant, MascotType.owl, MascotType.panda];
    return mascots[random.nextInt(mascots.length)];
  }
  
  // ------------ Fonctions pour le mode "tracerLigne" ------------
  
  // Sélectionner un élément de gauche
  void selectLeftElement(ElementAppariement element) {
    if (correctElements.contains(element.id)) return;
    
    selectedLeftElement.value = element;
    _mascotController.changeState(MascotState.thinking);
    
    // Notify UI of selection change
    update(['line_connections']);
  }
  
  // Connecter un élément de gauche à un élément de droite
  void connectToRightElement(ElementAppariement rightElement) {
    if (selectedLeftElement.value == null || correctElements.contains(rightElement.id)) return;
    
    final leftElement = selectedLeftElement.value!;
    
    // Vérifier si la connexion existe déjà
    final existingConnectionIndex = connections.indexWhere(
      (conn) => conn.leftElement.id == leftElement.id
    );
    
    if (existingConnectionIndex != -1) {
      connections.removeAt(existingConnectionIndex);
    }
    
    // Ajouter la nouvelle connexion
    connections.add(Connection(
      leftElement: leftElement,
      rightElement: rightElement,
    ));
    
    // Notify UI of connection change
    update(['line_connections']);
    
    // Vérifier si la connexion est correcte
    bool isCorrect = false;
    for (final pair in currentExercice.paires) {
      if (pair.gauche.id == leftElement.id && pair.droite.id == rightElement.id) {
        isCorrect = true;
        break;
      }
    }
    
    if (isCorrect) {
      correctElements.add(leftElement.id);
      correctElements.add(rightElement.id);
      playSuccessSound();
      _mascotController.reactToCorrectAnswer();
      update(['line_connections']); // Update for correct state
    } else {
      incorrectElements.add(leftElement.id);
      incorrectElements.add(rightElement.id);
      playErrorSound();
      _mascotController.reactToIncorrectAnswer();
      update(['line_connections']); // Update for incorrect state
      
      // Supprimer les éléments incorrects après un court délai
      Future.delayed(const Duration(seconds: 1), () {
        incorrectElements.remove(leftElement.id);
        incorrectElements.remove(rightElement.id);
        
        // Retirer la connexion incorrecte
        connections.removeWhere(
          (conn) => conn.leftElement.id == leftElement.id && conn.rightElement.id == rightElement.id
        );
        
        // Update UI after removing incorrect connection
        update(['line_connections']);
      });
    }
    
    selectedLeftElement.value = null;
    
    // Vérifier si l'exercice est terminé
    checkExerciceCompletion();
  }
  
  // ------------ Fonctions pour le mode "glisserDeposer" ------------
  
  // Gérer le dépôt d'un élément
  void handleDrop(String sourceId, String targetId) {
    // Mettre à jour les valeurs des cibles
    dropTargetValues[targetId] = sourceId;
    
    // Vérifier si le dépôt est correct
    bool isCorrect = false;
    for (final pair in currentExercice.paires) {
      if ((pair.gauche.id == sourceId && pair.droite.id == targetId) || 
          (pair.droite.id == sourceId && pair.gauche.id == targetId)) {
        isCorrect = true;
        break;
      }
    }
    
    if (isCorrect) {
      correctElements.add(sourceId);
      correctElements.add(targetId);
      playSuccessSound();
      _mascotController.reactToCorrectAnswer();
      // We don't need update here as reactive state with Obx
    } else {
      incorrectElements.add(sourceId);
      incorrectElements.add(targetId);
      playErrorSound();
      _mascotController.reactToIncorrectAnswer();
      
      // Supprimer les éléments incorrects après un court délai
      Future.delayed(const Duration(seconds: 1), () {
        incorrectElements.remove(sourceId);
        incorrectElements.remove(targetId);
        
        // Retirer la valeur incorrecte
        dropTargetValues.remove(targetId);
        // Reactive state with Obx will handle the UI update
      });
    }
    
    // Vérifier si l'exercice est terminé
    checkExerciceCompletion();
  }
  
  // ------------ Fonctions pour le mode "selection" ------------
  
  // Sélectionner un élément
  void selectElement(ElementAppariement element) {
    if (correctElements.contains(element.id)) return;
    
    if (firstSelectedElement.value == null) {
      firstSelectedElement.value = element;
      elementsWithGlow.add(element.id);
      _mascotController.changeState(MascotState.thinking);
      
      // Update the UI for selection
      update(['selection_items']);
    } else if (secondSelectedElement.value == null && firstSelectedElement.value!.id != element.id) {
      secondSelectedElement.value = element;
      elementsWithGlow.add(element.id);
      
      // Update the UI immediately for selection
      update(['selection_items']);
      
      // Vérifier si la sélection est correcte
      bool isCorrect = false;
      for (final pair in currentExercice.paires) {
        if ((pair.gauche.id == firstSelectedElement.value!.id && pair.droite.id == element.id) || 
            (pair.droite.id == firstSelectedElement.value!.id && pair.gauche.id == element.id)) {
          isCorrect = true;
          completedPairs.add(pair);
          break;
        }
      }
      
      if (isCorrect) {
        correctElements.add(firstSelectedElement.value!.id);
        correctElements.add(element.id);
        playSuccessSound();
        _mascotController.reactToCorrectAnswer();
        update(['selection_items']); // Update for correct state
      } else {
        incorrectElements.add(firstSelectedElement.value!.id);
        incorrectElements.add(element.id);
        playErrorSound();
        _mascotController.reactToIncorrectAnswer();
        update(['selection_items']); // Update for incorrect state
      }
      
      // Réinitialiser la sélection après un court délai
      Future.delayed(const Duration(seconds: 1), () {
        if (!isCorrect) {
          incorrectElements.remove(firstSelectedElement.value!.id);
          incorrectElements.remove(element.id);
        }
        
        elementsWithGlow.remove(firstSelectedElement.value!.id);
        elementsWithGlow.remove(element.id);
        firstSelectedElement.value = null;
        secondSelectedElement.value = null;
        
        // Update UI after resetting selection
        update(['selection_items']);
      });
      
      // Vérifier si l'exercice est terminé
      checkExerciceCompletion();
    }
  }
  
  // ------------ Fonctions communes ------------
  
  // Vérifier si l'exercice est terminé
  void checkExerciceCompletion() {
    final totalPairs = currentExercice.paires.length;
    final completedCount = correctElements.length ~/ 2; // Diviser par 2 car chaque paire a 2 éléments
    
    // Mettre à jour la progression
    progressValue.value = completedCount / totalPairs;
    
    // Si toutes les paires sont complétées
    if (completedCount >= totalPairs) {
      score.value += currentExercice.points;
      correctAnswers.value++;
      showCelebration.value = true;
      
      // Afficher les résultats
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (Get.context != null) {
          showExerciceResults(Get.context!);
        }
      });
    }
  }
  
  // Afficher les résultats de l'exercice
  void showExerciceResults(BuildContext context) {
    isCheckingAnswer.value = true;
    
    // Message personnalisé basé sur la difficulté
    String customMessage;
    switch (currentExercice.difficulte) {
      case NiveauDifficulte.facile:
        customMessage = 'Bravo ! Tu as réussi l\'exercice d\'appariement facile !';
        break;
      case NiveauDifficulte.moyen:
        customMessage = 'Excellent ! Tu as complété l\'exercice de niveau moyen !';
        break;
      case NiveauDifficulte.difficile:
        customMessage = 'Impressionnant ! Tu as réussi l\'exercice difficile !';
        break;
    }
    
    // Afficher l'écran de résultats
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: true,
      totalXp: currentExercice.points,
      correctAnswers: 1,
      totalQuestions: 1,
      customMessage: customMessage,
      onContinue: () {
        isCheckingAnswer.value = false;
        showCelebration.value = false;
        
        // Passer à l'exercice suivant ou afficher les résultats finaux
        if (currentExerciceIndex.value < exercices.length - 1) {
          goToNextExercice();
        } else {
          showFinalResults(context);
        }
      },
    );
  }
  
  // Passer à l'exercice suivant
  void goToNextExercice() {
    if (currentExerciceIndex.value < exercices.length - 1) {
      currentExerciceIndex.value++;
      resetExercice();
      
      // Afficher le message de la mascotte pour le nouvel exercice
      if (currentExercice.mascotMessage != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          MascotHelper.showMascotDialog(
            title: currentExercice.titre,
            message: currentExercice.mascotMessage!,
            state: MascotState.happy,
            buttonText: "C'est parti !",
          );
        });
      }
    }
  }
  
  // Revenir à l'exercice précédent
  void goToPreviousExercice() {
    if (currentExerciceIndex.value > 0) {
      currentExerciceIndex.value--;
      resetExercice();
      
      // Afficher le message de la mascotte pour le nouvel exercice
      if (currentExercice.mascotMessage != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          MascotHelper.showMascotDialog(
            title: currentExercice.titre,
            message: currentExercice.mascotMessage!,
            state: MascotState.happy,
            buttonText: "C'est parti !",
          );
        });
      }
    }
  }
  
  // Réinitialiser l'exercice actuel
  void resetExercice() {
    connections.clear();
    selectedLeftElement.value = null;
    dropTargetValues.clear();
    firstSelectedElement.value = null;
    secondSelectedElement.value = null;
    completedPairs.clear();
    elementsWithGlow.clear();
    correctElements.clear();
    incorrectElements.clear();
    progressValue.value = 0.0;
    
    _mascotController.askQuestion();
  }
  
  // Afficher les résultats finaux
  void showFinalResults(BuildContext context) {
    // Calculer la performance globale
    final bool isPerfect = correctAnswers.value == exercices.length;
    final int percentage = (correctAnswers.value / exercices.length * 100).toInt();
    
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
      finalMessage = 'Parfait ! Tu as réussi tous les exercices d\'appariement ! Tu es un champion !';
    } else if (percentage >= 80) {
      finalMessage = 'Excellent ! Tu as réussi $percentage% des exercices !';
    } else if (percentage >= 60) {
      finalMessage = 'Bien joué ! Tu as réussi $percentage% des exercices. Continue comme ça !';
    } else {
      finalMessage = 'Tu as terminé la session avec $percentage% des exercices réussis. Essaie encore pour t\'améliorer !';
    }
    
    // Afficher les résultats finaux
    LessonResultHelper.showResultScreen(
      context: context,
      isPerfect: isPerfect,
      totalXp: score.value,
      correctAnswers: correctAnswers.value,
      totalQuestions: exercices.length,
      customMessage: finalMessage,
      onContinue: () {
        // Revenir à l'écran précédent
        Get.back();
      },
    );
  }
}

// Classe pour représenter une connexion entre deux éléments
class Connection {
  final ElementAppariement leftElement;
  final ElementAppariement rightElement;
  
  Connection({
    required this.leftElement,
    required this.rightElement,
  });
}