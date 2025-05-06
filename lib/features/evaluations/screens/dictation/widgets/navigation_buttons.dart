import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isFirstQuestion;
  final bool isLastQuestion;
  
  const NavigationButtons({
    Key? key,
    required this.onPrevious,
    required this.onNext,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to adapt button sizes based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Row(
      children: [
        // Previous button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: isFirstQuestion 
                    ? Colors.transparent 
                    : AppColors.primaryDeep.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: isFirstQuestion ? null : onPrevious,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFirstQuestion 
                  ? AppColors.primaryDeep.withOpacity(0.3) 
                  : AppColors.primaryDeep,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 12 : 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: isSmallScreen ? 14 : 16,
                  ),
                  SizedBox(width: isSmallScreen ? 4 : 8),
                  Text(
                    "Précédent",
                    style: TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Next button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 12 : 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastQuestion ? "Terminer" : "Suivant",
                    style: TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 4 : 8),
                  Icon(
                    isLastQuestion ? Icons.check_circle : Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: isSmallScreen ? 14 : 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}