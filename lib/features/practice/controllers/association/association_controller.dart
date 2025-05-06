// association_controller.dart
// Controller for handling logic
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
// Import new model
import 'package:kids_learning_app/features/practice/models/size_comparison_item.dart';
// Import drawing utilities
import 'package:kids_learning_app/utils/constants/colors.dart';

class AssociationController extends GetxController {
  //* State variables as observables
  var selectedExercise =
      "Serie 1 - la bonne couleur".obs; // Changed from Exercice to Serie
  var currentExerciseIndex = 0.obs;
  var selectedAnswer = Rxn<String>();
  var isAnswerValidated = false.obs;
  var points = 0.obs;
  var isExerciseCompleted = false.obs;

  //* for serie 2 - simplified to only track largest selection
  var selectedLargest = Rxn<String>();
  // Removed selectionMode since we only have largest selection now

  // New variables for Series 2 - removed crossedItem
  var circledItem = Rxn<String>();
  var completedDrawings =
      <String, List<Offset>>{}.obs; // Store completed drawings by item ID

  //* Exercises list for dropdown - Updated to include expanded Series 2
  final List<String> exercisesList = [
    "Serie 1 - la bonne couleur",
    "Serie 1 - les animaux",
    "Serie 1 - les fruits",
    // Expanded Series 2 to 8 exercises (one object type per step)
    "Serie 2 - grand et petit (1 - Hippopotames)",
    "Serie 2 - grand et petit (2 - Vélos)",
    "Serie 2 - grand et petit (3 - Cerfs)",
    "Serie 2 - grand et petit (4 - Marteaux)",
    "Serie 2 - grand et petit (5 - Chiens)",
    "Serie 2 - grand et petit (6 - Lunettes)",
    "Serie 2 - grand et petit (7 - Pandas)",
    "Serie 2 - grand et petit (8 - Stylos)",
  ];

