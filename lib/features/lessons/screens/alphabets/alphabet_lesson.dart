import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/practice/screens/writing/writing_practice.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/lessons/screens/widgets/contenu_precedant_suivant.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class AlphabetLessonScreen extends StatefulWidget {
  const AlphabetLessonScreen({super.key});

  @override
  State<AlphabetLessonScreen> createState() => _AlphabetLessonScreenState();
}

class _AlphabetLessonScreenState extends State<AlphabetLessonScreen> {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> tabs = ["Étude", "Exercices", "Animation", "Vidéo"];

  final List<String> letters = ["Aa", "Bb", "Cc", "Dd", "Ee", "Ff", "Gg", "Hh"];
  final List<String> lesson = [
    "Contenu 1 - Les Bases de l’Alphabet Français",
    "Contenu 2 - Les Chiffres en Français",
    "Contenu 3 - Les Jours de la Semaine",
  ];
  final List<Color> borderColors = [
    Colors.deepPurpleAccent,
    Colors.deepOrange,
    Colors.teal,
    Colors.amber,
    Colors.amber,
    Colors.teal,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
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
                CommonHeader(
                  pageTitle: "Alphabet & Prononciation",
                  trailing: CircleAvatar(
                    backgroundImage: AssetImage(IconAssets.avatar),
                    radius: 24,
                  ),
                ),

                //* Section title dropdown
                CustomDropdownButton(options: lesson, optionsList: []),

                //* Tabs
                //* Letter Grid
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toucher une lettre pour entendre son son.",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 15),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(letters.length, (index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: borderColors[index],
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              letters[index],
                              style: TextStyle(fontSize: 22),
                            ),
                          );
                        }),
                      ),
                    ],
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
                  "Les Bases de l’Alphabet Français",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "L’alphabet français se compose de 26 lettres, divisées en voyelles et consonnes. Chaque lettre a un son spécifique qui peut varier selon les mots et les accents.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dans cette leçon, tu apprendras :", style: textStyle),
                    SizedBox(height: 5),
                    Text(
                      "🔷 La prononciation correcte de chaque lettre.",
                      style: textStyle,
                    ),
                    Text(
                      "🔷 La différence entre voyelles et consonnes.",
                      style: textStyle,
                    ),
                    Text(
                      "🔷 Comment associer les lettres à des mots simples.",
                      style: textStyle,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "💡 Astuce : Pratique régulièrement en lisant des mots simples à voix haute pour améliorer ton accent et ta fluidité.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
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
