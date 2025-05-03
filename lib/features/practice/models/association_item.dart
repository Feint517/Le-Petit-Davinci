class AssociationItem {
  final String instruction;
  final String imagePath;
  final List<String> options;
  final String correctAnswer;

  AssociationItem({
    required this.instruction,
    required this.imagePath,
    required this.options,
    required this.correctAnswer,
  });
}