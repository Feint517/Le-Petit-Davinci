import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/screens/login/login_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          SvgAssets.logo,
          width: 158,
          height: 35,
          fit: BoxFit.cover,
        ),

        const Gap(16),

        const Text(
          'Inscrivez-vous dès maintenant au Petit Davinci !',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const Gap(12),

        Row(
          children: [
            const Text("Vous avez déjà un compte ? "),
            TextButton(
              onPressed: () => Get.to(LoginScreen()),
              child: Text(
                "Se connecter",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
