import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({
    super.key,
    required this.label,
    required this.svgPath,
    required this.backgroundColor,
    this.textColor = Colors.black,
  });

  final String label;
  final String svgPath;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: textColor)),
          const Gap(8),
          SvgPicture.asset(svgPath, height: 16),
        ],
      ),
    );
  }
}
