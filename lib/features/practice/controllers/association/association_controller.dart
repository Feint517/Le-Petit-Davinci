import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_data.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/features/practice/models/color_combination_item.dart';
import 'package:kids_learning_app/features/practice/models/color_identification_item.dart';
import 'package:kids_learning_app/features/practice/models/counting_exercise_item.dart';
import 'package:kids_learning_app/features/practice/models/counting_item.dart';
import 'package:kids_learning_app/features/practice/models/matching_item.dart';
import 'package:kids_learning_app/features/practice/models/rainbow_colors_item.dart';
import 'package:kids_learning_app/features/practice/models/size_comparison_item.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/mascot_feedback_dialog.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AssociationController extends GetxController {
  //=========================================================================
  // COMMON PROPERTIES ACROSS ALL SERIES
  //=========================================================================

  /// Current selected exercise from the dropdown
  var selectedExercise = "Serie 1 - la bonne couleur".obs;

  /// Current index of the exercise within the series
  var currentExerciseIndex = 0.obs;

  /// Flag indicating whether the answer has been validated
  var isAnswerValidated = false.obs;

  /// Total points earned by the user
  var points = 0.obs;

  /// Flag indicating whether the current exercise set is completed
  var isExerciseCompleted = false.obs;

  //=========================================================================
  // SERIES 1 - ASSOCIATION PROPERTIES
  //=========================================================================

  /// Selected answer for association exercises (Series 1)
  var selectedAnswer = Rxn<String>();

  //=========================================================================
  // SERIES 2 - SIZE COMPARISON PROPERTIES
  //=========================================================================

  /// Currently selected largest item in size comparison (Series 2)
  var selectedLargest = Rxn<String>();

  /// Item currently circled in size comparison exercises
  var circledItem = Rxn<String>();

  /// Map of completed drawings, tracking user's drawings
  var completedDrawings = <String, List<Offset>>{}.obs;

  //=========================================================================
  // SERIES 3 - COLOR COMBINATION PROPERTIES
  //=========================================================================

  /// Selected color answer for color combination exercises (Series 3)
  var selectedColorAnswer = Rxn<String>();

  /// Flag to control color palette visibility in color exercises
  var colorPaletteVisible = false.obs;

  //=========================================================================
  // SERIES 4 - COLOR IDENTIFICATION PROPERTIES
  //=========================================================================

  /// Selected color image index for Series 4
  var selectedColorImageIndex = Rxn<int>();

  //=========================================================================
  // SERIES 5 - RAINBOW COLORS PROPERTIES
  //=========================================================================

  /// Currently selected band index in rainbow exercises (Series 5)
  var selectedBandIndex = Rxn<int>();

  /// Flag to control visibility of the color palette in Series 5
  var showColorPalette = false.obs;

  /// List of completed bands in rainbow exercises
  var completedBands = <int>[].obs;

  //=========================================================================
  // SERIES 6 - MATCHING PROPERTIES
  //=========================================================================

  /// Currently selected left item ID in matching exercises (Series 6)
  final Rx<String?> selectedLeftItemId = Rx<String?>(null);

  /// Currently selected right item ID in matching exercises (Series 6)
  var selectedRightItemId = Rxn<String>();

  /// Map of connections between left and right items (leftId -> rightId)
  var connections = <String, String>{}.obs;

  /// Start position for the animating connection line
  var animatingLineStartPos = Rxn<Offset>();

  /// End position for the animating connection line
  var animatingLineEndPos = Rxn<Offset>();

  /// Flag indicating if a connection animation is in progress
  var isAnimatingConnection = false.obs;

  /// Progress value for line animation (0.0 to 1.0)
  var animatedLineProgress = 0.0.obs;

  /// Cache for shuffled right pairs to maintain consistency
  final Map<String, List<MatchPair>> _shuffledPairsCache = {};

  //=========================================================================
  // SERIES 7 & 8 - COUNTING PROPERTIES
  //=========================================================================

  /// Selected counting value for Series 7 & 8 exercises
  var countingSelectedValue = Rxn<int>();

  //=========================================================================
  // CONVENIENCE GETTERS
  //=========================================================================

  /// Check if current exercise is in Series 2
  bool get isInSeries2 => selectedExercise.value.contains("Serie 2");

  /// Check if current exercise is in Series 3
  bool get isInSeries3 => selectedExercise.value.contains("Serie 3");

  /// Check if current exercise is in Series 4
  bool get isInSeries4 => selectedExercise.value.contains("Serie 4");

  /// Check if current exercise is in Series 5
  bool get isInSeries5 => selectedExercise.value.contains("Serie 5");

  /// Check if current exercise is in Series 6
  bool get isInSeries6 => selectedExercise.value.contains("Serie 6");

  /// Check if current exercise is in Series 7
  bool get isInSeries7 => selectedExercise.value.contains("Serie 7");

  /// Check if current exercise is in Series 8
  bool get isInSeriesEight => selectedExercise.value.contains("Serie 8");

  /// Check if this is the last exercise in the current series
  bool get isLastExerciseInSeries {
    final currentIndex = exercisesList.indexOf(selectedExercise.value);
    if (currentIndex < 0 || currentIndex >= exercisesList.length - 1) {
      return true;
    }

    final currentSeries = selectedExercise.value.split(" - ")[0];
    final nextSeries = exercisesList[currentIndex + 1].split(" - ")[0];

    return currentSeries != nextSeries;
  }

  /// Get all exercises for the current selection
  dynamic get currentExercises {
    return allExercises[selectedExercise.value] ?? [];
  }

  /// Get the current exercise based on the currentExerciseIndex
  dynamic get currentExercise {
    if (currentExercises.isEmpty) {
      // Return default objects based on series type if no exercises available
      if (isInSeries4) {
        return ColorIdentificationItem(
          targetColor: "",
          images: [],
          correctIndex: 0,
        );
      } else if (isInSeries2) {
        return SizeComparisonItem(
          instruction: "",
          itemGroup: ItemGroup(
            groupName: "",
            category: "",
            imagePath: "",
            sizeOptions: [],
          ),
        );
      } else {
        return AssociationItem(
          instruction: "",
          imagePath: "",
          options: [],
          correctAnswer: "",
        );
      }
    }

    // Ensure index is within bounds
    if (currentExerciseIndex.value >= currentExercises.length) {
      currentExerciseIndex.value = currentExercises.length - 1;
    }

    return currentExercises[currentExerciseIndex.value];
  }

  //=========================================================================
  // GENERAL CONTROLLER METHODS
  //=========================================================================

  /// Change the current exercise
  void changeExercise(String? newValue) {
    if (newValue != null) {
      selectedExercise.value = newValue;
      currentExerciseIndex.value = 0;
      resetExercise();
    }
  }

  /// Reset the current exercise to its initial state
  void resetExercise() {
    // Reset all selection states
    selectedAnswer.value = null;
    circledItem.value = null;
    selectedColorAnswer.value = null;
    selectedColorImageIndex.value = null;
    colorPaletteVisible.value = false;
    completedDrawings.clear();
    isAnswerValidated.value = false;
    countingSelectedValue.value = null;

    // Series specific resets
    resetConnections();
    resetItemHighlights();

    // Reset counting categories if in Series 7
    if (isInSeries7) {
      final exercise = currentExercise as CountingItem;
      for (var category in exercise.categories) {
        category.reset();
      }
    }

    // Reset Series 5 if applicable
    if (isInSeries5) {
      resetSeries5();
    }
  }

  /// Move to the next exercise in the series
  void nextExercise() {
    if (currentExerciseIndex.value < currentExercises.length - 1) {
      currentExerciseIndex.value++;
      resetExercise();
    } else {
      isExerciseCompleted.value = true;
      showFeedback("Félicitations!", "Tu as terminé cet exercice!");
    }
  }

  /// Navigate to the previous exercise in the list
  void navigateToPreviousExercise() {
    final currentIndex = exercisesList.indexOf(selectedExercise.value);
    if (currentIndex > 0) {
      selectedExercise.value = exercisesList[currentIndex - 1];
      currentExerciseIndex.value = 0;
      resetExercise();
      showFeedback("Navigation", "Navigation à l'exercice précédent");
    } else {
      showFeedback("Attention", "Vous êtes déjà au premier exercice");
    }
  }

  /// Navigate to the next exercise in the list
  void navigateToNextExercise() {
    final currentIndex = exercisesList.indexOf(selectedExercise.value);
    if (currentIndex < exercisesList.length - 1) {
      selectedExercise.value = exercisesList[currentIndex + 1];
      currentExerciseIndex.value = 0;
      resetExercise();
      showFeedback("Navigation", "Navigation à l'exercice suivant");
    } else {
      showFeedback("Attention", "Vous êtes déjà au dernier exercice");
    }
  }

  /// Display a simple feedback message
  void showFeedback(String title, String message, {int duration = 2}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primaryDeep,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      icon: Icon(_getIconForFeedback(title), color: Colors.white),
    );
  }

  /// Get the appropriate icon for feedback messages
  IconData _getIconForFeedback(String title) {
    if (title.contains("Bravo") || title.contains("Félicitations")) {
      return Icons.check_circle;
    } else if (title.contains("Attention")) {
      return Icons.warning;
    } else if (title.contains("Essaie")) {
      return Icons.replay;
    } else {
      return Icons.info;
    }
  }

  /// Primary validation method for checking answers across all series
  void validateAnswer() {
    // Different validation logic based on the series type
    if (isInSeriesEight) {
      _validateSeries8Answer();
    } else if (isInSeries7) {
      validateCountingAnswer();
    } else if (isInSeries6) {
      _validateSeries6Answer();
    } else if (isInSeries5) {
      _validateSeries5Answer();
    } else if (isInSeries4) {
      _validateSeries4Answer();
    } else if (isInSeries3) {
      _validateSeries3Answer();
    } else if (isInSeries2) {
      _validateSeries2Answer();
    } else {
      _validateSeries1Answer();
    }
  }

  //=========================================================================
  // SERIES 1 - ASSOCIATION METHODS
  //=========================================================================

  /// Validate answers for Series 1 exercises
  void _validateSeries1Answer() {
    if (selectedAnswer.value == null) {
      showMascotFeedback(
        title: "Attention",
        message: "Sélectionne une réponse avant de vérifier",
        mood: MascotMood.question,
      );
      return;
    }

    isAnswerValidated.value = true;

    if (selectedAnswer.value == currentExercise.correctAnswer) {
      points.value += 5;
      showMascotFeedback(
        title: "Bravo!",
        message: "C'est la bonne réponse!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message:
            "Ce n'est pas la bonne réponse. La réponse correcte était: ${currentExercise.correctAnswer}",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          isAnswerValidated.value = false;
          selectedAnswer.value = null;
        },
      );
    }
  }

  //=========================================================================
  // SERIES 2 - SIZE COMPARISON METHODS
  //=========================================================================

  /// Select the largest item in size comparison exercises
  void selectLargestItem(String size) {
    if (isAnswerValidated.value) return;

    if (circledItem.value != null) {
      resetLargestSelection();
    }

    circledItem.value = size;
    _updateSelectionState();

    // Auto-validate after a delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  /// Reset the largest item selection
  void resetLargestSelection() {
    circledItem.value = null;
    _updateSelectionState();
  }

  /// Update the selection state in the model
  void _updateSelectionState() {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;

      for (var option in exercise.itemGroup.sizeOptions) {
        option.resetSelection();
      }

      if (circledItem.value != null) {
        for (var option in exercise.itemGroup.sizeOptions) {
          if (option.size == circledItem.value) {
            option.isLargestSelected.value = true;
            option.isSelected.value = true;
          }
        }
      }
    }
  }

  /// Select an item by ID and size in Series 2
  void selectItem(String itemId, String size) {
    if (isAnswerValidated.value) return;
    selectLargestItem(size);
  }

  /// Reset all item highlights
  void resetItemHighlights() {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;
      for (var option in exercise.itemGroup.sizeOptions) {
        option.resetSelection();
      }
    }
  }

  /// Update the bounds of an item in the UI
  void updateItemBounds(String itemId, Rect bounds) {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;

      for (var option in exercise.itemGroup.sizeOptions) {
        if ('${exercise.itemGroup.groupName}_${option.size}' == itemId) {
          option.updateBounds(bounds);
          break;
        }
      }
    }
  }

  /// Validate answers for Series 2 exercises
  void _validateSeries2Answer() {
    if (circledItem.value == null) {
      showMascotFeedback(
        title: "Attention",
        message: "Sélectionne l'image la plus grande avant de vérifier",
        mood: MascotMood.question,
      );
      return;
    }

    isAnswerValidated.value = true;

    if (circledItem.value == "grand") {
      points.value += 5;

      showMascotFeedback(
        title: "Bravo!",
        message: "Tu as gagné 5 points! C'est la bonne réponse!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message: "Ce n'est pas la plus grande image. Essaie encore!",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          isAnswerValidated.value = false;
          resetLargestSelection();
        },
      );
    }
  }

  //=========================================================================
  // SERIES 3 - COLOR COMBINATION METHODS
  //=========================================================================

  /// Toggle visibility of the color palette
  void toggleColorPalette() {
    colorPaletteVisible.value = !colorPaletteVisible.value;
  }

  /// Select a color answer for Series 3
  void selectColorAnswer(String color) {
    selectedColorAnswer.value = color;
    colorPaletteVisible.value = false;

    // Auto-validate after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  /// Validate answers for Series 3 exercises
  void _validateSeries3Answer() {
    if (selectedColorAnswer.value == null) {
      showMascotFeedback(
        title: "Attention",
        message: "Sélectionne une couleur avant de vérifier",
        mood: MascotMood.question,
      );
      return;
    }

    isAnswerValidated.value = true;
    final exercise = currentExercise as ColorCombinationItem;

    if (selectedColorAnswer.value == exercise.resultColor) {
      points.value += 5;
      showMascotFeedback(
        title: "Bravo!",
        message: "Tu as trouvé la bonne couleur!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message:
            "Ce n'est pas la bonne couleur. La réponse correcte était: ${exercise.resultColor}",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          isAnswerValidated.value = false;
          selectedColorAnswer.value = null;
        },
      );
    }
  }

  //=========================================================================
  // SERIES 4 - COLOR IDENTIFICATION METHODS
  //=========================================================================

  /// Select a color image in Series 4
  void selectColorImage(int index) {
    selectedColorImageIndex.value = index;

    // Auto-validate after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  /// Validate answers for Series 4 exercises
  void _validateSeries4Answer() {
    if (selectedColorImageIndex.value == null) {
      showMascotFeedback(
        title: "Attention",
        message: "Sélectionne une image avant de vérifier",
        mood: MascotMood.question,
      );
      return;
    }

    isAnswerValidated.value = true;
    final exercise = currentExercise as ColorIdentificationItem;

    if (selectedColorImageIndex.value == exercise.correctIndex) {
      points.value += 5;
      showMascotFeedback(
        title: "Bravo!",
        message:
            "Tu as correctement identifié la couleur ${exercise.targetColor}!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message:
            "Ce n'est pas la bonne image. L'image correcte est ${exercise.correctImage.objectName}.",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          isAnswerValidated.value = false;
          selectedColorImageIndex.value = null;
        },
      );
    }
  }

  //=========================================================================
  // SERIES 5 - RAINBOW COLORS METHODS
  //=========================================================================

  /// Select a rainbow band in Series 5
  void selectBand(int index) {
    // Only allow selection if not already completed
    if (!completedBands.contains(index)) {
      selectedBandIndex.value = index;
      showColorPalette.value = true;
    }
  }

  /// Close the color palette in Series 5
  void closeColorPalette() {
    showColorPalette.value = false;
    selectedBandIndex.value = null;
  }

  /// Get a Color object from a color name
  Color getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "rouge":
        return Colors.red;
      case "orange":
        return Colors.orange;
      case "jaune":
        return Colors.yellow;
      case "vert":
        return Colors.green;
      case "bleu":
        return Colors.blue;
      case "indigo":
        return const Color(0xFF4B0082);
      case "violet":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  /// Select a color for a band in Series 5
  void selectColor(String colorName) {
    if (selectedBandIndex.value != null) {
      final index = selectedBandIndex.value!;
      final exercise = currentExercise as RainbowColorsItem;

      // Check if correct color was selected
      if (colorName.toLowerCase() == exercise.bands[index].name.toLowerCase()) {
        // Mark as completed
        completedBands.add(index);

        // Show success feedback
        showMascotFeedback(
          title: "Bravo!",
          message: "Tu as trouvé la bonne couleur!",
          mood: MascotMood.happy,
          buttonText: "Continuer",
        );

        // Add points for correct color
        points.value += 1;

        // If all bands are completed, award bonus points
        if (completedBands.length == exercise.bands.length) {
          Future.delayed(Duration(milliseconds: 800), () {
            points.value += 3; // Bonus for completing all
            showMascotFeedback(
              title: "Félicitations!",
              message: "Tu as complété tout l'arc-en-ciel!",
              mood: MascotMood.happy,
              buttonText: "Continuer",
              onConfirm: () {
                // Move to next exercise if available
                if (currentExerciseIndex.value < currentExercises.length - 1) {
                  nextExercise();
                }
              },
            );
          });
        }
      } else {
        // Wrong color selected
        showMascotFeedback(
          title: "Essaie encore",
          message: "Ce n'est pas la bonne couleur pour cette ligne.",
          mood: MascotMood.sad,
          buttonText: "Réessayer",
        );
      }

      // Hide palette after selection
      showColorPalette.value = false;
      selectedBandIndex.value = null;
    }
  }

  /// Reset Series 5 exercise
  void resetSeries5() {
    selectedBandIndex.value = null;
    showColorPalette.value = false;
    completedBands.clear();
  }

  /// Validate answers for Series 5 exercises
  void _validateSeries5Answer() {
    final exercise = currentExercise as RainbowColorsItem;

    // Check if all bands are completed
    if (completedBands.length < exercise.bands.length) {
      // Not all bands are completed
      final remainingCount = exercise.bands.length - completedBands.length;

      showMascotFeedback(
        title: "Pas encore terminé",
        message:
            "Il reste encore $remainingCount couleur${remainingCount > 1 ? 's' : ''} à identifier.",
        mood: MascotMood.question,
      );
    } else {
      // All bands are completed - award points and proceed to next exercise
      showMascotFeedback(
        title: "Félicitations!",
        message: "Tu as complété l'arc-en-ciel avec succès!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    }
  }

  //=========================================================================
  // SERIES 6 - MATCHING METHODS
  //=========================================================================

  /// Get a shuffled list of the right pairs for matching exercises
  List<MatchPair> getShuffledRightPairs(MatchingItem exercise) {
    // Create a copy of the original pairs to avoid modifying them directly
    final List<MatchPair> originalPairs = exercise.pairs;

    // Check if we already cached the shuffled pairs for this exercise
    // This ensures the order remains consistent during the exercise
    if (_shuffledPairsCache[exercise.title] != null) {
      return _shuffledPairsCache[exercise.title]!;
    }

    // Create new list and shuffle it with consistent seed
    final List<MatchPair> shuffledPairs = List<MatchPair>.from(originalPairs);
    shuffledPairs.shuffle(Random(exercise.title.hashCode));

    // Cache the result
    _shuffledPairsCache[exercise.title] = shuffledPairs;

    return shuffledPairs;
  }

  /// Select an item for connection in Series 6
  void selectItemForConnection(String id, bool isLeft, Offset position) {
    if (isAnswerValidated.value) return;

    if (isLeft) {
      // When selecting a left item
      if (selectedLeftItemId.value == id) {
        // Deselect if same item clicked again
        selectedLeftItemId.value = null;
        animatingLineStartPos.value = null;
      } else {
        // Only allow selection if this item is not already connected
        final exercise = currentExercise as MatchingItem;
        bool isAlreadyConnected = false;

        for (var pair in exercise.pairs) {
          if (pair.id == id && pair.connectedToId.value.isNotEmpty) {
            isAlreadyConnected = true;
            break;
          }
        }

        if (!isAlreadyConnected && !isAnimatingConnection.value) {
          // Set as the selected left item
          selectedLeftItemId.value = id;
          animatingLineStartPos.value = position;
        }
      }
    } else if (!isAnimatingConnection.value) {
      // When selecting a right item - only works if we have a left item selected
      if (selectedLeftItemId.value != null) {
        // Check if this right item is already connected
        final exercise = currentExercise as MatchingItem;
        bool isAlreadyConnected = false;

        for (var pair in exercise.pairs) {
          if (pair.id == id && pair.connectedToId.value.isNotEmpty) {
            isAlreadyConnected = true;
            break;
          }
        }

        if (!isAlreadyConnected) {
          animatingLineEndPos.value = position;
          // Start the connection animation
          _startConnectionAnimation(selectedLeftItemId.value!, id);
        }
      }
    }
  }

  /// Complete a connection after animation finishes
  /// Complete a connection after animation finishes
  void _completeConnection(String leftId, String rightId) {
    // Store the connection in the controller map
    connections[leftId] = rightId;

    // Update the connection state in the pairs
    final exercise = currentExercise as MatchingItem;

    // Find and update left pair
    for (var pair in exercise.pairs) {
      if (pair.id == leftId) {
        // Update left item connection
        pair.connectedToId.value = rightId;
        pair.isConnected.value = true;

        // Check if connection is correct (same ID means correct match)
        if (leftId == rightId) {
          pair.isCorrect.value = true;
        }

        // Update position for the line
        if (animatingLineStartPos.value != null) {
          pair.leftPosition = animatingLineStartPos.value!;
        }
      }

      // Find and update right item if it's found
      // Note: This might be a different object than the left item
      if (pair.id == rightId) {
        // Mark the right item as connected too
        pair.connectedToId.value = leftId;
        pair.isConnected.value = true;

        if (animatingLineEndPos.value != null) {
          pair.rightPosition = animatingLineEndPos.value!;
        }
      }
    }

    // Reset selection state
    selectedLeftItemId.value = null;

    // Check if all pairs are connected
    if (connections.length == exercise.pairs.length) {
      validateAnswer();
    }
  }

  /// Start the animation for a new connection
  void _startConnectionAnimation(String leftId, String rightId) {
    // Reset animation progress
    animatedLineProgress.value = 0.0;
    isAnimatingConnection.value = true;

    // Start animation timer
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      animatedLineProgress.value += 0.05;

      if (animatedLineProgress.value >= 1.0) {
        timer.cancel();
        isAnimatingConnection.value = false;
        // Complete the connection after animation
        _completeConnection(leftId, rightId);
      }
    });
  }

  /// Update item positions for drawing lines
  void updateItemPosition(String id, bool isLeft, Offset position) {
    if (isInSeries6) {
      final exercise = currentExercise as MatchingItem;
      for (var pair in exercise.pairs) {
        if (pair.id == id) {
          if (isLeft) {
            pair.leftPosition = position;
          } else {
            pair.rightPosition = position;
          }
          break;
        }
      }
    }
  }

  /// Legacy method for item selection (keeping for backward compatibility)
  void selectItemE(String id, bool isLeft, Offset position) {
    selectItemForConnection(id, isLeft, position);
  }

  /// Reset all connections in Series 6
  void resetConnections() {
    connections.clear();
    animatingLineStartPos.value = null;
    animatingLineEndPos.value = null;
    isAnimatingConnection.value = false;
    selectedLeftItemId.value = null;
    selectedRightItemId.value = null;
    animatedLineProgress.value = 0.0;

    if (isInSeries6) {
      final exercise = currentExercise as MatchingItem;
      for (var pair in exercise.pairs) {
        pair.reset();
      }
    }
  }

  /// Get a color for display based on an option string
  Color getColorForOption(String option) {
    switch (option.toLowerCase()) {
      case "vert":
        return Colors.green;
      case "rouge":
        return Colors.red;
      case "jaune":
        return Colors.amber;
      case "bleu":
        return Colors.blue[800] ?? Colors.blue;
      case "violet":
        return Colors.purple;
      case "rose":
        return Colors.pink;
      case "chat":
      case "chien":
      case "lapin":
      case "oiseau":
      case "poisson":
      case "souris":
        return Colors.blueGrey;
      case "pomme":
      case "banane":
      case "orange":
      case "fraise":
      case "raisin":
      case "poire":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  /// Validate answers for Series 6 exercises
  void _validateSeries6Answer() {
    isAnswerValidated.value = true;
    final exercise = currentExercise as MatchingItem;
    bool allCorrect = true;

    // Check if all connections are correct
    for (var pair in exercise.pairs) {
      if (connections[pair.id] == pair.id) {
        pair.isCorrect.value = true;
      } else {
        allCorrect = false;
      }
    }

    if (allCorrect) {
      points.value += 5;
      showMascotFeedback(
        title: "Bravo!",
        message: "Toutes les connections sont correctes!",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message: "Certaines connections ne sont pas correctes.",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          resetConnections();
          isAnswerValidated.value = false;
        },
      );
    }
  }

  //=========================================================================
  // SERIES 7 - COUNTING METHODS
  //=========================================================================

  /// Validate counting answers for Series 7
  void validateCountingAnswer() {
    if (isInSeries7) {
      isAnswerValidated.value = true;
      final exercise = currentExercise as CountingItem;

      // Check all category answers
      int correctCount = 0;
      for (var category in exercise.categories) {
        category.isValidated.value = true;
        if (category.isCorrect()) {
          correctCount++;
        }
      }

      // All correct
      if (correctCount == exercise.categories.length) {
        points.value += 5;
        showMascotFeedback(
          title: "Bravo!",
          message: "Tu as correctement compté tous les objets!",
          mood: MascotMood.happy,
          buttonText: "Continuer",
          onConfirm: () {
            if (currentExerciseIndex.value < currentExercises.length - 1) {
              nextExercise();
            }
          },
        );
      }
      // Some correct
      else if (correctCount > 0) {
        showMascotFeedback(
          title: "Presque!",
          message:
              "Tu as trouvé $correctCount/${exercise.categories.length} réponses correctes. Essaie encore!",
          mood: MascotMood.question,
          buttonText: "Réessayer",
          onConfirm: () {
            resetExercise();
          },
        );
      }
      // None correct
      else {
        showMascotFeedback(
          title: "Essaie encore",
          message: "Continue à compter attentivement les objets!",
          mood: MascotMood.sad,
          buttonText: "Réessayer",
          onConfirm: () {
            resetExercise();
          },
        );
      }
    }
  }

  //=========================================================================
  // SERIES 8 - COUNTING METHODS
  //=========================================================================
  /// Currently animating option number for bounce effect
  final Rx<int?> _animatingOptionNumber = Rx<int?>(null);

  /// Set the currently animating option for visual feedback
  void setAnimatingOption(int number) {
    _animatingOptionNumber.value = number;
  }

  /// Clear the animating option
  void clearAnimatingOption() {
    _animatingOptionNumber.value = null;
  }

  /// Check if a specific option is currently animating
  bool isAnimatingOption(int number) {
    return _animatingOptionNumber.value == number;
  }

  /// Plays a selection animation for the given option number
  void playSelectionAnimation(int number) {
    // This method can be extended with sound effects:
    // For example, using a sound package:
    // audioPlayer.play('assets/sounds/click.mp3');

    // Simple animation timing for feedback
    setAnimatingOption(number);

    // Clear animation after duration
    Future.delayed(const Duration(milliseconds: 300), () {
      clearAnimatingOption();
    });
  }

  /// Select a counting answer in Series 8
  void selectCountingAnswer(int number) {
    countingSelectedValue.value = number;
  }

  /// Validate answers for Series 8 exercises
  void _validateSeries8Answer() {
    // Validate Series 8 exercises (counting)
    if (countingSelectedValue.value == null) {
      showMascotFeedback(
        title: "Attention",
        message: "Sélectionne une réponse avant de vérifier",
        mood: MascotMood.question,
      );
      return;
    }

    isAnswerValidated.value = true;
    final exercise = currentExercise as CountingExerciseItem;

    // Check if the answer is correct
    if (countingSelectedValue.value == exercise.correctCount) {
      points.value += 5;
      showMascotFeedback(
        title: "Bravo!",
        message:
            "C'est la bonne réponse! Tu as bien compté les ${exercise.objectName}.",
        mood: MascotMood.happy,
        buttonText: "Continuer",
        onConfirm: () {
          if (currentExerciseIndex.value < currentExercises.length - 1) {
            nextExercise();
          }
        },
      );
    } else {
      showMascotFeedback(
        title: "Essaie encore",
        message:
            "Ce n'est pas la bonne réponse. Essaie de compter à nouveau les ${exercise.objectName}.",
        mood: MascotMood.sad,
        buttonText: "Réessayer",
        onConfirm: () {
          isAnswerValidated.value = false;
          countingSelectedValue.value = null;
        },
      );
    }
  }

  final RxBool showVisualCount = RxBool(false);
}
