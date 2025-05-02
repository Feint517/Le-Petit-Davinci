import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/stat_box.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class SubjectStatsRow extends StatelessWidget {
  const SubjectStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    double boxWidth = (MediaQuery.of(context).size.width - 60) / 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatBox(
          title: 'Leçon',
          iconPath: SvgAssets.solar_notebook_bookmark_linear,
          valueRich: const [
            TextSpan(
              text: '6',
              style: TextStyle(
                color: Color(0xFF9281FF),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '/10',
              style: TextStyle(color: Colors.black26, fontSize: 17),
            ),
          ],
          width: boxWidth,
        ),
        StatBox(
          title: 'Pratiquer',
          iconPath: SvgAssets.solar_square_academic_cap_linear,
          valueRich: const [
            TextSpan(
              text: '80%',
              style: TextStyle(
                color: Color(0xFF9281FF),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          width: boxWidth,
        ),
        StatBox(
          title: 'Durée des études',
          iconPath: SvgAssets.solar_clock_circle_linear,
          valueRich: const [
            TextSpan(
              text: '148/300',
              style: TextStyle(
                color: Color(0xFF9281FF),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' heures',
              style: TextStyle(color: Colors.black45, fontSize: 8),
            ),
          ],
          width: boxWidth,
        ),
      ],
    );
  }
}