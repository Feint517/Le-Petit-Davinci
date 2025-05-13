import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double height;
  final String? label;
  final bool showPercentage;
  final int totalSteps;
  final int currentStep;

  const AnimatedProgressBar({
    Key? key,
    required this.progress,
    this.backgroundColor = const Color(0xFFEBE4F2),
    this.progressColor = const Color(0xFF9C27B0),
    this.height = 12.0,
    this.label,
    this.showPercentage = false,
    this.totalSteps = 0,
    this.currentStep = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label et pourcentage
        if (label != null || showPercentage)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6A3EA1),
                    ),
                  )
                else
                  const SizedBox.shrink(),

                if (showPercentage)
                  Text(
                    "${(progress * 100).round()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          progress > 0.7
                              ? Colors.green
                              : (progress > 0.3
                                  ? Colors.amber
                                  : Colors.redAccent),
                    ),
                  )
                else if (totalSteps > 0)
                  Text(
                    "$currentStep/$totalSteps",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6A3EA1),
                    ),
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),

        // Barre de progression
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            children: [
              // Barre de progression principale
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(height / 2),
                    boxShadow: [
                      BoxShadow(
                        color: progressColor.withValues(alpha: 0.3),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
