import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/login/login_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/register_parent.dart';
import 'package:kids_learning_app/features/home/home_sceen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
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
                  const SizedBox(height: 32),
                  Center(
                    child: SvgPicture.asset(
                      SvgAssets.logo,
                      width: 158,
                      height: 35,
                    ),
                  ),

                  //* Login heading
                  const SizedBox(height: 48),
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        "Nouveau ici ? ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF494949),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const RegisterParentScreen());
                        },
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* Input fields
                  const SizedBox(height: 32),
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
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

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
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            SvgAssets.solar_eye_linear,
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFC4C4C4),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),

                  //* Login button and forgot password
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => ChildHomeScreen());
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
                        child: const Text(
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

                  //* PIN login section
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.08),
                          blurRadius: 34,
                          offset: const Offset(12, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Ou connectez vous avec\nvotre ",
                            style: const TextStyle(
                              fontFamily: 'BricolageGrotesque',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF272727),
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text: "code PIN",
                                style: TextStyle(color: AppColors.secondary),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        PinCodeTextField(
                          appContext: context,
                          length: 4,
                          onChanged: (value) {},
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(14),
                            fieldHeight: 56,
                            fieldWidth: 56,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeColor: const Color(0xFFC4C4C4),
                            selectedColor: AppColors.primary,
                            inactiveColor: const Color(0xFFC4C4C4),
                          ),
                          enableActiveFill: true,
                        ),

                        const SizedBox(height: 28),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Connexion avec code PIN",
                              style: TextStyle(
                                color: Color(0xFF272727),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Vous avez oublié votre code PIN?",
                              style: TextStyle(
                                color: Color(0xFF272727),
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
