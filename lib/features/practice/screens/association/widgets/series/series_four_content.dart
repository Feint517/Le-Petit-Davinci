import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SeriesFourContent extends GetView<AssociationController> {
  const SeriesFourContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Column(
      children: [
        SizedBox(
          height: isSmallScreen ? 90 : 110,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.color_lens,
                        color: _getColorFromName(
                          controller.currentExercise.targetColor,
                        ),
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.currentExercise.targetColor,
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDeep,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E5FF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "Identification des Couleurs",
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: isSmallScreen ? 1 : 2,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE5CBFF),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.currentExercise.instruction,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: isSmallScreen ? 11 : 12,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFD6C9),
                      width: 2,
                    ),
                  ),
                  child: _buildImageGrid(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(
            controller.currentExercise.images.length,
            (index) => _buildImageItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    final image = controller.currentExercise.images[index];
    final isSelected = controller.selectedColorImageIndex.value == index;
    final isCorrect = index == controller.currentExercise.correctIndex;
    final isWrong =
        controller.isAnswerValidated.value && isSelected && !isCorrect;

    return GestureDetector(
      onTap: () {
        if (!controller.isAnswerValidated.value) {
          controller.selectColorImage(index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isSelected
                      ? isWrong
                          ? Colors.red.withOpacity(0.5)
                          : controller.isAnswerValidated.value && isCorrect
                          ? Colors.green.withOpacity(0.5)
                          : AppColors.primary.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.1),
              blurRadius: isSelected ? 10 : 3,
              spreadRadius: isSelected ? 2 : 0,
              offset: isSelected ? const Offset(0, 0) : const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color:
                isSelected
                    ? isWrong
                        ? Colors.red
                        : controller.isAnswerValidated.value && isCorrect
                        ? Colors.green
                        : AppColors.primary
                    : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[100],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Image non disponible",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              if (controller.isAnswerValidated.value &&
                  (isSelected || isCorrect))
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),

              if (controller.selectedColorImageIndex.value != null &&
                  !isSelected &&
                  !controller.isAnswerValidated.value)
                Container(color: Colors.white.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "rouge":
        return Colors.red;
      case "bleu":
        return Colors.blue;
      case "jaune":
        return Colors.yellow;
      case "vert":
        return Colors.green;
      case "rose":
        return const Color(0xFFFF69B4);
      case "violet":
        return Colors.purple;
      case "orange":
        return Colors.orange;
      case "gris":
        return Colors.grey;
      case "marron":
        return Colors.brown;
      case "noir":
        return Colors.black;
      case "blanc":
        return Colors.white;
      default:
        return Colors.black;
    }
  }
}
