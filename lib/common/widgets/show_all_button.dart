import 'package:flutter/material.dart';

class ShowAllButton extends StatelessWidget {
  final VoidCallback callback;
  const ShowAllButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      width: 62,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Color(0xFFFF6A4D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          "Voir tout",
          style: TextStyle(color: Color(0xff272727), fontSize: 10),
        ),
      ),
    );
  }
}
