import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key , required this.Options});
  final List<String> Options;
  

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedOption;
  
  @override
  void initState() {
    super.initState();
    selectedOption = widget.Options.isNotEmpty ? widget.Options[0] : null;
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(  vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFF9581FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
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
          items: widget.Options.map((String value) {
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
