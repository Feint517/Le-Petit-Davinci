
class ColorIdentificationItem {
  final String targetColor; // The color name in French (e.g., "Rouge")
  final String instruction; // Full instruction text
  final List<ColorImage> images; // The 4 images to choose from
  final int correctIndex; // Index of the correct image (0-3)

  ColorIdentificationItem({
    required this.targetColor,
    required this.images,
    required this.correctIndex,
    String? instruction,
  }) : instruction = instruction ?? "Entoure l'image qui est $targetColor";

  // Helper to get the correct image
  ColorImage get correctImage => images[correctIndex];
}

class ColorImage {
  final String imagePath; // Path to the image asset
  final String colorName; // The main color of the image in French
  final String objectName; // Name of the object (e.g., "butterfly")

  ColorImage({
    required this.imagePath,
    required this.colorName,
    required this.objectName,
  });
}
