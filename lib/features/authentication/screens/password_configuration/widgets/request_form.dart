import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class RequestForm extends GetView<ForgotPasswordController> {
  const RequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email input field
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre adresse e-mail';
                }
                if (!GetUtils.isEmail(value)) {
                  return 'Veuillez entrer une adresse e-mail valide';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
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

          const Gap(32),

          // Reset password button
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isLoading.value
                        ? null
                        : controller.resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.7,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child:
                    controller.isLoading.value
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF272727),
                          ),
                        )
                        : const Text(
                          "Réinitialiser le mot de passe",
                          style: TextStyle(
                            color: Color(0xFF272727),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
              ),
            ),
          ),

          const Gap(24),

          // Back to login
          Center(
            child: TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "Retour à la connexion",
                style: TextStyle(
                  color: Color(0xFF272727),
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
