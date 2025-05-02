import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String total;
  final String imagePath;
  final double progress;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.title,
    required this.total,
    required this.imagePath,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Image
            SvgPicture.asset(imagePath, height: 40),
            const Gap(12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
            const Gap(4),
            Text(
              total,
              style: TextStyle(color: Color(0xff494949), fontSize: 10),
            ),
            const Gap(12),
            //* Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFDCFFE)),
                minHeight: 8,
              ),
            ),
            // const Gap(20),
            // Center(
            //   child: SizedBox(
            //     height: 27,
            //     width: 120,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         //context.push("/subject-details");
            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.primaryDeep,
            //         shape: StadiumBorder(),
            //       ),
            //       child: Text("Sélectionner", style: TextStyle(fontSize: 10)),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
