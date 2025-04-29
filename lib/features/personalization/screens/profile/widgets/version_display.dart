import 'package:flutter/material.dart';

class VersionDisplay extends StatelessWidget {
  const VersionDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          "Version 1.0.0",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: Color(0xFF718096),
          ),
        ),
      ),
    );
  }
}