import 'package:flutter/material.dart';

class RainbowColorsItem {
  final String instruction;
  final List<RainbowBand> bands;
  final List<String> colorOptions;

  RainbowColorsItem({
    required this.instruction,
    required this.bands,
    required this.colorOptions,
  });
}

class RainbowBand {
  final String name; // Color name (e.g., "Rouge")
  final Color color; // Actual color
  final String text; // Text to display

  RainbowBand({required this.name, required this.color, required this.text});
}
