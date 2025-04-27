import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/screens/login/login.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/register_parent.dart';
import 'package:kids_learning_app/features/splash/widgets/page_illustrations.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/helpers/helper_functions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            PageIllustrations(),

            Padding(
              padding: const EdgeInsets.only(
                left: AppSizes.md,
                right: AppSizes.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Le Petit Da Vinci,\nApprendre en s’amusant !',
                        style: TextStyle(fontSize: 27),
                      ),
                      const Gap(10),
                      Text(
                        'Explore, joue et progresse en français, anglais et en mathématiques !',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.to(() => LoginScreen());
                              },
                              label: Text(
                                'Se connecter',
                                style: TextStyle(color: Color(0xff272727)),
                              ),
                              icon: Icon(
                                Icons.arrow_outward_sharp,
                                size: 15,
                                color: Color(0xff272727),
                              ),
                            ),
                            Gap(HelperFunctions.screenWidth() * 0.05),
                            ElevatedButton.icon(
                              onPressed: () {Get.to(() => RegisterParentScreen());},
                              label: Text(
                                'S’inscrire',
                                style: TextStyle(color: Color(0xff272727)),
                              ),
                              icon: Icon(
                                Icons.arrow_outward_sharp,
                                size: 15,
                                color: Color(0xff272727),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    width: 0,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
