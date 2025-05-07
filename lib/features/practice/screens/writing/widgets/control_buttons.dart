import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/buttons/svg_button.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgButton(
              label: "Réessayer",
              svgPath: SvgAssets.solar_repeat_linear,
              backgroundColor: AppColors.primaryDeep,
              textColor: AppColors.white,
            ),
          ),
          const Gap(AppSizes.spaceBtwItems),
          Expanded(
            child: SvgButton(
              textColor: AppColors.white,
              label: "Passer",
              svgPath: SvgAssets.solar_rewind_forward_linear,
              backgroundColor: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
