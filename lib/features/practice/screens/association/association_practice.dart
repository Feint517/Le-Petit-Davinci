import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/question_progress.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/exercise_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/exercise_dropdown.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/navigation_footer.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/points_indicator.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class AssociationActivitiesScreen extends StatelessWidget {
  const AssociationActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssociationController());

    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width > 600 ? 24.0 : 12.0,
            vertical: isSmallScreen ? 8.0 : 12.0,
          ),
          child: Column(
            children: [
              const CommonHeader(pageTitle: "Exercices d'Association"),
              Gap(isSmallScreen ? 10 : 14),

              isNarrowScreen ? NarrowSelectionRow() : WideSelectionRow(),
              Gap(isSmallScreen ? 8 : 12),

              Expanded(child: const ExerciseContent()),
              Gap(isSmallScreen ? 8 : 12),

              const NavigationFooter(),

              //* ==================

              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: AppSizes.md,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: const [
              //           ExerciseDropdown(),

              //           ExerciseContent(),

              //           //ControlButtons(),

              //           PointsIndicator(),

              //           DescriptionWidget(),

              //           NavigationFooter(),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const PointsIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class NarrowSelectionRow extends StatelessWidget {
  const NarrowSelectionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExerciseDropdown(),
        const Gap(8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetX<AssociationController>(
              builder:
                  (controller) => QuestionProgress(
                    currentQuestion: controller.currentExerciseIndex.value + 1,
                    totalQuestions: controller.currentExercises.length,
                  ),
            ),
            const PointsIndicator(),
          ],
        ),
      ],
    );
  }
}

class WideSelectionRow extends StatelessWidget {
  const WideSelectionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 3, child: ExerciseDropdown()),
        const Gap(10),

        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetX<AssociationController>(
                builder:
                    (controller) => QuestionProgress(
                      currentQuestion:
                          controller.currentExerciseIndex.value + 1,
                      totalQuestions: controller.currentExercises.length,
                    ),
              ),
              const PointsIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
