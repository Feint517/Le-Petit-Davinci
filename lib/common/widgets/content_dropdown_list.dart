import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key, required this.optionsList});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();

  final List<String> optionsList;
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.optionsList[0]; // Default selected value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 17),
      //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF9581FF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedOption,
          dropdownColor: AppColors.primaryDeep,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: TextStyle(color: AppColors.white, fontSize: 12),
          isExpanded: true,
          borderRadius: BorderRadius.circular(20),
          items:
              widget.optionsList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(value, style: TextStyle(color: Colors.white)),
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
