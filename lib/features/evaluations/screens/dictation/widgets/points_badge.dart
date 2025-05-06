import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class PointsBadge extends StatelessWidget {
  final int points;
  
  const PointsBadge({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if on a narrow screen to adapt text
    final isNarrowScreen = MediaQuery.of(context).size.width < 360;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrowScreen ? 10 : 14, 
        vertical: 4
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDCFFE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        isNarrowScreen ? "$points pts" : "Obtenez $points points",
        style: const TextStyle(
          fontFamily: 'Archivo',
          fontSize: 10,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}