import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  final String imagePath;
  final List<String> options;
  final Function(String) onOptionSelected;
  final String? selectedOption;

  const QuestionBox({
    super.key,
    required this.imagePath,
    required this.options,
    required this.onOptionSelected,
    this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Image
          Padding(
            padding: const EdgeInsets.all(33.0),
            child: Image.asset(
              imagePath,
              height: 161,
              width: 205,
              fit: BoxFit.contain,
            ),
          ),
          
          // Decoration lines
          Center(
            child: Container(
              width: 143,
              height: 2,
              color: const Color(0xFF494949),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 95,
              height: 2,
              color: const Color(0xFF494949),
            ),
          ),
          
          const Spacer(),
          
          // Options
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: options.map((option) {
                final isSelected = option == selectedOption;
                return ElevatedButton(
                  onPressed: () => onOptionSelected(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(
                      color: isSelected ? const Color(0xFF9281FF) : Colors.black,
                      width: isSelected ? 2 : 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 12,
                      color: Color(0xFF272727),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
