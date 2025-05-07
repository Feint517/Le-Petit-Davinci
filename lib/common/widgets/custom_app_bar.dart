import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/custom_progress_bar.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/profile_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => const ProfileScreen()),
          child: const CircleAvatar(
            backgroundImage: AssetImage(IconAssets.avatar),
            radius: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Ma progression de niveau",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Bricolage Grotesque',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    SvgAssets.star_filled,
                                    height: 10,
                                    width: 11,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "400 XP",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFFF6A4D),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) - 200,
                        child: CustomProgressBar(progress: 0.5),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(6),
            ],
          ),
        ),
        const Gap(12),
        Column(
          children: [
            const Gap(4),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(child: SvgPicture.asset(SvgAssets.notification)),
            ),
          ],
        ),
      ],
    );
  }
}
