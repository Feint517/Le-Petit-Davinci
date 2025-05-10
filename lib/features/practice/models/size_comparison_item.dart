import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
  final String size;
  final String label;
  final double scale;

  // Keep only the reactive properties
  final RxBool isLargestSelected = false.obs;
  final RxBool isSelected = false.obs;

  Rect bounds = Rect.zero;

  SizeOption({required this.size, required this.label, required this.scale});

  void updateBounds(Rect newBounds) {
    bounds = newBounds;
  }

  // Update the reset method to modify the reactive properties
  void resetSelection() {
    isLargestSelected.value = false;
    isSelected.value = false;
  }
}
