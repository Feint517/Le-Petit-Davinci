import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/lessons/controllers/counting_lesson_controller.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/widgets/counting_card.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/widgets/counting_header.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/widgets/points_badge.dart';
import 'package:kids_learning_app/features/lessons/screens/counting/widgets/question_progress.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class CountingLessonScreen extends GetView<CountingLessonController> {
  const CountingLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(CountingLessonController());

    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width > 600 ? 24.0 : 16.0,
            vertical: isSmallScreen ? 12.0 : 16.0,
          ),
          child: Column(
            children: [
              // Header with back button and title
              CountingHeader(onBackPressed: () => Get.back()),
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
                              QuestionProgress(
                                currentQuestion:
                                    controller.currentQuestionIndex.value + 1,
                                totalQuestions: controller.questions.length,
                              ),
                              PointsBadge(
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
                          QuestionProgress(
                            currentQuestion:
                                controller.currentQuestionIndex.value + 1,
                            totalQuestions: controller.questions.length,
                          ),
                          PointsBadge(
                            points: controller.currentQuestion.points,
                          ),
                        ],
                      ),
                    ),
              Gap(isSmallScreen ? 12 : 16),

              // Question card (most of the screen space)
              Expanded(
                child: Obx(
                  () => CountingCard(
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
                () => NavigationButtons(
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