import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class CommonHeader extends StatelessWidget {
  const CommonHeader({
    super.key,
    this.pageTitle,
    this.trailing,
    this.onTapTrailing,
  });

  final String? pageTitle;
  final Widget? trailing;
  final VoidCallback? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  Text(
                    'Retour',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'BricolageGrotesque',
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child:
                  pageTitle != null
                      ? Text(
                        pageTitle!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BricolageGrotesque',
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
        Spacer(),
        trailing != null
            ? GestureDetector(onTap: onTapTrailing, child: trailing!)
            : const SizedBox.shrink(),
      ],
    );
  }
}
