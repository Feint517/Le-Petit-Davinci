import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class SubjectDescription extends StatelessWidget {
  const SubjectDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(SvgAssets.abc, height: 50),
        const Gap(12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Français',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6),
              Text(
                'Maîtrisez la langue française avec des leçons interactives, des exercices ludiques et des quiz éducatifs !',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}