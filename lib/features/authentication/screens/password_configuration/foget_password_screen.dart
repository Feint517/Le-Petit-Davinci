import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/password_configuration/widgets/forget_password_form.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            right: 0,
            bottom: 0,
            child: Image.asset(ImageAssets.giraffe, fit: BoxFit.contain),
          ),

          //* Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height, // Full screen height
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Logo
                      // Center(
                      //   child: SvgPicture.asset(
                      //     SvgAssets.logo,
                      //     width: 158,
                      //     height: 35,
                      //   ),
                      // ),
                      CommonHeader(),
                      const Gap(48),

                      //* Heading
                      const Text(
                        "Mot de passe oublié",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF272727),
                          height: 1.2,
                        ),
                      ),
                      const Gap(12),

                      //* Subheading
                      const Text(
                        "Entrez votre adresse e-mail et nous vous enverrons un lien pour réinitialiser votre mot de passe.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF494949),
                        ),
                      ),
                      const Gap(32),

                      //* Input field and buttons
                      const ForgotPasswordForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
