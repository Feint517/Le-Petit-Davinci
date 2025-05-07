import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionItem({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB), // Neutral Color/White Silk
          border: Border.all(
            color: isSelected ? const Color(0xFF9281FF) : const Color(0xFFFDCFFE),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF494949), width: 0.8),
                  ),
                  child: isSelected
                      ? Container(
                          margin: const EdgeInsets.all(2.86),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF9281FF), // Main Color/Purple - Primary
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  option,
                  style: const TextStyle(
                    color: Color(0xFF494949),
                    fontSize: 18,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.72, // Equivalent to -0.04 * 18
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
