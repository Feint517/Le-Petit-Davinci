import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:kids_learning_app/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CustomPrimaryHeaderContainer extends StatelessWidget {
  const CustomPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CustomCircularContainer(
                backgroundColor: AppColors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CustomCircularContainer(
                backgroundColor: AppColors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
