
class CountingExerciseItem {
  final String instruction;
  final String imagePath;
  final int correctCount;
  final List<CountingOption> options;
  final String objectName;

  CountingExerciseItem({
    required this.instruction,
    required this.imagePath,
    required this.correctCount,
    required this.options,
    required this.objectName,
  });
}

class CountingOption {
  final String text; // The French text (e.g., "TROIS")
  final int number; // The numeric value (e.g., 3)

  CountingOption({required this.text, required this.number});
}
