import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/features/subjects/widgets/content_dropdown_list.dart';
import 'package:kids_learning_app/features/subjects/widgets/select_options.dart';

class AlphabetLessonScreen extends StatefulWidget {
  const AlphabetLessonScreen({super.key});

  @override
  State<AlphabetLessonScreen> createState() => _AlphabetLessonScreenState();
}

class _AlphabetLessonScreenState extends State<AlphabetLessonScreen> {
  TextStyle textStyle = TextStyle(fontSize: 12);
  final List<String> tabs = ["Étude", "Exercices", "Animation", "Vidéo"];

  final List<String> letters = ["Aa", "Bb", "Cc", "Dd", "Ee", "Ff", "Gg", "Hh"];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* AppBar
              //ArrowBackTitle(title: "Alphabet & Prononciation"),
              ProfileHeader(activeIcon: false),
              //* Section title dropdown
              CustomDropdownButton(),

              //* Tabs
              ScrollableSelectableOptions(),

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
              ),

              SizedBox(height: 15),

              // Lesson Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Les Bases de l’Alphabet Français",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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
              ),

              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF7A5C),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),

                                Text(
                                  "Contenu précédent",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Contenu suivant",
                                  style: TextStyle(color: Colors.black),
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
