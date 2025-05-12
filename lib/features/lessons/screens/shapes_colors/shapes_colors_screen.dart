import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/lessons/controllers/shapes_colors_controller.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/widgets/shapes_colors_card.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/widgets/shapes_colors_header.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/widgets/points_badge.dart';
import 'package:kids_learning_app/features/lessons/screens/shapes_colors/widgets/question_progress.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class ShapesColorsScreen extends GetView<ShapesColorsController> {
  const ShapesColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(ShapesColorsController());

    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FC),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > 600 ? 24.0 : 16.0,
                vertical: isSmallScreen ? 12.0 : 16.0,
              ),
              child: Column(
                children: [
                  // Header with back button and title
                  ShapesColorsHeader(onBackPressed: () => Get.back()),
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
                                  Row(
                                    children: [
                                      // Hint button
                                      InkWell(
                                        onTap: () => controller.toggleHint(),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.lightbulb_outline,
                                            color: AppColors.orange,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      PointsBadge(
                                        points: controller.currentQuestion.points,
                                      ),
                                    ],
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
                              Row(
                                children: [
                                  // Hint button
                                  InkWell(
                                    onTap: () => controller.toggleHint(),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.lightbulb_outline,
                                        color: AppColors.orange,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  PointsBadge(
                                    points: controller.currentQuestion.points,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  Gap(isSmallScreen ? 12 : 16),

                  // Question card (most of the screen space)
                  Expanded(
                    child: Obx(
                      () => ShapesColorsCard(
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

            // Floating mascot
            Obx(() {
              final mascotController = Get.find<MascotController>();
              return MascotHelper.buildFloatingMascot(
                context: context,
                initialState: mascotController.currentState.value,
                mascotType: mascotController.currentMascot.value,
                alignment: Alignment.bottomRight,
                size: 70,
                onTap: () {
                  // Show welcome tip on first tap
                  MascotHelper.showMascotDialog(
                    title: "Bienvenue !",
                    message: "Je suis là pour t'aider à apprendre les formes et les couleurs ! Clique sur l'ampoule si tu as besoin d'un indice.",
                    state: MascotState.happy,
                    buttonText: "On commence !",
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}