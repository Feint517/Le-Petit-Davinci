import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/helpers/helper_functions.dart';

class PageIllustrations extends StatelessWidget {
  const PageIllustrations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HelperFunctions.screenWidth(),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: SvgPicture.asset(
                  SvgAssets.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            child: SvgPicture.asset(
              SvgAssets.welcomeIllustration,
              width: HelperFunctions.screenHeight() / 2.2,
              fit: BoxFit.contain, //? to preserve the aspect ratio
            ),
          ),
        ],
      ),
    );
  }
}
