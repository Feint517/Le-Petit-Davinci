import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/buttons/svg_button.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SvgButton(
            label: "Réessayer",
            svgPath: SvgAssets.solar_repeat_linear,
            backgroundColor: AppColors.primaryDeep,
          ),
        ),
        const Gap(AppSizes.spaceBtwItems),
        Expanded(
          child: SvgButton(
            label: "Passer",
            svgPath:
                SvgAssets.solar_rewind_forward_linear,
            backgroundColor: AppColors.accent,
          ),
        ),
      ],
    );
  }
}