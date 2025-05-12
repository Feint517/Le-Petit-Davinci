// lib/features/authentication/screens/registration_screen.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/widgets/child_form.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/widgets/parent_form.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/widgets/role_toggle.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // S'assurer que le contrôleur de signup est initialisé
    if (!Get.isRegistered<SignupController>()) {
      Get.put(SignupController());
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SignupHeader(),
              const Gap(24),

              RoleToggle(),
              const Gap(20),

              //* Dynamic content based on role
              Obx(
                () =>
                    controller.isChildSelected.value
                        ? ChildForm()
                        : ParentForm(),
              ),
              // GetX<SignupController>(
              //   builder:
              //       (controller) =>
              //           controller.isChildSelected.value
              //               ? ChildForm()
              //               : ParentForm(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
