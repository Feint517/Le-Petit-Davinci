import 'package:get/get.dart';

class CountingItem {
  final String instruction;
  final String imagePath;
  final List<CountingCategory> categories;

  CountingItem({
    required this.instruction,
    required this.imagePath,
    required this.categories,
  });
}

class CountingCategory {
  final String name;
  final String iconPath;
  final int correctCount;
  final RxInt userCount = 0.obs; // Reactive user input
  final RxBool isValidated = false.obs;

  CountingCategory({
    required this.name,
    required this.iconPath,
    required this.correctCount,
  });

  // Helper method to reset state
  void reset() {
    userCount.value = 0;
    isValidated.value = false;
  }

  // Check if the answer is correct
  bool isCorrect() {
    return userCount.value == correctCount;
  }
}
