import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final String title;

  const QuizHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF9281FF), // Main Color/Purple - Primary
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Archivo',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
