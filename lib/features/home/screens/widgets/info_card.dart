import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title, mainText, subText;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.mainText,
    required this.subText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(mainText, style: TextStyle(fontSize: 20, color: color)),
          SizedBox(height: 4),
          Text(
            subText,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}