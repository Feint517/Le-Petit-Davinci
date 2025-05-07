import 'package:flutter/material.dart';

class AnimatedScoreDisplay extends StatelessWidget {
  final int points;
  final bool showAnimation;

  const AnimatedScoreDisplay({
    Key? key,
    required this.points,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFDCFFE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showAnimation)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1000),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 2 * 3.14159,
                  child: const Icon(Icons.star, color: Colors.amber, size: 16),
                );
              },
            )
          else
            const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),

          Text(
            "$points points",
            style: const TextStyle(
              fontFamily: 'Archivo',
              fontSize: 10,
              color: Color(0xFF6A3EA1),
            ),
          ),
        ],
      ),
    );
  }
}
