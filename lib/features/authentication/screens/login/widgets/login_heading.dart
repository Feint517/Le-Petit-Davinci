import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/register_parent.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LoginHeading extends StatelessWidget {
  const LoginHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Connectez-vous\nau Petit Davinci",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: Color(0xFF272727),
            height: 1.2,
          ),
        ),

        //* Register link
        const Gap(8),
        Row(
          children: [
            const Text(
              "Nouveau ici ? ",
              style: TextStyle(fontSize: 14, color: Color(0xFF494949)),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const RegisterParentScreen());
              },
              child: Text(
                "S'inscrire",
                style: TextStyle(fontSize: 14, color: AppColors.secondary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
