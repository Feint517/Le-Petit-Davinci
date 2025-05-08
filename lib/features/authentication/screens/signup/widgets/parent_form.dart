import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/text_fields/custom_text_field.dart';
import 'package:kids_learning_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class ParentForm extends GetView<SignupController> {
  const ParentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Name field
        CustomTextField(
          controller: controller.parentNameController,
          hintText: "Nom et prénom",
          icon: SvgPicture.asset(SvgAssets.solar_user_linear),
        ),

        const Gap(16),

        CustomTextField(
          controller: controller.emailController,
          hintText: "E-mail",
          icon: SvgPicture.asset(SvgAssets.solar_letter_linear),
        ),

        const Gap(16),

        Obx(
          () => CustomTextField(
            controller: controller.passwordController,
            hintText: "Mot de passe",
            icon: SvgPicture.asset(SvgAssets.solar_lock_password_linear),
            obscureText: controller.obscurePassword.value,
            rightIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: SvgPicture.asset(SvgAssets.solar_eye_linear),
            ),
          ),
        ),

        const Gap(24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Ajouter un compte enfant",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff272727),
                fontWeight: FontWeight.w500,
              ),
            ),
            ElevatedButton.icon(
              onPressed: controller.addChildAccount,
              icon: SvgPicture.asset(SvgAssets.solar_add_circle_linear),
              label: const Text("Ajouter"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey[100],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),

        const Gap(40),

        // Sign up button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.registerParent,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9281FF),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text("S'inscrire", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
