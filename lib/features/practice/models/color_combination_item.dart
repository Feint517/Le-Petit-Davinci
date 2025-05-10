import 'package:flutter/material.dart';

class ColorCombinationItem {
  final String firstColor;
  final String secondColor;
  final String resultColor;
  final Color firstColorHex;
  final Color secondColorHex;
  final Color resultColorHex;
  final String instruction;

  ColorCombinationItem({
    required this.firstColor,
    required this.secondColor,
    required this.resultColor,
    required this.firstColorHex,
    required this.secondColorHex,
    required this.resultColorHex,
    this.instruction = "Quelle couleur obtient-on en mélangeant ces couleurs?",
  });
}
