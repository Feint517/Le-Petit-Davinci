import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/data.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/features/practice/models/color_combination_item.dart';
import 'package:kids_learning_app/features/practice/models/color_identification_item.dart';

import 'package:kids_learning_app/features/practice/models/size_comparison_item.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/mascot_feedback_dialog.dart';

import 'package:kids_learning_app/utils/constants/colors.dart';

class AssociationController extends GetxController {
  var selectedExercise = "Serie 1 - la bonne couleur".obs;
  var currentExerciseIndex = 0.obs;
  var selectedAnswer = Rxn<String>();
  var isAnswerValidated = false.obs;
  var points = 0.obs;
  var isExerciseCompleted = false.obs;

  var selectedLargest = Rxn<String>();

  var circledItem = Rxn<String>();
  var completedDrawings = <String, List<Offset>>{}.obs;

  var selectedColorAnswer = Rxn<String>();
  var colorPaletteVisible = false.obs;

  bool get isInSeries2 => selectedExercise.value.contains("Serie 2");

  bool get isLastExerciseInSeries {
    final currentIndex = exercisesList.indexOf(selectedExercise.value);
    if (currentIndex < 0 || currentIndex >= exercisesList.length - 1) {
      return true;
    }

    final currentSeries = selectedExercise.value.split(" - ")[0];
    final nextSeries = exercisesList[currentIndex + 1].split(" - ")[0];

    return currentSeries != nextSeries;
  }

  dynamic get currentExercises {
    return allExercises[selectedExercise.value] ?? [];
  }

  dynamic get currentExercise {
    if (currentExercises.isEmpty) {
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

    if (currentExerciseIndex.value >= currentExercises.length) {
      currentExerciseIndex.value = currentExercises.length - 1;
    }

    return currentExercises[currentExerciseIndex.value];
  }

  void selectColorImage(int index) {
    selectedColorImageIndex.value = index;

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  void changeExercise(String? newValue) {
    if (newValue != null) {
      selectedExercise.value = newValue;
      currentExerciseIndex.value = 0;
      resetExercise();
    }
  }

  void selectLargestItem(String size) {
    if (isAnswerValidated.value) return;

    if (circledItem.value != null) {
      resetLargestSelection();
    }

    circledItem.value = size;

    _updateSelectionState();

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }

  void showSuccessAnimation() {
    Get.closeAllSnackbars();

    Get.snackbar(
      "🎉 Félicitations! 🎉",
      "Tu as gagné 5 points!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.star, color: Colors.yellow, size: 35),
    );
  }

  void resetLargestSelection() {
    circledItem.value = null;
    _updateSelectionState();
  }

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

  void selectItem(String itemId, String size) {
    if (isAnswerValidated.value) return;

    selectLargestItem(size);
  }

  void resetItemHighlights() {
    if (isInSeries2) {
      final exercise = currentExercise as SizeComparisonItem;
      for (var option in exercise.itemGroup.sizeOptions) {
        option.resetSelection();
      }
    }
  }

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

  var selectedColorImageIndex = Rxn<int>();

  bool get isInSeries4 => selectedExercise.value.contains("Serie 4");

  void validateAnswer() {
    if (isInSeries4) {
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
    } else if (isInSeries3) {
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
    } else if (isInSeries2) {
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
    } else {
      if (selectedAnswer.value == null) {
        showFeedback("Attention", "Sélectionne une réponse avant de vérifier");
        return;
      }

      isAnswerValidated.value = true;

      if (selectedAnswer.value == currentExercise.correctAnswer) {
        points.value += 5;

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

  void resetExercise() {
    // Reset all selection states
    selectedAnswer.value = null;
    circledItem.value = null;
    selectedColorAnswer.value = null;
    selectedColorImageIndex.value = null;
    colorPaletteVisible.value = false;
    completedDrawings.clear();
    isAnswerValidated.value = false;
    resetItemHighlights();
  }

  void nextExercise() {
    if (currentExerciseIndex.value < currentExercises.length - 1) {
      currentExerciseIndex.value++;
      resetExercise();
    } else {
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

  bool get isInSeries3 => selectedExercise.value.contains("Serie 3");

  void toggleColorPalette() {
    colorPaletteVisible.value = !colorPaletteVisible.value;
  }

  void selectColorAnswer(String color) {
    selectedColorAnswer.value = color;
    colorPaletteVisible.value = false;

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!isAnswerValidated.value) {
        validateAnswer();
      }
    });
  }
}
