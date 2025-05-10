import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class OptionsGrid extends GetView<AssociationController> {
  const OptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Check for small screen to adjust spacing
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the options bank
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              top: isSmallScreen ? 4 : 6,
              bottom: isSmallScreen ? 2 : 4,
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Color(0xFFFF9E80), size: 14),
                SizedBox(width: 4),
                Text(
                  "Options",
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

          // Options container with a different approach to building the children
          Expanded(
            child: Obx(() {
              // Get the current state once
              final currentOptions = controller.currentExercise.options;
              final selectedAnswer = controller.selectedAnswer.value;
              final isValidated = controller.isAnswerValidated.value;
              final correctAnswer = controller.currentExercise.correctAnswer;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF7F7FF),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                    child: Center(
                      child: Wrap(
                        spacing: isSmallScreen ? 6 : 8,
                        runSpacing: isSmallScreen ? 6 : 8,
                        alignment: WrapAlignment.center,
                        children: [
                          // Explicitly build each option widget
                          for (final option in currentOptions)
                            _buildOptionChip(
                              option,
                              selectedAnswer == option,
                              isValidated && option == correctAnswer,
                              isValidated &&
                                  selectedAnswer == option &&
                                  option != correctAnswer,
                              isSmallScreen,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Your existing _buildOptionChip method
  Widget _buildOptionChip(
    String text,
    bool isSelected,
    bool isCorrect,
    bool isIncorrect,
    bool isSmallScreen,
  ) {
    // Get color for the chip
    final Color backgroundColor = _getChipColor(text, isSelected);

    // Add visual feedback
    Color borderColor =
        isSelected ? Colors.black : Colors.black.withValues(alpha: 0.2);

    if (isCorrect) {
      borderColor = Colors.green;
    } else if (isIncorrect) {
      borderColor = Colors.red;
    }

    return Transform.scale(
      scale: isSmallScreen ? 0.95 : 1.0,
      child: GestureDetector(
        onTap: () {
          if (!controller.isAnswerValidated.value) {
            controller.selectedAnswer.value = text;
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 6, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor,
              width: isSelected || isCorrect || isIncorrect ? 2.0 : 1.0,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ]
                    : null,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: isSelected ? 1.0 : 0.7),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }

  // Color selection method
  Color _getChipColor(String text, bool isSelected) {
    final List<Color> colors = [
      const Color(0xFFFFD6E0), // Light Pink
      const Color(0xFFFFEFB5), // Light Yellow
      const Color(0xFFB5EAFF), // Light Blue
      const Color(0xFFD1FFBD), // Light Green
      const Color(0xFFE5CBFF), // Light Purple
      const Color(0xFFFFD6C9), // Light Orange
    ];

    final int seed = text.isNotEmpty ? text.codeUnitAt(0) : 0;
    final random = Random(seed);
    final baseColor = colors[random.nextInt(colors.length)];

    return isSelected ? baseColor : baseColor.withValues(alpha: 0.6);
  }
}
