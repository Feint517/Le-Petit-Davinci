import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String total;
  final String imagePath;
  final double progress;

  const SubjectCard({
    super.key,
    required this.title,
    required this.total,
    required this.imagePath,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //context.push("/subject-details");
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SvgPicture.asset(imagePath, height: 40),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
              total,
              style: TextStyle(color: Color(0xff494949), fontSize: 10),
            ),
            const SizedBox(height: 12),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Color(0xffFFFFFF),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFDCFFE)),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 27,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    //context.push("/subject-details");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff9281FF),
                    shape: StadiumBorder(),
                  ),
                  child: Text("Sélectionner", style: TextStyle(fontSize: 10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
