import 'package:flutter/material.dart';

class WordChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isInAnswer;
  final VoidCallback onTap;
  
  const WordChip({
    Key? key,
    required this.text,
    required this.isSelected,
    this.isInAnswer = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Don't show the chip if it's selected and not in the answer area
    if (isSelected && !isInAnswer) {
      return const SizedBox.shrink();
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.black : Color(0xFF000000).withOpacity(0.3),
            width: isSelected ? 1.0 : 1.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 12,
            color: isSelected 
                ? Color(0xFF272727) 
                : Color(0xFF272727).withOpacity(0.4),
            letterSpacing: -0.04 * 12,
          ),
        ),
      ),
    );
  }
}