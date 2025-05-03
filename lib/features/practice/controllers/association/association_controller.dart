// Controller for handling logic
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AssociationController extends GetxController {
  //* State variables as observables
  var selectedExercise = "Exercice 1 - la bonne couleur".obs;
  var currentExerciseIndex = 0.obs;
  var selectedAnswer = Rxn<String>();
  var isAnswerValidated = false.obs;
  var points = 0.obs;
  var isExerciseCompleted = false.obs;

  //* Exercises list for dropdown
  final List<String> exercisesList = [
    "Exercice 1 - la bonne couleur",
    "Exercice 2 - les animaux",
    "Exercice 3 - les fruits",
  ];

  //* Association exercise data
  final Map<String, List<AssociationItem>> allExercises = {
    "Exercice 1 - la bonne couleur": [
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
    "Exercice 2 - les animaux": [
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
    "Exercice 3 - les fruits": [
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
  };

  //* Getter for current exercises list
  List<AssociationItem> get currentExercises {
    return allExercises[selectedExercise.value] ?? [];
  }

  //* Getter for current exercise item
  AssociationItem get currentExercise {
    if (currentExercises.isEmpty) {
      return AssociationItem(
        instruction: "",
        imagePath: "",
        options: [],
        correctAnswer: "",
      );
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

  void validateAnswer() {
    if (selectedAnswer.value == null) {
      showFeedback("Attention", "Sélectionne une réponse avant de vérifier");
      return;
    }

    isAnswerValidated.value = true;

    //* Check if the answer is correct
    if (selectedAnswer.value == currentExercise.correctAnswer) {
      points.value += 5;
      showFeedback("Bravo!", "C'est la bonne réponse!");
    } else {
      showFeedback(
        "Essaie encore",
        "Ce n'est pas la bonne réponse. Essaie encore!",
      );
    }
  }

  void resetExercise() {
    selectedAnswer.value = null;
    isAnswerValidated.value = false;
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

  //* Show feedback snackbar
  void showFeedback(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.primaryDeep,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
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