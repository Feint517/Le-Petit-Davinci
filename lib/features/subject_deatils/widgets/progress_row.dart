import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ProgressRow extends StatelessWidget {
  const ProgressRow({super.key,
    required this.finishedLessons,
    required this.totalLessons,
  });

  final int finishedLessons;
  final int totalLessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Progression affichée",
              style: TextStyle(color: AppColors.black, fontSize: 12),
            ),
            Row(
              children: [
                SvgPicture.asset(SvgAssets.solar_clipboard_check_linear),
                const Gap(6),
                Text(
                  "$finishedLessons/$totalLessons leçons terminées",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(8),
        //* Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: finishedLessons / totalLessons,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryDeep),
          ),
        ),
      ],
    );
  }
}
