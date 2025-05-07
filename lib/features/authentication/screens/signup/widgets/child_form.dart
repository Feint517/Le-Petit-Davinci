import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/text_fields/custom_text_field.dart';
import 'package:kids_learning_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChildForm extends GetView<SignupController> {
  const ChildForm({super.key});

  @override
  Widget build(BuildContext context) {
    final avatars = List.generate(
      8,
      (index) => 'assets/images/avatars/Avatar-$index.png',
    );
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Username field
        CustomTextField(
          controller: controller.usernameController,
          hintText: "Nom et prénom",
          icon: SvgPicture.asset(SvgAssets.solar_user_linear),
        ),

        const SizedBox(height: 24),

        const Text(
          "Choisissez votre avatar",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),

        const SizedBox(height: 12),

        // Obx(
        //   () => Wrap(
        //     spacing: 12,
        //     runSpacing: 12,
        //     children: List.generate(avatars.length, (index) {
        //       return GestureDetector(
        //         onTap: () => controller.setAvatar(index),
        //         child: Container(
        //           width: screenWidth * 0.18,
        //           height: screenWidth * 0.18,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             border: Border.all(
        //               color:
        //                   controller.selectedAvatar.value == index
        //                       ? Colors.deepPurple
        //                       : Colors.transparent,
        //               width: 2,
        //             ),
        //           ),
        //           child: ClipOval(
        //             child: Image.asset(avatars[index], fit: BoxFit.cover),
        //           ),
        //         ),
        //       );
        //     }),
        //   ),
        // ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(avatars.length, (index) {
            return GestureDetector(
              onTap: () => controller.setAvatar(index),
              child: Obx(
                () => Container(
                  width: screenWidth * 0.18,
                  height: screenWidth * 0.18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          controller.selectedAvatar.value == index
                              ? Colors.deepPurple
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(avatars[index], fit: BoxFit.cover),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 24),

        const Text(
          "Définissez votre code PIN",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),

        const SizedBox(height: 8),

        PinCodeTextField(
          appContext: context,
          length: 4,
          controller: controller.pinController,
          onChanged: (value) {},
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 55,
            fieldWidth: 55,
            activeFillColor: Colors.grey[100]!,
            inactiveFillColor: Colors.grey[100]!,
            selectedFillColor: Colors.white,
            activeColor: Colors.deepPurple,
            selectedColor: Colors.deepPurple,
            inactiveColor: const Color(0XffF9FAFB),
          ),
          enableActiveFill: true,
        ),

        const SizedBox(height: 24),

        const Text(
          "Sélectionnez le niveau scolaire",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),

        const SizedBox(height: 12),

        // Obx(
        //   () => Row(
        //     children: [
        //       _buildGradeOption(controller, 1, "1ere année"),
        //       const SizedBox(width: 10),
        //       _buildGradeOption(controller, 2, "2eme année"),
        //     ],
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Child Button
            Expanded(
              child: GestureDetector(
                onTap: () => controller.toggleRole(true),
                child: Obx(
                  () => Container(
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
            ),

            const Gap(16),

            // Parent Button with similar Obx() wrapping
          ],
        ),

        const SizedBox(height: 40),

        // Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.registerChild,
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