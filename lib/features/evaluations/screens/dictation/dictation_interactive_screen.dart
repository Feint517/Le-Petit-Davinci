import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/evaluations/controllers/dictation/dictation_controller.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/dictee_header.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/points_badge.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_card.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_progress.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/qui_navigation_footer.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/quiz_dropdown.dart';

class DicteeInteractiveScreen extends GetView<DicteeInteractiveController> {
  const DicteeInteractiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DicteeInteractiveController());
    
    // Get screen dimensions for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2FF),
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > 600 ? 24.0 : 12.0,
                vertical: isSmallScreen ? 8.0 : 12.0,
              ),
              child: Column(
                children: [
                  // Header with back button and title
                  DicteeHeader(
                    onBackPressed: () => Get.back(),
                  ),
                  SizedBox(height: isSmallScreen ? 10 : 14),
                  
                  // Combined row for quiz selection and progress/points
                  isNarrowScreen
                  // For very narrow screens, stack the elements vertically
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quiz dropdown selector
                        QuizDropdown(
                          title: 'Dictée interactive',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 8),
                        // Progress and points in a row
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuestionProgress(
                              currentQuestion: controller.currentQuestionIndex.value + 1,
                              totalQuestions: controller.questions.length,
                            ),
                            PointsBadge(
                              points: controller.currentQuestion.points,
                            ),
                          ],
                        )),
                      ],
                    )
                  // For wider screens, keep the row layout
                  : Row(
                      children: [
                        // Quiz dropdown selector
                        Expanded(
                          flex: 2,
                          child: QuizDropdown(
                            title: 'Dictée interactive',
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Question progress and points
                        Expanded(
                          flex: 3,
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QuestionProgress(
                                currentQuestion: controller.currentQuestionIndex.value + 1,
                                totalQuestions: controller.questions.length,
                              ),
                              PointsBadge(
                                points: controller.currentQuestion.points,
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  
                  // Question card (most of the screen space)
                  Expanded(
                    child: GetBuilder<DicteeInteractiveController>(
                      builder: (_) => Obx(() => QuestionCard(
                        question: controller.currentQuestion,
                        selectedWords: controller.selectedWords.toList(),
                        onWordSelected: controller.addWord,
                        onWordRemoved: controller.removeWord,
                        onAudioPlay: controller.playAudio,
                      )),
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  
                  // Navigation buttons row
                  Obx(() => NavigationButtons(
                    onPrevious: controller.goToPreviousQuestion,
                    onNext: () => controller.checkAndContinue(context),
                    isFirstQuestion: controller.currentQuestionIndex.value == 0,
                    isLastQuestion: controller.currentQuestionIndex.value == controller.questions.length - 1,
                  )),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  
                  // Quiz navigation footer
                  QuizNavigationFooter(
                    onPreviousQuiz: () {},
                    onNextQuiz: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}