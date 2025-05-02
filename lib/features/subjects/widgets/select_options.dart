import 'package:flutter/material.dart';

class ScrollableSelectableOptions extends StatefulWidget {
  const ScrollableSelectableOptions({super.key});

  @override
  State<ScrollableSelectableOptions>createState() => _ScrollableSelectableOptionsState();
}

class _ScrollableSelectableOptionsState extends State<ScrollableSelectableOptions> {
  final List<String> options = ['Étude', 'Exercices', 'Animation', 'Vidéo', 'Quiz', 'Lecture', 'Jeux'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: List.generate(options.length, (index) {
            final bool isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isSelected ? Color(0xFF9581FF) : Colors.black54,
                      width: 1.5,
                    ),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    options[index],
                    style: TextStyle(
                      color: isSelected ? Color(0xFF9581FF) : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
