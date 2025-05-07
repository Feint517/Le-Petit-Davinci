import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/evaluations/dictee/screens/widgets/question_progress.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/control_button.dart';
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
      backgroundColor: const Color(0xFFFDF2FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width > 600 ? 24.0 : 12.0,
            vertical: isSmallScreen ? 8.0 : 12.0,
          ),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: isSmallScreen ? 10 : 14),

              isNarrowScreen
                  ? _buildNarrowSelectionRow(context)
                  : _buildWideSelectionRow(context),
              SizedBox(height: isSmallScreen ? 8 : 12),

              Expanded(child: const ExerciseContent()),
              SizedBox(height: isSmallScreen ? 8 : 12),

              const ControlButtons(),
              SizedBox(height: isSmallScreen ? 8 : 12),

              const NavigationFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF6C6C6C),
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Retour",
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontSize: 12,
                          color: Color(0xFF6C6C6C),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  "Exercices d'Association",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 20,
                    letterSpacing: -0.06 * 20,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),

          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              'assets/images/illustrations/avatar.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowSelectionRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ExerciseDropdown(),
        const SizedBox(height: 8),

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

  // For the wide layout in _buildWideSelectionRow method:
  Widget _buildWideSelectionRow(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 3, child: ExerciseDropdown()),
        const SizedBox(width: 10),

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
