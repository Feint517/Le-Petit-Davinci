import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
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
              backgroundColor: const Color(0xFF9281FF), // Main Color/Purple - Primary
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF272727),
                  size: 14,
                ),
                SizedBox(width: 6),
                Text(
                  "Précédent",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    color: Color(0xFF272727),
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
              backgroundColor: const Color(0xFF13BB87), // Main Color/Green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLastQuestion ? "Terminer" : "Suivant",
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    color: Color(0xFF272727),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  isLastQuestion ? Icons.check_circle : Icons.arrow_forward_rounded,
                  color: const Color(0xFF272727),
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
