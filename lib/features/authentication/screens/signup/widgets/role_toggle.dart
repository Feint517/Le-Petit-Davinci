import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/signup/signup_controller.dart';

class RoleToggle extends GetView<SignupController> {
  const RoleToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Child Button
          Expanded(
            child: GestureDetector(
              onTap: () => controller.toggleRole(true),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:
                        controller.isChildSelected.value
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                    width: 1.5,
                  ),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enfant",
                      style: TextStyle(
                        color:
                            controller.isChildSelected.value
                                ? Colors.deepPurpleAccent
                                : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Gap(16),

          // Parent Button
          Expanded(
            child: GestureDetector(
              onTap: () => controller.toggleRole(false),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:
                        !controller.isChildSelected.value
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                    width: 1.2,
                  ),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Parent",
                      style: TextStyle(
                        color:
                            !controller.isChildSelected.value
                                ? Colors.deepPurpleAccent
                                : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}