import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionImage extends StatelessWidget {
  final String imagePath;

  const QuestionImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        height: 143,
        width: double.infinity,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        imagePath,
        height: 143,
        width: double.infinity,
        fit: BoxFit.contain,
      );
    }
  }
}
