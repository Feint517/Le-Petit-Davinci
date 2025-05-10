import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinSection extends StatelessWidget {
  const PinSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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

          const Gap(28),

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

          const Gap(28),

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

          const Gap(12),
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
    );
  }
}
