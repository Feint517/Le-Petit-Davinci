import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MatchingItem {
  final String instruction;
  final List<MatchPair> pairs;
  final String title;
  final String displayMode; // 'both', 'text-only', or 'image-only'

  MatchingItem({
    required this.instruction,
    required this.pairs,
    required this.title,
    this.displayMode = 'text-only', // Default to showing both text and images
  });
}

class MatchPair {
  final String leftLabel;
  final String rightLabel;
  final String leftImagePath;
  final String rightImagePath;
  final String id;

  // Connection tracking
  final RxBool isConnected = false.obs;
  final RxBool isCorrect = false.obs;
  final RxString connectedToId =
      "".obs; // NEW! Track which ID this pair is connected to

  // Positions for line drawing
  Offset leftPosition = Offset.zero;
  Offset rightPosition = Offset.zero;

  MatchPair({
    required this.leftLabel,
    required this.rightLabel,
    required this.leftImagePath,
    required this.rightImagePath,
    required this.id,
  });

  void reset() {
    isConnected.value = false;
    isCorrect.value = false;
    connectedToId.value = ""; // Reset connection ID
    leftPosition = Offset.zero;
    rightPosition = Offset.zero;
  }
}
