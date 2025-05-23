import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class StartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Commencer", style: TextStyle(color: Colors.white,fontFamily: 'BricolageGrotesque',fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
            ],
          ),
        ),
      ),
    );
  }
}
