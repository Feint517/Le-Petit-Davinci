import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/lessons/models/counting_question.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class CountingCard extends StatelessWidget {
  final CountingQuestion question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;
  final bool isAnswerChecked;
  final bool isCorrectAnswer;

  const CountingCard({
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
            color: Colors.black.withOpacity(0.08),
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
                  
                  // Image area
                  Center(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          question.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const Gap(AppSizes.md),
                  
                  // Answer options grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          backgroundColor = Colors.green.withOpacity(0.15);
                          borderColor = Colors.green;
                          textColor = Colors.green.shade800;
                        } else if (isSelected && !isCorrect) {
                          backgroundColor = Colors.red.withOpacity(0.15);
                          borderColor = Colors.red;
                          textColor = Colors.red.shade800;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withOpacity(0.3);
                          textColor = Colors.grey.shade700;
                        }
                      } else {
                        if (isSelected) {
                          backgroundColor = AppColors.primaryDeep.withOpacity(0.15);
                          borderColor = AppColors.primaryDeep;
                          textColor = AppColors.primaryDeep;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withOpacity(0.3);
                          textColor = Colors.grey.shade700;
                        }
                      }
                      
                      return GestureDetector(
                        onTap: isAnswerChecked ? null : () => onAnswerSelected(option),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: borderColor,
                              width: 2,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: borderColor.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ] : null,
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
                                else if (isAnswerChecked && isSelected && !isCorrect)
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20,
                                  )
                                else if (isSelected)
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: AppColors.primaryDeep,
                                    size: 20,
                                  ),
                                if (isSelected || (isAnswerChecked && isCorrect))
                                  const SizedBox(width: 8),
                                Text(
                                  option.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: isSelected || (isAnswerChecked && isCorrect)
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
}