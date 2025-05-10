import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/models/counting_exercise_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SeriesEightContent extends GetView<AssociationController> {
  const SeriesEightContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we need to adjust layout for small screens
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    final CountingExerciseItem exercise = controller.currentExercise;

    return Column(
      children: [
        // Header with instruction title
        SizedBox(
          height: isSmallScreen ? 110 : 130,
          child: Stack(
            children: [
              // Title in center
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.numbers_rounded,
                        color: AppColors.primaryDeep,
                        size: 28,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Compter les ${exercise.objectName}",
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

              // Category label at the top
              Positioned(
                top: 10,
                right: 10,
                child: Material(
                  color: Colors.transparent,
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
                    child: Row(
                      children: const [
                        Icon(Icons.school, color: Colors.purple, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Mathématiques",
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Flexible layout for image and options areas
        Expanded(
          child: Column(
            children: [
              // Instruction Area
              Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5CBFF), width: 2),
                ),
                child: Text(
                  exercise.instruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple,
                  ),
                ),
              ),

              // Image Area - takes more space
              Expanded(
                flex: 6,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE5CBFF),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    // Show visual representation of the answer if validated and correct
                    if (controller.isAnswerValidated.value &&
                        controller.countingSelectedValue.value ==
                            exercise.correctCount &&
                        controller.showVisualCount.value) {
                      return _buildScatteredImagesLayout(exercise);
                    } else {
                      // Just show the main image
                      return Image.asset(
                        exercise.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Image non disponible",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
                ),
              ),

              // Options Area - styled like the word bank
              Expanded(
                flex: 4,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title for the options
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 6,
                          bottom: 4,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.touch_app,
                              color: Color(0xFFFF9E80),
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Choisis la bonne réponse",
                              style: TextStyle(
                                fontFamily: 'Bricolage Grotesque',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6A3EA1),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Options container with answer choices
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                exercise.options.map((option) {
                                  final isSelected =
                                      controller.countingSelectedValue.value ==
                                      option.number;
                                  final isCorrect =
                                      controller.isAnswerValidated.value &&
                                      option.number == exercise.correctCount;
                                  final isIncorrect =
                                      controller.isAnswerValidated.value &&
                                      isSelected &&
                                      option.number != exercise.correctCount;

                                  return _buildNumberOption(
                                    option,
                                    isSelected,
                                    isCorrect,
                                    isIncorrect,
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build a layout with the main image and scattered smaller images
  Widget _buildScatteredImagesLayout(CountingExerciseItem exercise) {
    // Generate random positions for the images
    final random = Random();
    final List<Offset> positions = [];

    // Create a list of positions for the smaller images
    // The number of images will be the correct count
    for (int i = 0; i < exercise.correctCount; i++) {
      // Use random positions but ensure they don't overlap too much
      double x, y;
      bool tooClose;

      // Try to find a position that's not too close to existing positions
      do {
        tooClose = false;
        // Keep the images within 80% of the container to avoid edge clipping
        x = 0.1 + random.nextDouble() * 0.8;
        y = 0.1 + random.nextDouble() * 0.8;

        // Check distance from existing positions
        for (var pos in positions) {
          double distance = sqrt(pow(x - pos.dx, 2) + pow(y - pos.dy, 2));
          // If too close, try again (minimum distance relative to container)
          if (distance < 0.15) {
            tooClose = true;
            break;
          }
        }
      } while (tooClose);

      positions.add(Offset(x, y));
    }

    print(
      "Building scattered layout with ${exercise.correctCount} images",
    ); // Debug print

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            // Main image semi-transparent in the background
            Opacity(
              opacity: 0.3,
              child: Center(
                child: Image.asset(exercise.imagePath, fit: BoxFit.contain),
              ),
            ),

            // Scattered smaller images
            ...List.generate(exercise.correctCount, (index) {
              // Calculate pixel positions based on relative positions
              final pixelX = positions[index].dx * constraints.maxWidth;
              final pixelY = positions[index].dy * constraints.maxHeight;

              // Size for the small images (proportional to container)
              final imageSize =
                  min(constraints.maxWidth, constraints.maxHeight) *
                  0.25; // 25% of the smallest dimension

              return Positioned(
                left: pixelX - (imageSize / 2),
                top: pixelY - (imageSize / 2),
                width: imageSize,
                height: imageSize,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(
                    milliseconds: 500 + (index * 100),
                  ), // Staggered animation
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Image.asset(exercise.imagePath, fit: BoxFit.contain),
                ),
              );
            }),

            // Count text - overlay showing total count
            Positioned(
              bottom: 10,
              right: 10,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "${exercise.correctCount} ${exercise.objectName}",
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumberOption(
    CountingOption option,
    bool isSelected,
    bool isCorrect,
    bool isIncorrect,
  ) {
    // Get pastel color for background
    Color baseColor;
    switch (option.number % 5) {
      case 0:
        baseColor = const Color(0xFFFFD6E0); // Light Pink
        break;
      case 1:
        baseColor = const Color(0xFFFFEFB5); // Light Yellow
        break;
      case 2:
        baseColor = const Color(0xFFB5EAFF); // Light Blue
        break;
      case 3:
        baseColor = const Color(0xFFD1FFBD); // Light Green
        break;
      case 4:
        baseColor = const Color(0xFFE5CBFF); // Light Purple
        break;
      default:
        baseColor = const Color(0xFFFFD6C9); // Light Orange
    }

    // Create a much more prominent selection state
    final backgroundColor = isSelected ? baseColor : baseColor.withOpacity(0.5);

    // Border color based on validation state - more prominent when selected
    Color borderColor = Colors.transparent;
    if (isCorrect) {
      borderColor = Colors.green;
    } else if (isIncorrect) {
      borderColor = Colors.red;
    } else if (isSelected) {
      borderColor = Colors.purple;
    }

    return Material(
      color: Colors.transparent,
      child: Obx(() {
        // Using a stateful approach with InkWell for better touch feedback
        return InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: baseColor,
          highlightColor: baseColor,
          onTap: () {
            if (!controller.isAnswerValidated.value) {
              // Provide haptic feedback
              HapticFeedback.mediumImpact();

              // Select this answer
              controller.selectCountingAnswer(option.number);

              // Play bounce animation by setting and clearing a flag for visual feedback
              controller.setAnimatingOption(option.number);
              Future.delayed(const Duration(milliseconds: 300), () {
                controller.clearAnimatingOption();
              });
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3.0),
              boxShadow: [
                BoxShadow(
                  color:
                      isSelected
                          ? AppColors.primary.withOpacity(0.4)
                          : Colors.black.withOpacity(0.1),
                  offset: isSelected ? const Offset(0, 4) : const Offset(0, 2),
                  blurRadius: isSelected ? 10 : 3,
                  spreadRadius: isSelected ? 2 : 0,
                ),
              ],
            ),
            transform:
                controller.isAnimatingOption(option.number)
                    ? (Matrix4.identity()..scale(1.15))
                    : (isSelected
                        ? (Matrix4.identity()..scale(1.1))
                        : Matrix4.identity()),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background highlight for selected state
                if (isSelected)
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7],
                      ),
                    ),
                  ),

                // Number text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      option.text,
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: isSelected ? 16 : 14,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w600,
                        color:
                            isSelected
                                ? Colors.black
                                : Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "(${option.number})",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: isSelected ? 14 : 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color:
                            isSelected
                                ? Colors.black.withOpacity(0.8)
                                : Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                // Selection indicator (checkmark outline)
                if (isSelected && !isCorrect && !isIncorrect)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),

                // Validation icon (correct/incorrect)
                if (isCorrect)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else if (isIncorrect)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
