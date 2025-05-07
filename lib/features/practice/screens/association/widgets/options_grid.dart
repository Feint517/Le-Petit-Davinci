import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class OptionsGrid extends GetView<AssociationController> {
  const OptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.height < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF7F7FF),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                  child: Obx(
                    () => Center(
                      child: Wrap(
                        spacing: isSmallScreen ? 6 : 8,
                        runSpacing: isSmallScreen ? 6 : 8,
                        alignment: WrapAlignment.center,
                        children:
                            controller.currentExercise.options.map((option) {
                              final isSelected =
                                  controller.selectedAnswer.value == option;
                              final isCorrect =
                                  controller.isAnswerValidated.value &&
                                  option ==
                                      controller.currentExercise.correctAnswer;
                              final isIncorrect =
                                  controller.isAnswerValidated.value &&
                                  isSelected &&
                                  option !=
                                      controller.currentExercise.correctAnswer;

                              return _buildOptionChip(
                                option,
                                isSelected,
                                isCorrect,
                                isIncorrect,
                                isSmallScreen,
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionChip(
    String text,
    bool isSelected,
    bool isCorrect,
    bool isIncorrect,
    bool isSmallScreen,
  ) {
    final Color backgroundColor = _getChipColor(text, isSelected);

    Color borderColor =
        isSelected ? Colors.black : Colors.black.withOpacity(0.2);

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
                        color: Colors.black.withOpacity(0.1),
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
              color: Colors.black.withOpacity(isSelected ? 1.0 : 0.7),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }

  Color _getChipColor(String text, bool isSelected) {
    final List<Color> colors = [
      const Color(0xFFFFD6E0),
      const Color(0xFFFFEFB5),
      const Color(0xFFB5EAFF),
      const Color(0xFFD1FFBD),
      const Color(0xFFE5CBFF),
      const Color(0xFFFFD6C9),
    ];

    final int seed = text.isNotEmpty ? text.codeUnitAt(0) : 0;
    final random = Random(seed);
    final baseColor = colors[random.nextInt(colors.length)];

    return isSelected ? baseColor : baseColor.withOpacity(0.6);
  }
}
