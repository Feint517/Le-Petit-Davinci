import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(SvgAssets.illustration),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  SvgAssets.illustration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
