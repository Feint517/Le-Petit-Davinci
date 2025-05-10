import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NavigationButtons extends StatelessWidget {
  final bool canGoBack;
  final bool canGoForward;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const NavigationButtons({
    super.key,
    required this.canGoBack,
    required this.canGoForward,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: canGoBack ? onPrevious : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF9281FF,
              ), // Main Color/Purple - Primary
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
                Gap(6),
                Text(
                  'Précédent',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 12,
                    fontFamily: 'Bricolage Grotesque',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: ElevatedButton(
            onPressed: canGoForward ? onNext : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF13BB87), // Main Color/Green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Suivant',
                  style: TextStyle(
                    color: Color(0xFF272727),
                    fontSize: 12,
                    fontFamily: 'Bricolage Grotesque',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(6),
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
