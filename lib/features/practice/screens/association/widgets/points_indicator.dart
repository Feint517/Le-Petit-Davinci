import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';

class PointsIndicator extends GetView<AssociationController> {
  const PointsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrowScreen = MediaQuery.of(context).size.width < 360;

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(
          horizontal: isNarrowScreen ? 10 : 14,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFDCFFE),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          isNarrowScreen
              ? "${controller.points.value} pts"
              : "Obtenez ${controller.isExerciseCompleted.value ? controller.points.value : 5} points",
          style: const TextStyle(
            fontFamily: 'Archivo',
            fontSize: 10,
            color: Color(0xFF6A3EA1),
          ),
        ),
      ),
    );
  }
}
