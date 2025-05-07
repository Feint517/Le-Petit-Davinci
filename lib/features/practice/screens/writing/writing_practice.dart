import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class WritingPracticeScreen extends StatefulWidget {
  const WritingPracticeScreen({super.key});

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  // Selected level
  String selectedLevel = 'Intermédiaire';
  String selectedContent = "Contenu 1 - Les Bases de l'Alphabet Français";

  // Content list for dropdown
  final List<String> contentList = [
    "Contenu 1 - Les Bases de l'Alphabet Français",
    "Contenu 2 - Les Chiffres en Français",
    "Contenu 3 - Les Jours de la Semaine",
  ];

  // Exercise data mapping - Different exercises for each content and level
  final Map<String, Map<String, List<ExerciseItem>>> allExercises = {
    // Content 1 - Les Bases de l'Alphabet Français
    "Contenu 1 - Les Bases de l'Alphabet Français": {
      // Different difficulty levels
      'Débutant': [
        ExerciseItem(
          phrase: "L'_______ français contient 26 lettres.",
          options: ["alphabet", "école", "enfant"],
          correctAnswer: "alphabet",
        ),
        ExerciseItem(
          phrase: "Les _______ sont A, E, I, O, U, Y.",
          options: ["voyages", "voyelles", "verbes"],
          correctAnswer: "voyelles",
        ),
        ExerciseItem(
          phrase: "Je connais toutes les _______ de A à Z.",
          options: ["livres", "lettres", "leçons"],
          correctAnswer: "lettres",
        ),
      ],
      'Intermédiaire': [
        ExerciseItem(
          phrase: "Je vais y aller et...",
          options: ["revenir", "maison", "retour"],
          correctAnswer: "revenir",
        ),
        ExerciseItem(
          phrase: "Que ... manger",
          options: ["donne-moi", "veux-tu", "puis-je"],
          correctAnswer: "puis-je",
        ),
        ExerciseItem(
          phrase: "Qu'est-ce que tu fais pour...",
          options: ["habites-tu", "arrives-tu", "t'amuser"],
          correctAnswer: "t'amuser",
        ),
      ],
      'Avancé': [
        ExerciseItem(
          phrase: "Les accents _______ la prononciation des lettres.",
          options: ["modifient", "écrivent", "créent"],
          correctAnswer: "modifient",
        ),
        ExerciseItem(
          phrase: "Le français est une langue _______ du latin.",
          options: ["dérivée", "éloignée", "séparée"],
          correctAnswer: "dérivée",
        ),
        ExerciseItem(
          phrase: "La _______ française est riche en exceptions grammaticales.",
          options: ["littérature", "langue", "lecture"],
          correctAnswer: "langue",
        ),
      ],
    },

    // Content 2 - Les Chiffres en Français
    "Contenu 2 - Les Chiffres en Français": {
      'Débutant': [
        ExerciseItem(
          phrase: "Un plus deux égale _______.",
          options: ["deux", "trois", "quatre"],
          correctAnswer: "trois",
        ),
        ExerciseItem(
          phrase: "Il y a _______ jours dans une semaine.",
          options: ["cinq", "six", "sept"],
          correctAnswer: "sept",
        ),
        ExerciseItem(
          phrase: "Nous avons _______ doigts sur chaque main.",
          options: ["quatre", "cinq", "six"],
          correctAnswer: "cinq",
        ),
      ],
      'Intermédiaire': [
        ExerciseItem(
          phrase: "En français, 80 s'écrit _______.",
          options: ["huitante", "octante", "quatre-vingts"],
          correctAnswer: "quatre-vingts",
        ),
        ExerciseItem(
          phrase: "Le chiffre qui suit soixante-dix-neuf est _______.",
          options: ["quatre-vingt", "huitante", "octante"],
          correctAnswer: "quatre-vingt",
        ),
        ExerciseItem(
          phrase: "Il y a _______ mois dans une année.",
          options: ["dix", "onze", "douze"],
          correctAnswer: "douze",
        ),
      ],
      'Avancé': [
        ExerciseItem(
          phrase: "Le système numérique _______ est utilisé en mathématiques.",
          options: ["cardinal", "décimal", "ordinal"],
          correctAnswer: "décimal",
        ),
        ExerciseItem(
          phrase: "Un _______ est composé de 10 décennies.",
          options: ["siècle", "millénaire", "lustre"],
          correctAnswer: "siècle",
        ),
        ExerciseItem(
          phrase:
              "Les nombres _______ sont utilisés pour classer des éléments.",
          options: ["cardinaux", "ordinaux", "premiers"],
          correctAnswer: "ordinaux",
        ),
      ],
    },

    // Content 3 - Les Jours de la Semaine
    "Contenu 3 - Les Jours de la Semaine": {
      'Débutant': [
        ExerciseItem(
          phrase: "Le premier jour de la semaine est _______.",
          options: ["lundi", "dimanche", "samedi"],
          correctAnswer: "lundi",
        ),
        ExerciseItem(
          phrase: "_______ est le jour avant dimanche.",
          options: ["Vendredi", "Samedi", "Jeudi"],
          correctAnswer: "Samedi",
        ),
        ExerciseItem(
          phrase: "Nous allons à l'école du lundi au _______.",
          options: ["jeudi", "vendredi", "dimanche"],
          correctAnswer: "vendredi",
        ),
      ],
      'Intermédiaire': [
        ExerciseItem(
          phrase: "Le week-end comprend le samedi et le _______.",
          options: ["vendredi", "dimanche", "lundi"],
          correctAnswer: "dimanche",
        ),
        ExerciseItem(
          phrase: "_______ est le milieu de la semaine de travail.",
          options: ["Mardi", "Mercredi", "Jeudi"],
          correctAnswer: "Mercredi",
        ),
        ExerciseItem(
          phrase: "Après _______, on commence une nouvelle semaine.",
          options: ["vendredi", "samedi", "dimanche"],
          correctAnswer: "dimanche",
        ),
      ],
      'Avancé': [
        ExerciseItem(
          phrase: "Les noms des jours en français viennent du _______.",
          options: ["grec", "latin", "germanique"],
          correctAnswer: "latin",
        ),
        ExerciseItem(
          phrase: "Le mot \"dimanche\" est lié au mot latin _______.",
          options: ["dies dominica", "dies solis", "dies martis"],
          correctAnswer: "dies dominica",
        ),
        ExerciseItem(
          phrase:
              "Dans le calendrier international, la semaine commence le _______.",
          options: ["lundi", "dimanche", "samedi"],
          correctAnswer: "lundi",
        ),
      ],
    },
  };

  // Active exercises based on current content and level
  List<ExerciseItem> get exercises {
    return allExercises[selectedContent]?[selectedLevel] ?? [];
  }

  // Track selected answers for each exercise - will be initialized in initState
  late List<String?> selectedAnswers;

  // Track if exercises have been validated - will be initialized in initState
  late List<bool?> exerciseValidations;

  // Track current points and attempts
  int points = 0;
  int attemptsLeft = 2;

  // Track if the exercise set has been completed
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    // Initialize arrays based on current exercises
    _resetArrays();
  }

  // Reset arrays based on current exercises length
  void _resetArrays() {
    selectedAnswers = List.filled(exercises.length, null);
    exerciseValidations = List.filled(exercises.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Column(
              children: [
                const CommonHeader(),
                
                const Gap(AppSizes.defaultSpace),

                SingleChildScrollView(
                  primary: false,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Custom dropdown for content selection
                          CustomDropdownButton(
                            options: [],
                            optionsList: contentList,
                            initialValue: selectedContent,
                            onOptionSelected: (option) {
                              // Update content and reset exercise
                              setState(() {
                                selectedContent = option;
                                selectedAnswers = List.filled(
                                  exercises.length,
                                  null,
                                );
                                exerciseValidations = List.filled(
                                  exercises.length,
                                  null,
                                );
                                isCompleted = false;
                                attemptsLeft = 2;
                                points = 0;
                              });
                            },
                          ),
                          const Gap(AppSizes.spaceBtwItems),

                          // Level selection
                          _buildLevelSelector(),
                          const Gap(AppSizes.spaceBtwSections),

                          // Exercise boxes
                          _buildExerciseBoxSection(),
                          const Gap(AppSizes.spaceBtwSections),

                          // Control buttons
                          _buildControlButtons(),
                          const Gap(AppSizes.spaceBtwItems),

                          // Points indicator
                          _buildPointsIndicator(),
                          const Gap(AppSizes.spaceBtwSections),

                          // Exercise description
                          const Text(
                            "Perfectionne ton écriture et ta lecture",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "La lecture et l'écriture sont essentielles pour maîtriser la langue française. Cet exercice interactif t'aide à enrichir ton vocabulaire et à améliorer ta compréhension des phrases.",
                            style: TextStyle(fontSize: 11),
                          ),
                          const SizedBox(height: 28),

                          // Navigation for content
                          _buildNavigationFooter(context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          ['Débutant', 'Intermédiaire', 'Avancé'].map((label) {
            final isSelected = label == selectedLevel;
            return GestureDetector(
              onTap:
                  () => setState(() {
                    selectedLevel = label;
                    // Reset exercise when level changes
                    selectedAnswers = List.filled(exercises.length, null);
                    exerciseValidations = List.filled(exercises.length, null);
                    isCompleted = false;
                    attemptsLeft = 2;
                    points = 0;
                  }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryDeep : Colors.black87,
                    width: 1.5,
                  ),
                  color:
                      isSelected ? const Color(0xFFEFE3FF) : Colors.transparent,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.primaryDeep
                                  : AppColors.black,
                          width: 2,
                        ),
                      ),
                      child:
                          isSelected
                              ? Center(
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF9281FF),
                                  ),
                                ),
                              )
                              : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color:
                            isSelected ? AppColors.primaryDeep : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildExerciseBoxSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Compléter des phrases avec des mots manquants.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          // Build exercise boxes
          for (int i = 0; i < exercises.length; i++) ...[
            _buildExerciseBox(exercises[i].phrase, exercises[i].options, i),
            if (i < exercises.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseBox(String phrase, List<String> options, int index) {
    // Get the validation state for this exercise
    final validation = exerciseValidations[index];
    // Border color based on validation
    Color borderColor = const Color(0xFFEFD8FF);
    if (validation != null) {
      borderColor = validation ? Colors.green : Colors.red;
    }

    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: validation != null ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(phrase, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children:
                options.map((option) {
                  // Determine if this option is selected
                  bool isSelected = selectedAnswers[index] == option;
                  // Style based on selection and validation
                  TextStyle style = TextStyle(
                    fontSize: 14,
                    color: getOptionColor(option),
                    decoration: isSelected ? TextDecoration.underline : null,
                    decorationThickness: 2,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  );

                  return GestureDetector(
                    onTap: () {
                      // Only allow selection if not already validated
                      if (exerciseValidations[index] == null && !isCompleted) {
                        setState(() {
                          selectedAnswers[index] = option;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration:
                          isSelected
                              ? BoxDecoration(
                                color: const Color(0xFFEFE3FF).withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(4),
                              )
                              : null,
                      child: Text(option, style: style),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  // Get color for option text based on content
  Color getOptionColor(String option) {
    if (option.contains('tu')) {
      return Colors.red;
    } else if (option.contains('donne') || option.contains('je')) {
      return Colors.purple;
    }
    return Colors.green;
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Check button - validate answers
        Expanded(
          child: ElevatedButton.icon(
            onPressed: !isCompleted ? _validateAnswers : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDeep,
              disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 18,
            ),
            label: const Text(
              "Vérifier",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Reset button - reset the exercise
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _resetExercise,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
            label: const Text(
              "Réessayer",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointsIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD6F4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCompleted
                ? "Félicitations! $points points gagnés"
                : "Obtenez 5 points",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFFF725E),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isCompleted)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(
                Icons.emoji_events,
                color: Color(0xFFFF725E),
                size: 16,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationFooter(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Color(0xffFC715A),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to previous content
                    _navigateToPreviousContent();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_back_ios, color: Colors.black, size: 15),
                      Text(
                        "Contenu précédent",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigate to next content
                    _navigateToNextContent();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
    );
  }

  // Function to validate user answers
  void _validateAnswers() {
    // Check if any answers are missing
    if (selectedAnswers.contains(null)) {
      _showFeedbackSnackBar("Complète toutes les phrases avant de vérifier");
      return;
    }

    // Calculate total correct answers
    int correctAnswers = 0;
    List<bool> validations = [];

    // Check each answer
    for (int i = 0; i < exercises.length; i++) {
      bool isCorrect = selectedAnswers[i] == exercises[i].correctAnswer;
      validations.add(isCorrect);
      if (isCorrect) correctAnswers++;
    }

    // Update state with validations
    setState(() {
      exerciseValidations = validations;

      // Calculate points (only if not already completed)
      if (!isCompleted) {
        if (correctAnswers == exercises.length) {
          // All correct - full points
          points = 5;
          isCompleted = true;
          _showFeedbackSnackBar("Bravo! Toutes les réponses sont correctes!");
        } else if (attemptsLeft > 0) {
          // Some incorrect, but attempts left
          attemptsLeft--;
          _showFeedbackSnackBar(
            "Essaye encore! Il te reste $attemptsLeft tentative${attemptsLeft > 1 ? 's' : ''}.",
          );
        } else {
          // No attempts left
          points = correctAnswers;
          isCompleted = true;
          _showFeedbackSnackBar(
            "Exercice terminé! Tu as obtenu $points point${points > 1 ? 's' : ''}.",
          );
        }
      }
    });
  }

  // Function to reset the exercise
  void _resetExercise() {
    setState(() {
      _resetArrays();
      attemptsLeft = 2;
      isCompleted = false;
      points = 0;
    });
    _showFeedbackSnackBar("Exercice réinitialisé");
  }

  // Navigate to previous content
  void _navigateToPreviousContent() {
    final currentIndex = contentList.indexOf(selectedContent);
    if (currentIndex > 0) {
      setState(() {
        selectedContent = contentList[currentIndex - 1];
        _resetArrays();
        isCompleted = false;
        attemptsLeft = 2;
        points = 0;
      });
      _showFeedbackSnackBar(
        "Navigation au contenu précédent: $selectedContent",
      );
    } else {
      _showFeedbackSnackBar("Vous êtes déjà au premier contenu");
    }
  }

  // Navigate to next content
  void _navigateToNextContent() {
    final currentIndex = contentList.indexOf(selectedContent);
    if (currentIndex < contentList.length - 1) {
      setState(() {
        selectedContent = contentList[currentIndex + 1];
        _resetArrays();
        isCompleted = false;
        attemptsLeft = 2;
        points = 0;
      });
      _showFeedbackSnackBar(
        "Navigation au contenu suivant: $selectedContent",
      );
    } else {
      _showFeedbackSnackBar("Vous êtes déjà au dernier contenu");
    }
  }

  // Show feedback to the user
  void _showFeedbackSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primaryDeep,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// Class to store exercise data
class ExerciseItem {
  final String phrase;
  final List<String> options;
  final String correctAnswer;

  ExerciseItem({
    required this.phrase,
    required this.options,
    required this.correctAnswer,
  });
}

// Custom dropdown button implementation
class CustomDropdownButton extends StatefulWidget {
  final List<String> optionsList;
  final Function(String)? onOptionSelected;
  final String? initialValue;

  const CustomDropdownButton({
    super.key,
    required this.optionsList,
    this.onOptionSelected,
    this.initialValue, required List<String> options,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption =
        widget.initialValue ??
        (widget.optionsList.isNotEmpty ? widget.optionsList[0] : "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF9281FF),
        borderRadius: BorderRadius.circular(40),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedOption,
          dropdownColor: AppColors.primaryDeep,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 12),
          isExpanded: true,
          underline: Container(),
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                selectedOption = newValue;
              });
              if (widget.onOptionSelected != null) {
                widget.onOptionSelected!(newValue);
              }
            }
          },
          items:
              widget.optionsList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }
}
