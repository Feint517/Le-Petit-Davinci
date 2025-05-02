import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class QuizEvaluationScreen extends StatefulWidget {
  const QuizEvaluationScreen({super.key});

  @override
  State<QuizEvaluationScreen> createState() => _QuizEvaluationScreenState();
}

class _QuizEvaluationScreenState extends State<QuizEvaluationScreen> {
  String selectedAnswer = 'Avion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEFFF),
      body: SafeArea(
        child: Column(
          children: [
            //ArrowBackTitle(title: 'Quiz à choix multiples'),
            ProfileHeader(activeIcon: false),
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row

                    // Dropdown and points
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9281FF),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quiz 1 - Quiz de correspondance image et mot",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Question number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Question ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '1/10',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xffFC715A),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffFDCFFE),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Obtenez 10 points",
                            style: TextStyle(
                              color: Color(0xffFC715A),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Question Box
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Devinez le mot correspondant à cette image !",
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 16),
                            // Image placeholder
                            Center(
                              child: Image.asset(
                                ImageAssets.plane,
                                height: 140,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Options
                            _buildOption("Avion", Colors.deepPurple),
                            const SizedBox(height: 12),
                            _buildOption("Dauphin", Colors.pinkAccent),
                            const SizedBox(height: 12),
                            _buildOption("Lampe", Colors.pinkAccent),

                            const SizedBox(height: 20),
                            const Text(
                              "💡 Astuce : Ne te précipite pas ! Prends ton temps pour bien comprendre chaque question avant de choisir ta réponse.",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Navigation buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9D85F6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              SvgAssets.solar_round_alt_arrow_left_linear,
                              height: 15,
                            ),
                            label: const Text(
                              "Précédent",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22B07D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {},
                            icon: const Text(
                              "Suivant",
                              style: TextStyle(color: Colors.black),
                            ),
                            label: SvgPicture.asset(
                              SvgAssets.solar_round_alt_arrow_right_linear,
                              height: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Footer navigation
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6F5E),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.arrow_back, color: Colors.black),
                              SizedBox(width: 6),
                              Text(
                                "Quiz précédent",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Quiz suivant",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward, color: Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String answer, Color borderColor) {
    return InkWell(
      onTap: () => setState(() => selectedAnswer = answer),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                selectedAnswer == answer ? borderColor : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(
              selectedAnswer == answer
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selectedAnswer == answer ? borderColor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(answer, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
