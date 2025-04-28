import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/screens/login/login.dart';
import 'package:kids_learning_app/features/authentication/screens/signup/register_parent.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner and Logo with tight positioning
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Banner as base
                  SvgPicture.asset(
                    SvgAssets.banner_illustration,
                    width: screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  
                  // Logo positioned on top of banner
                  Positioned(
                    top: 56, // Position to match Figma design
                    child: SvgPicture.asset(
                      SvgAssets.logo,
                      width: 158,
                      height: 35,
                    ),
                  ),
                ],
              ),
              
              // Main illustration
              SvgPicture.asset(
                SvgAssets.splashIllustration,
                width: screenWidth,
                fit: BoxFit.fitWidth,
              ),
              
              // Content Section
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Heading
                    Text(
                      'Le Petit Da Vinci,\nApprendre en s\'amusant !',
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 30 : 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.06,
                        color: const Color(0xFF272727),
                        fontFamily: 'BricolageGrotesque',
                      ),
                    ),
                    const Gap(10),
                    
                    // Subheading
                    Text(
                      'Explore, joue et progresse en français, anglais et en mathématiques !',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF494949),
                      ),
                    ),
                    
                    const Gap(24),
                    
                    // Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Connect Button
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          icon: const Icon(
                            Icons.arrow_outward_sharp, 
                            size: 14,
                            color: Color(0xFF272727),
                          ),
                          label: const Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        
                        const Gap(16),
                        
                        // Register Button
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => const RegisterParentScreen());
                          },
                          icon: const Icon(
                            Icons.arrow_outward_sharp,
                            size: 14,
                            color: Color(0xFF272727),
                          ),
                          label: const Text(
                            'S\'inscrire',
                            style: TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonSecondary,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
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
      ),
    );
  }
}