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
    return Row(
      children: [
        // Previous button
        Expanded(
          child: ElevatedButton(
            onPressed: isFirstQuestion ? null : onPrevious,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDeep,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: isFirstQuestion ? Colors.grey : Color(0xFF272727),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  "Précédent",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    letterSpacing: -0.04 * 12,
                    color: isFirstQuestion ? Colors.grey : Color(0xFF272727),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 10),
        
        // Next button
        Expanded(
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Suivant",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    letterSpacing: -0.04 * 12,
                    color: Color(0xFF272727),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF272727),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}