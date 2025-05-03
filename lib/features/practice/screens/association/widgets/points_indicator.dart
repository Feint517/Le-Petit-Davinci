import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class PointsIndicator extends GetView<AssociationController> {
  const PointsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD6F4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          controller.isExerciseCompleted.value
              ? "Félicitations! ${controller.points.value} points gagnés"
              : "Obtenez 5 points",
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFF725E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}