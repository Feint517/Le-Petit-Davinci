import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/practice/screens/writing/writing_practice.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/header.dart';
import 'package:kids_learning_app/features/lessons/screens/widgets/contenu_precedant_suivant.dart';

class VocabularyLessonScreen extends StatefulWidget {
  const VocabularyLessonScreen({super.key});

  @override
  State<VocabularyLessonScreen> createState() =>
      _VocabulaireLessonScreenState();
}

class _VocabulaireLessonScreenState extends State<VocabularyLessonScreen> {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> vocabulaire = [
    "Contenu 1 - Animaux",
    "Contenu 2 - Objets",
    "Contenu 4 - Les Fruits",
    "Contenu 3 - Les Couleurs",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* AppBar
                //ArrowBackTitle(title: "Alphabet & Prononciation"),
                CommonHeader(title: "Vocabulaire Thématique"),
                //* Section title dropdown
                CustomDropdownButton(options: vocabulaire, optionsList: []),
                //* Tabs
                //* Letter Grid
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(
                    'assets/images/illustrations/sectionvoca.png',
                  ),
                ),
                // Points
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffFDCFFE),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "Obtenez 4 points",
                    style: TextStyle(
                      color: Color(0xffFC715A),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Lesson Content
                Text(
                  "Vocabulaire Thématique",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Le vocabulaire thématique : la girafe.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Text(
                  "La girafe est le mammifère terrestre le plus grand du monde. On la reconnaît à son long cou, à ses pattes élancées et à son pelage orné de taches brunes sur fond crème. Dans la savane, elle se nourrit principalement de feuilles d’acacia qu’elle atteint grâce à sa grande taille.",
                  style: textStyle,
                ),
                SizedBox(height: 40),
                ContenuPrecedantSuivant(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
