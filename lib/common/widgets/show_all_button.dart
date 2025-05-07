import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ShowAllButton extends StatelessWidget {
  final VoidCallback callback;
  const ShowAllButton({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 62,
      decoration: BoxDecoration( 
        boxShadow: [BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),]
      ),
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
          style: TextStyle(color: AppColors.white,fontFamily: 'Bricolage Grotesque', fontSize: 10),
        ),
      ),
    );
  }
}
