import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ControlButtons extends GetView<AssociationController> {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color:
                        controller.isAnswerValidated.value
                            ? AppColors.primaryDeep.withValues(alpha: 0.3)
                            : Colors.transparent,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed:
                    controller.isAnswerValidated.value
                        ? controller.resetExercise
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      controller.isAnswerValidated.value
                          ? AppColors.primaryDeep
                          : AppColors.primaryDeep.withValues(alpha: 0.3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 12 : 14,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: isSmallScreen ? 14 : 16,
                    ),
                    Gap(isSmallScreen ? 4 : 8),
                    Text(
                      "Réessayer",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Gap(12),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (!controller.isAnswerValidated.value) {
                    controller.validateAnswer();
                  } else {
                    controller.nextExercise();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 12 : 14,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.isAnswerValidated.value
                          ? "Suivant"
                          : "Vérifier",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: isSmallScreen ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Gap(isSmallScreen ? 4 : 8),
                    Icon(
                      controller.isAnswerValidated.value
                          ? Icons.arrow_forward_rounded
                          : Icons.check_circle,
                      color: Colors.white,
                      size: isSmallScreen ? 14 : 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