  //* Exercise data map - Updated to include expanded Series 2
  final Map<String, dynamic> allExercises = {
    "Serie 1 - la bonne couleur": [
      // Updated from Exercice to Serie
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/mittens_red.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Rouge",
      ),
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/banana.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Jaune",
      ),
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/apple.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Rouge",
      ),
    ],
    "Serie 1 - les animaux": [
      // Fixed key name from "Exercice 2 - les animaux"
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/cat.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Chat",
      ),
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/dog.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Chien",
      ),
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/rabbit.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Lapin",
      ),
    ],
    "Serie 1 - les fruits": [
      // Fixed key name from "Exercice 3 - les fruits"
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/apple.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Pomme",
      ),
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/banana.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Banane",
      ),
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/strawberry.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Fraise",
      ),
    ],

    // UPDATED SERIES 2 EXERCISES - Each showing only one type of object
    // The instructions are now updated to reflect the single selection task
    "Serie 2 - grand et petit (1 - Hippopotames)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Hippopotames",
          category: "Animaux sauvages",
          imagePath: "assets/images/exercises/size/hippo.png",
          sizeOptions: [
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (2 - Vélos)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Vélos",
          category: "Véhicules",
          imagePath: "assets/images/exercises/size/bicycle.png",
          sizeOptions: [
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (3 - Cerfs)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Cerfs",
          category: "Animaux sauvages",
          imagePath: "assets/images/exercises/size/deer.png",
          sizeOptions: [
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (4 - Marteaux)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Marteaux",
          category: "Outils",
          imagePath: "assets/images/exercises/size/hammer.png",
          sizeOptions: [
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (5 - Chiens)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Chiens",
          category: "Animaux domestiques",
          imagePath: "assets/images/exercises/size/dog.png",
          sizeOptions: [
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (6 - Lunettes)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Lunettes",
          category: "Accessoires",
          imagePath: "assets/images/exercises/size/glasses.png",
          sizeOptions: [
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (7 - Pandas)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Pandas",
          category: "Animaux sauvages",
          imagePath: "assets/images/exercises/size/panda.png",
          sizeOptions: [
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
          ],
        ),
      ),
    ],
    "Serie 2 - grand et petit (8 - Stylos)": [
      SizeComparisonItem(
        instruction: "Sélectionne l'image la plus grande.",
        itemGroup: ItemGroup(
          groupName: "Stylos",
          category: "Fournitures scolaires",
          imagePath: "assets/images/exercises/size/pen.png",
          sizeOptions: [
            SizeOption(size: "grand", label: "Grand", scale: 1.0),
            SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
            SizeOption(size: "petit", label: "Petit", scale: 0.5),
          ],
        ),
      ),
    ],
  };

  //* Getter to check if current exercise is in Series 2
  bool get isInSeries2 => selectedExercise.value.contains("Serie 2");

  //* Check if current exercise is the last one in its series
  bool get isLastExerciseInSeries {
    final currentIndex = exercisesList.indexOf(selectedExercise.value);
    if (currentIndex < 0 || currentIndex >= exercisesList.length - 1) {
      return true;
    }

    final currentSeries = selectedExercise.value.split(" - ")[0];
    final nextSeries = exercisesList[currentIndex + 1].split(" - ")[0];

    return currentSeries != nextSeries;
  }

  //* Getter for current exercises list
  dynamic get currentExercises {
    return allExercises[selectedExercise.value] ?? [];
  }

  //* Getter for current exercise item
  dynamic get currentExercise {
    if (currentExercises.isEmpty) {
      if (isInSeries2) {
        // Updated default for Series 2
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

    //* Ensure index is within bounds
    if (currentExerciseIndex.value >= currentExercises.length) {
      currentExerciseIndex.value = currentExercises.length - 1;
    }

    return currentExercises[currentExerciseIndex.value];
  }

  //* Methods for handling logic
  void changeExercise(String? newValue) {
    if (newValue != null) {
      selectedExercise.value = newValue;
      currentExerciseIndex.value = 0;
      resetExercise();
    }
  }

  // Modified method to select item as largest with auto-validation
  void selectLargestItem(String size) {
    if (isAnswerValidated.value) return;

    // Clear previous largest selection
    if (circledItem.value != null) {
      resetLargestSelection();
    }

    // Set new selection
    circledItem.value = size;

    // Update UI state
    _updateSelectionState();

    showFeedback("Bravo!", "Tu as sélectionné l'image!");

    // Automatically validate after a short delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  // Helper to reset largest selection
  void resetLargestSelection() {
    circledItem.value = null;
    _updateSelectionState();
  }

  // Update UI selection state based on current selection (largest only)
  void _updateSelectionState() {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;

      // Reset all selection states first
      for (var option in exercise.itemGroup.sizeOptions) {
        option.resetSelection();
      }

      // Update largest selection only
      if (circledItem.value != null) {
        for (var option in exercise.itemGroup.sizeOptions) {
          if (option.size == circledItem.value) {
            option.isLargestSelected = true;
            option.isSelected = true;
          }
        }
      }
    }
  }

  // Simplified method to directly select an item
  void selectItem(String itemId, String size) {
    if (isAnswerValidated.value) return;

    // No dialog needed anymore, just select as largest
    selectLargestItem(size);
  }

  // Helper method to clear drawings for a specific size
  void _clearDrawingsForSize(String size) {
    List<String> keysToRemove = [];

    completedDrawings.forEach((key, value) {
      if (key.endsWith("_$size")) {
        keysToRemove.add(key);
      }
    });

    for (var key in keysToRemove) {
      completedDrawings.remove(key);
    }
  }

  // Helper method to reset all item highlights
  void resetItemHighlights() {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;
      for (var option in exercise.itemGroup.sizeOptions) {
        option.resetSelection();
      }
    }
  }

  // Generate circle points programmatically for visualization
  List<Offset> _generateCirclePoints(
    double centerX,
    double centerY,
    double radius,
  ) {
    List<Offset> points = [];
    for (int i = 0; i < 360; i += 10) {
      double angle = i * pi / 180;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      points.add(Offset(x, y));
    }
    return points;
  }

  // Update item bounds for hit testing
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

  // Modified to validate only the largest selection for Series 2
  void validateAnswer() {
    if (isInSeries2) {
      // Validate Series 2 exercises (size comparison)
      if (circledItem.value == null) {
        showFeedback(
          "Attention",
          "Sélectionne l'image la plus grande avant de vérifier",
        );
        return;
      }

      isAnswerValidated.value = true;

      // Check if the largest selection is correct
      if (circledItem.value == "grand") {
        points.value += 5;
        // Enhanced celebration feedback
        showSuccessAnimation();
        showFeedback("Bravo!", "C'est la bonne réponse!");
      } else {
        // Simplified error feedback
        showFeedback(
          "Essaie encore",
          "Ce n'est pas la plus grande image. Essaie encore!",
        );
      }
    } else {
      // Validate Series 1 exercises (original association)
      if (selectedAnswer.value == null) {
        showFeedback("Attention", "Sélectionne une réponse avant de vérifier");
        return;
      }

      isAnswerValidated.value = true;

      // Check if the answer is correct
      if (selectedAnswer.value == currentExercise.correctAnswer) {
        points.value += 5;
        // Enhanced celebration feedback
        showSuccessAnimation();
        showFeedback("Bravo!", "C'est la bonne réponse!");
      } else {
        showFeedback(
          "Essaie encore",
          "Ce n'est pas la bonne réponse. La réponse correcte était: ${currentExercise.correctAnswer}",
        );
      }
    }
  }

  // Enhanced success animation
  void showSuccessAnimation() {
    // Enhanced snackbar for celebration with more exciting visuals
    Get.snackbar(
      "🎉 Félicitations! 🎉",
      "Tu as gagné 5 points!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3), // Longer duration
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 35,
      ), // Larger icon
    );
  }

  // Simplified reset method (no more crossedItem)
  void resetExercise() {
    // Reset all selection states
    selectedAnswer.value = null;
    circledItem.value = null;
    completedDrawings.clear();
    isAnswerValidated.value = false;
    resetItemHighlights();
  }

  void nextExercise() {
    if (currentExerciseIndex.value < currentExercises.length - 1) {
      currentExerciseIndex.value++;
      resetExercise();
    } else {
      //* Completed all exercises in this set
      isExerciseCompleted.value = true;
      showFeedback("Félicitations!", "Tu as terminé cet exercice!");
    }
  }

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

  //* Show feedback snackbar with enhanced styling
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
      // Adding icon for better visual feedback
      icon: Icon(_getIconForFeedback(title), color: Colors.white),
    );
  }

  // Helper to get appropriate icon for feedback
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

  //* Helper function for getting color for option button
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
}
