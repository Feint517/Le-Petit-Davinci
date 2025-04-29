import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //* Banner as base
        SvgPicture.asset(
          SvgAssets.banner_illustration,
          width: DeviceUtils.getScreenWidth(context),
          fit: BoxFit.fitWidth,
        ),

        //* Logo positioned on top of banner
        Positioned(
          top: 56, //? Position to match Figma design
          child: SvgPicture.asset(SvgAssets.logo, width: 158, height: 35),
        ),
      ],
    );
  }
}