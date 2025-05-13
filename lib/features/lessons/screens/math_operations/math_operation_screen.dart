import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/lessons/controllers/math_operation_controller.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/widgets/operation_card.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/widgets/operation_header.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/widgets/operation_navigation_buttons.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/widgets/operation_points_badge.dart';
import 'package:kids_learning_app/features/lessons/screens/math_operations/widgets/operation_progress.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class MathOperationScreen extends GetView<MathOperationController> {
  const MathOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(MathOperationController());

    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width > 600 ? 24.0 : 16.0,
            vertical: isSmallScreen ? 12.0 : 16.0,
          ),
          child: Column(
            children: [
              // Header with back button and title
              OperationHeader(onBackPressed: () => Get.back()),
              Gap(isSmallScreen ? 12 : 16),

              // Combined row for selection and progress/points
              isNarrowScreen
                  // For very narrow screens, stack the elements vertically
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Progress and points in a row
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OperationProgress(
                                currentQuestion:
                                    controller.currentQuestionIndex.value + 1,
                                totalQuestions: controller.questions.length,
                              ),
                              OperationPointsBadge(
                                points: controller.currentQuestion.points,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  // For wider screens, keep the row layout
                  : Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OperationProgress(
                            currentQuestion:
                                controller.currentQuestionIndex.value + 1,
                            totalQuestions: controller.questions.length,
                          ),
                          OperationPointsBadge(
                            points: controller.currentQuestion.points,
                          ),
                        ],
                      ),
                    ),
              Gap(isSmallScreen ? 12 : 16),

              // Question card (most of the screen space)
              Expanded(
                child: Obx(
                  () => OperationCard(
                    question: controller.currentQuestion,
                    selectedAnswer: controller.selectedAnswer.value,
                    onAnswerSelected: controller.selectAnswer,
                    isAnswerChecked: controller.isAnswerChecked.value,
                    isCorrectAnswer: controller.isCorrectAnswer.value,
                  ),
                ),
              ),
              Gap(isSmallScreen ? 12 : 16),

              // Navigation buttons row
              Obx(
                () => OperationNavigationButtons(
                  onPrevious: controller.goToPreviousQuestion,
                  onNext: () => controller.checkAndContinue(context),
                  isFirstQuestion: controller.currentQuestionIndex.value == 0,
                  isLastQuestion: controller.currentQuestionIndex.value ==
                      controller.questions.length - 1,
                ),
              ),
              const Gap(AppSizes.md),
            ],
          ),
        ),
      ),
    );
  }
}