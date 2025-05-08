import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class EmailSentView extends GetView<ForgotPasswordController> {
  const EmailSentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //* Success icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_circle, size: 50, color: AppColors.primary),
        ),

        const Gap(24),

        //* Success message
        const Text(
          "E-mail envoyé !",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFF272727),
          ),
          textAlign: TextAlign.center,
        ),

        const Gap(16),

        Text(
          "Nous avons envoyé un lien de réinitialisation à ${controller.emailController.text}",
          style: const TextStyle(fontSize: 14, color: Color(0xFF494949)),
          textAlign: TextAlign.center,
        ),

        const Gap(40),

        //* Return to login button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.goToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Retour à la connexion",
              style: TextStyle(
                color: Color(0xFF272727),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
