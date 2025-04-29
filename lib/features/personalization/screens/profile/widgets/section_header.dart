import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Bricolage Grotesque',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF4A5568),
      ),
    );
  }
}