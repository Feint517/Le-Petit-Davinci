import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key, 
    required this.label, 
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : color,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          backgroundColor: isSelected ? color : color.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          side: BorderSide(
            color: color,
            width: 1,
          ),
        ),
      ),
    );
  }
}