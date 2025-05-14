import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/lessons/models/math_operation_question.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class OperationCard extends StatelessWidget {
  final MathOperationQuestion question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;
  final bool isAnswerChecked;
  final bool isCorrectAnswer;

  const OperationCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    this.isAnswerChecked = false,
    this.isCorrectAnswer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question text
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      fontFamily: 'BricolageGrotesque',
                    ),
                  ),
                  const Gap(AppSizes.md),

                  // Operation visualization
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              question.operationType == OperationType.addition
                                  ? AppColors.orange.withValues(alpha: 0.3)
                                  : Colors.red.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Calculate available width to determine if we need to adjust sizing
                          final availableWidth = constraints.maxWidth;
                          final isNarrowScreen = availableWidth < 320;
                          
                          // Adjust sizes for narrow screens
                          final spacing = isNarrowScreen ? 10.0 : 20.0;
                          
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildNumberBlock(
                                  question.firstNumber,
                                  size: isNarrowScreen ? 40.0 : 50.0,
                                ),
                                SizedBox(width: spacing),
                                _buildOperationSymbol(
                                  question.operationType,
                                  size: isNarrowScreen ? 30.0 : 40.0,
                                ),
                                SizedBox(width: spacing),
                                _buildNumberBlock(
                                  question.secondNumber,
                                  size: isNarrowScreen ? 40.0 : 50.0,
                                ),
                                SizedBox(width: spacing),
                                _buildEqualSign(
                                  size: isNarrowScreen ? 30.0 : 40.0,
                                ),
                                SizedBox(width: spacing),
                                _buildQuestionMark(
                                  size: isNarrowScreen ? 40.0 : 50.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const Gap(AppSizes.md),

                  // Answer options grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      final isSelected = selectedAnswer == option;
                      final isCorrect = option == question.correctAnswer;

                      // Determine colors based on selection state
                      Color backgroundColor;
                      Color borderColor;
                      Color textColor;

                      if (isAnswerChecked) {
                        if (isCorrect) {
                          backgroundColor = Colors.green.withValues(
                            alpha: 0.15,
                          );
                          borderColor = Colors.green;
                          textColor = Colors.green.shade800;
                        } else if (isSelected && !isCorrect) {
                          backgroundColor = Colors.red.withValues(alpha: 0.15);
                          borderColor = Colors.red;
                          textColor = Colors.red.shade800;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withValues(alpha: 0.3);
                          textColor = Colors.grey.shade700;
                        }
                      } else {
                        if (isSelected) {
                          backgroundColor = AppColors.orange.withValues(
                            alpha: 0.15,
                          );
                          borderColor = AppColors.orange;
                          textColor = AppColors.orange;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withValues(alpha: 0.3);
                          textColor = Colors.grey.shade700;
                        }
                      }

                      return GestureDetector(
                        onTap:
                            isAnswerChecked
                                ? null
                                : () => onAnswerSelected(option),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 2),
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: borderColor.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                    : null,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isAnswerChecked && isCorrect)
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 20,
                                  )
                                else if (isAnswerChecked &&
                                    isSelected &&
                                    !isCorrect)
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20,
                                  )
                                else if (isSelected)
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.orange,
                                    size: 20,
                                  ),
                                if (isSelected ||
                                    (isAnswerChecked && isCorrect))
                                  const SizedBox(width: 8),
                                Text(
                                  option.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        isSelected ||
                                                (isAnswerChecked && isCorrect)
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBlock(int number, {double size = 50.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size * 0.24), // Scale with size
        border: Border.all(
          color: AppColors.orange.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: size * 0.48, // Scale font size with container size
            fontWeight: FontWeight.bold,
            fontFamily: 'BricolageGrotesque',
            color: AppColors.orange,
          ),
        ),
      ),
    );
  }

  Widget _buildOperationSymbol(OperationType type, {double size = 40.0}) {
    final String symbol = type == OperationType.addition ? '+' : '-';
    final Color color =
        type == OperationType.addition ? AppColors.orange : Colors.red;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      ),
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: size * 0.6, // Scale font size with container size
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildEqualSign({double size = 40.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '=',
          style: TextStyle(
            fontSize: size * 0.6, // Scale font size with container size
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionMark({double size = 50.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(size * 0.24), // Scale with size
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '?',
          style: TextStyle(
            fontSize: size * 0.48, // Scale font size with container size
            fontWeight: FontWeight.bold,
            fontFamily: 'BricolageGrotesque',
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
