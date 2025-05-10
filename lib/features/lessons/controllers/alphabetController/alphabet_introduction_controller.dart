import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlphabetLessonIntroductionController extends GetxController {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> tabs = ["Étude", "Exercices", "Animation", "Vidéo"];

  final List<String> letters = ["Aa", "Bb", "Cc", "Dd", "Ee", "Ff", "Gg", "Hh"];
  final List<String> lesson = [
    "Contenu 1 - Les Bases de l'Alphabet Français",
    "Contenu 2 - Les Chiffres en Français",
    "Contenu 3 - Les Jours de la Semaine",
  ];
  final List<Color> borderColors = [
    Colors.deepPurpleAccent,
    Colors.deepOrange,
    Colors.teal,
    Colors.amber,
    Colors.amber,
    Colors.teal,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
  ];

  // If you need reactive state variables, you would add them like this:
  // RxInt selectedTabIndex = 0.obs;
  // RxString selectedLetter = ''.obs;

  // You could also add methods to handle state changes
  // void selectLetter(String letter) {
  //   selectedLetter.value = letter;
  //   // Play sound or perform other actions
  // }
}
