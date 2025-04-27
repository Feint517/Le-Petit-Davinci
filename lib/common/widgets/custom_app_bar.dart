import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kids_learning_app/common/widgets/custom_progress_bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/avatar.png'),
          radius: 24,
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
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/stars.svg",
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
                        width: MediaQuery.of(context).size.width - 200,
                        child: CustomProgressBar(progress: 0.5),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          children: [
            SizedBox(height: 4),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset("assets/icons/notification.svg")],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
