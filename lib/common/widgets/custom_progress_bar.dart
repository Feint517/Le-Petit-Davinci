import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // between 0.0 and 1.0

  const CustomProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // full-rounded
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 12,
        backgroundColor: const Color(0xFFE5DFFF), // soft lavender
        valueColor: AlwaysStoppedAnimation<Color>(
          const Color(0xFF9281FF), // deep purple highlight
        ),
      ),
    );
  }
}
