import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/custom_app_bar.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/common/widgets/statCard.dart';
import 'package:kids_learning_app/common/widgets/subject_card.dart';
import 'package:kids_learning_app/features/home/home_page2.dart';

class ChildHomeScreen extends StatefulWidget {
  const ChildHomeScreen({super.key});

  @override
  State<ChildHomeScreen> createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  final Color lightPurple = Color(0xFFF9ECFF);

  final Color purple = Color(0xFF9D8CFF);

  final Color softPurple = Color(0xFFDAD0FF);

  final Color orange = Color(0xFFFF725E);

  String selectedSubject = 'Français';

  final subjects = [
    {
      "title": "Mathématiques",
      "total": "15 matériaux au total",
      "image": "assets/icons/abc.png",
      "progress": 0.7,
      "color": Color(0xFFBBA1FF),
    },
    {
      "title": "Français",
      "total": "10 matériaux au total",
      "image": "assets/icons/abc.png",
      "progress": 0.5,
      "color": Color(0xFFFFA7EC),
    },
    {
      "title": "Anglais",
      "total": "10 matériaux au total",
      "image": "assets/icons/abc.png",
      "progress": 0.3,
      "color": Color(0xFFFFB89E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile and Progress
              CustomAppBar(),
              SizedBox(height: 24),
              // Welcome Text
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Bonjour Younes',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff494949),
                                ),
                              ),
                              Text(
                                'March, 17 2025',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff494949),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Content de te revoir',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Cards Row
                          Row(
                            children: [
                              // Leçon
                              Expanded(
                                child: StatCard(
                                  title: 'Leçon',
                                  value: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '24',
                                          style: TextStyle(
                                            color: Color(0xFF9281FF),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '/35',
                                          style: TextStyle(
                                            color: Color(0xffC3C3C3),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon:
                                      'assets/icons/solar_notebook-bookmark-linear.svg',
                                  actionLabel: 'Continuer à apprendre',
                                  actionColor: Color(0xFF9281FF),
                                ),
                              ),

                              const SizedBox(width: 16),

                              // Points
                              Expanded(
                                child: StatCard(
                                  title: 'Points',
                                  value: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '400',
                                          style: TextStyle(
                                            color: Color(0xFFFF725E),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '/620',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon: 'assets/icons/star.svg',
                                  actionLabel: 'Obtenez des points',
                                  actionColor: Color(0xFFFF725E),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Featured Lesson Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9281FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side - Text
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Chip
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Text(
                                        'Français',
                                        style: TextStyle(
                                          color: Color(0xFFFF725E),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Vocabulaire thématique',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '4 Contenu',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          height: 5,
                                          width: 5,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffFDCFFE),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '1 Heures 20 Minutes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // Continue button
                                    SizedBox(
                                      width: 165,
                                      height: 26,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Continuer à apprendre',
                                          style: TextStyle(
                                            color: Color(0xFF9281FF),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Right side - Image
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Image.asset(
                                  'assets/images/chat_character.png',

                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Matières
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sélection des matières",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ShowAllButton(callback: () {}),
                ],
              ),
              SizedBox(height: 12),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            child: SubjectCard(
                              title: subject['title']! as String,
                              total: subject['total'] as String,
                              imagePath: subject['image'] as String,
                              progress: subject['progress'] as double,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 25),

              // Jeux éducatifs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choisissez des jeux éducatifs",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  ShowAllButton(callback: () {}),
                ],
              ),
              SizedBox(height: 0),
              ChildHomeScreen2(),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets
class InfoCard extends StatelessWidget {
  final String title, mainText, subText;
  final Color color;

  InfoCard({
    required this.title,
    required this.mainText,
    required this.subText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(mainText, style: TextStyle(fontSize: 20, color: color)),
          SizedBox(height: 4),
          Text(
            subText,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
