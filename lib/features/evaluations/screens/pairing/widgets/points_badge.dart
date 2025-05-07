import 'package:flutter/material.dart';

class PointsBadge extends StatelessWidget {
  final int points;

  const PointsBadge({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFDCFFE), // Main Color/Pink
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        "Obtenez $points points",
        style: const TextStyle(
          fontFamily: 'Archivo',
          fontSize: 10,
          color: Color(0xFFFC715A), // Main Color/Orange - Secondary
        ),
      ),
    );
  }
}
