import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SubjectCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool isHovering = false.obs;

  //* Animation related variables
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  //* Constructor that accepts parameters
  final String title;
  final String total;
  final String imagePath;
  final double progress;
  final VoidCallback onTap;

  SubjectCardController({
    required this.title,
    required this.total,
    required this.imagePath,
    required this.progress,
    required this.onTap,
  });

  @override
  void onInit() {
    super.onInit();
    //* Initialize animation controller
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    //* Initialize scale animation
    scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    //* Dispose animation controller when controller is closed
    animationController.dispose();
    super.onClose();
  }

  //* Method to handle mouse enter event
  void onMouseEnter() {
    isHovering.value = true;
    animationController.forward();
  }

  //* Method to handle mouse exit event
  void onMouseExit() {
    isHovering.value = false;
    animationController.reverse();
  }

  //* Calculate progress percentage
  int get progressPercent => (progress * 100).toInt();

  //* Get gradient colors based on progress
  List<Color> getGradientColors() {
    if (progress > 0.7) {
      return [
        AppColors.primaryDeep.withValues(alpha: 0.8),
        AppColors.primaryDeep.withValues(alpha: 0.6),
      ];
    } else if (progress > 0.4) {
      return [
        AppColors.secondary.withValues(alpha: 0.8),
        AppColors.secondary.withValues(alpha: 0.6),
      ];
    } else {
      return [
        AppColors.accent.withValues(alpha: 0.8),
        AppColors.accent.withValues(alpha: 0.6),
      ];
    }
  }

  BoxShadow get currentBoxShadow => BoxShadow(
    color:
        isHovering.value
            ? AppColors.primaryDeep.withValues(alpha: 0.3)
            : AppColors.black.withValues(alpha: 0.2),
    blurRadius: isHovering.value ? 15 : 10,
    offset: isHovering.value ? const Offset(0, 5) : const Offset(0, 1),
    spreadRadius: isHovering.value ? 1 : 0,
  );
}
