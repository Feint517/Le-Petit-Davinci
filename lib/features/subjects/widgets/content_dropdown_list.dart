import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final List<String> options = [
    "Contenu 1 - Les Bases de l’Alphabet Français",
    "Contenu 2 - Les Chiffres en Français",
    "Contenu 3 - Les Jours de la Semaine",
  ];

  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = options[0]; // Default selected value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF9581FF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedOption,
          dropdownColor: Colors.black,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: TextStyle(color: Colors.white, fontSize: 12),
          isExpanded: true,
          borderRadius: BorderRadius.circular(20),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue;
            });
          },
        ),
      ),
    );
  }
}
