import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/practice/screens/writing/writing_practice.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/lessons/screens/widgets/contenu_precedant_suivant.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class ConstructionLessonScreen extends StatefulWidget {
  const ConstructionLessonScreen({super.key});

  @override
  State<ConstructionLessonScreen> createState() =>
      _ConstructionLessonScreenState();
}

class _ConstructionLessonScreenState extends State<ConstructionLessonScreen> {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> vocabulaire = [
    "Contenu 1 - Phrases Simples",
    "Contenu 2 - Phrases Complexes",
    "Contenu 3 - Phrases Interrogatives",
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
                CommonHeader(pageTitle: "Vocabulaire Thématique",trailing: CircleAvatar(
                    backgroundImage: AssetImage(IconAssets.avatar),
                    radius: 24,
                  ),),
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
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/illustrations/sorry.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 50),
                        Image.asset(
                          'assets/images/illustrations/dsl.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
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
                  "Construction De Phrases Simples",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Phrases Simples : Je suis désolé.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontFamily: 'BricolageGrotesque',
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Text(
                  "L’expression « Je suis désolé » sert à présenter ses excuses ou exprimer son regret après avoir fait ou dit quelque chose qui a pu blesser, déranger ou décevoir quelqu’un. On l’emploie dans des contextes formels et informels pour montrer que l’on reconnaît une erreur ou une maladresse.",
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
