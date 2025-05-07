import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/login/login_controller.dart';
import 'package:kids_learning_app/features/home/screens/home_sceen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller.emailController,
            decoration: InputDecoration(
              hintText: "E-mail",
              hintStyle: const TextStyle(
                color: Color(0xFFC4C4C4),
                fontSize: 14,
              ),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  SvgAssets.solar_letter_linear,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFC4C4C4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),

        const Gap(16),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Mot de passe",
              hintStyle: const TextStyle(
                color: Color(0xFFC4C4C4),
                fontSize: 14,
              ),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  SvgAssets.solar_lock_password_linear,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFC4C4C4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  SvgAssets.solar_eye_linear,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    Color(0xFFC4C4C4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),

        //* Login button and forgot password
        const Gap(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Se connecter",
                style: TextStyle(
                  color: Color(0xFF272727),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Mot de passe oublié?",
                style: TextStyle(
                  color: Color(0xFF272727),
                  fontSize: 10,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
