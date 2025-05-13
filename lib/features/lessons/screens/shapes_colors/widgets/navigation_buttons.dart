import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool isFirstQuestion;
  final bool isLastQuestion;

  const NavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
    this.isFirstQuestion = false,
    this.isLastQuestion = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous button
        if (!isFirstQuestion)
          Expanded(
            child: _buildNavigationButton(
              onTap: onPrevious,
              icon: Icons.arrow_back,
              text: 'Précédent',
              color: Colors.grey.shade200,
              textColor: Colors.grey.shade700,
            ),
          )
        else
          const Spacer(),
        const SizedBox(width: 16),

        // Next/Verify button
        Expanded(
          flex: 2,
          child: _buildNavigationButton(
            onTap: onNext,
            icon:
                isLastQuestion
                    ? Icons.check_circle_outline
                    : Icons.arrow_forward,
            text: isLastQuestion ? 'Terminer' : 'Vérifier',
            color: AppColors.primaryDeep,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required Color color,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
