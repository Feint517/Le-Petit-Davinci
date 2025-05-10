import 'package:flutter/material.dart';
import 'dart:math' as math;

class WordChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isInAnswer;
  final VoidCallback onTap;
  
  const WordChip({
    super.key,
    required this.text,
    required this.isSelected,
    this.isInAnswer = false,
    required this.onTap,
  });

  // Get a random pastel color for words
  Color _getWordColor() {
    final List<Color> colors = [
      const Color(0xFFFFD6E0),  // Light Pink
      const Color(0xFFFFEFB5),  // Light Yellow
      const Color(0xFFB5EAFF),  // Light Blue
      const Color(0xFFD1FFBD),  // Light Green
      const Color(0xFFE5CBFF),  // Light Purple
      const Color(0xFFFFD6C9),  // Light Orange
    ];
    
    // Use the first character of the text as a seed for consistent colors
    final int seed = text.isNotEmpty ? text.codeUnitAt(0) : 0;
    final random = math.Random(seed);
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Don't show the chip if it's selected and not in the answer area
    if (isSelected && !isInAnswer) {
      return const SizedBox.shrink();
    }
    
    final backgroundColor = isInAnswer ? _getWordColor() : _getWordColor().withValues(alpha: 0.6);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: isSelected ? Matrix4.identity().scaled(1.0) : Matrix4.identity(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 6, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.black.withValues(alpha: 0.2),
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ] : null,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: isSelected ? 1.0 : 0.7),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
    );
  }
}