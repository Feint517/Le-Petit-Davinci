import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/login/login_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:kids_learning_app/features/authentication/screens/login/widgets/login_heading.dart';
import 'package:kids_learning_app/features/authentication/screens/login/widgets/pin_section.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          //*  Giraffe illustration on the right
          Positioned(
            top: 100,
            right: 0,
            bottom: 0,
            child: Image.asset(ImageAssets.giraffe, fit: BoxFit.contain),
          ),

          //* Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Logo
                  Center(
                    child: SvgPicture.asset(
                      SvgAssets.logo,
                      width: 158,
                      height: 35,
                    ),
                  ),
                  const Gap(48),

                  //* Login heading
                  LoginHeading(),
                  const Gap(32),

                  //* Input fields
                  LoginForm(),
                  const Gap(48),

                  //* PIN login section
                  PinSection(),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
