// size_comparison_item.dart
import 'package:flutter/material.dart';

class SizeComparisonItem {
  final String instruction;
  final ItemGroup itemGroup;

  SizeComparisonItem({required this.instruction, required this.itemGroup});
}

class ItemGroup {
  final String groupName;
  final String imagePath;
  final List<SizeOption> sizeOptions;
  final String category;

  ItemGroup({
    required this.groupName,
    required this.imagePath,
    required this.sizeOptions,
    required this.category,
  });
}

class SizeOption {
  final String size; // "grand", "moyen", or "petit"
  final String label; // Display label
  final double scale; // Scale factor for rendering (e.g., 1.0, 0.7, 0.4)

  // Store the rendered position of the item for hit detection
  Rect bounds = Rect.zero;

  // Track selection state
  bool isLargestSelected = false;
  bool isSmallestSelected = false;
  bool isSelected = false;

  SizeOption({required this.size, required this.label, required this.scale});

  // Method to update bounds after rendering
  void updateBounds(Rect newBounds) {
    bounds = newBounds;
  }

  // Reset all selection states
  void resetSelection() {
    isLargestSelected = false;
    isSmallestSelected = false;
    isSelected = false;
  }
}
