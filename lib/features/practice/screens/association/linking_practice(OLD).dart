import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class AssociationActivitiesScreen extends StatefulWidget {
  const AssociationActivitiesScreen({super.key});

  @override
  State<AssociationActivitiesScreen> createState() =>
      _AssociationActivitiesScreenState();
}

class _AssociationActivitiesScreenState
    extends State<AssociationActivitiesScreen> {
  // Selected exercise
  String selectedExercise = "Exercice 1 - la bonne couleur";

  // Exercises list for dropdown
  final List<String> exercisesList = [
    "Exercice 1 - la bonne couleur",
    "Exercice 2 - les animaux",
    "Exercice 3 - les fruits",
  ];

  //* Association exercise data
  final Map<String, List<AssociationItem>> allExercises = {
    "Exercice 1 - la bonne couleur": [
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/mittens_red.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Rouge",
      ),
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/banana.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Jaune",
      ),
      AssociationItem(
        instruction:
            "Choisis la bonne couleur telle que tu la vois sur l'image.",
        imagePath: "assets/images/exercises/apple.png",
        options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
        correctAnswer: "Rouge",
      ),
    ],
    "Exercice 2 - les animaux": [
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/cat.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Chat",
      ),
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/dog.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Chien",
      ),
      AssociationItem(
        instruction: "Quel animal vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/rabbit.png",
        options: ["Chat", "Chien", "Lapin", "Oiseau", "Poisson", "Souris"],
        correctAnswer: "Lapin",
      ),
    ],
    "Exercice 3 - les fruits": [
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/apple.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Pomme",
      ),
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/banana.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Banane",
      ),
      AssociationItem(
        instruction: "Quel fruit vois-tu sur l'image ?",
        imagePath: "assets/images/exercises/strawberry.png",
        options: ["Pomme", "Banane", "Orange", "Fraise", "Raisin", "Poire"],
        correctAnswer: "Fraise",
      ),
    ],
  };

  //* Current exercise index
  int currentExerciseIndex = 0;

  //* Get current exercise list
  List<AssociationItem> get currentExercises {
    return allExercises[selectedExercise] ?? [];
  }

  //* Get current exercise item
  AssociationItem get currentExercise {
    if (currentExercises.isEmpty) {
      return AssociationItem(
        instruction: "",
        imagePath: "",
        options: [],
        correctAnswer: "",
      );
    }

    // Ensure index is within bounds
    if (currentExerciseIndex >= currentExercises.length) {
      currentExerciseIndex = currentExercises.length - 1;
    }

    return currentExercises[currentExerciseIndex];
  }

  // User's selected answer
  String? selectedAnswer;

  // Whether the answer has been submitted/validated
  bool isAnswerValidated = false;

  // Points and completion tracking
  int points = 0;
  bool isExerciseCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            children: [
              ProfileHeader(activeIcon: false),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Exercise dropdown
                        _buildExerciseDropdown(),

                        //* Main exercise content
                        _buildExerciseContent(),

                        //* Control buttons
                        _buildControlButtons(),

                        // Points indicator
                        _buildPointsIndicator(),

                        // Description section
                        _buildDescription(),

                        // Navigation footer
                        _buildNavigationFooter(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF9078F6), // Purple color from your design
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedExercise,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 24,
          elevation: 16,
          dropdownColor: Color(0xFF9078F6),
          style: const TextStyle(color: Colors.white),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedExercise = newValue;
                currentExerciseIndex = 0;
                resetExercise();
              });
            }
          },
          items:
              exercisesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(value, style: TextStyle(fontSize: 14)),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildExerciseContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Instruction text
          Text(
            currentExercise.instruction,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),

          // Image
          Center(
            child: SizedBox(
              height: 160,
              width: 160,
              child: Image.asset(
                currentExercise.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback image if asset doesn't exist
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(Icons.image_not_supported, size: 50),
                    ),
                  );
                },
              ),
            ),
          ),
          const Gap(20),

          //* Options grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemCount: currentExercise.options.length,
            itemBuilder: (context, index) {
              final option = currentExercise.options[index];

              // Determine button color and style based on option
              Color buttonColor = _getColorForOption(option);
              bool isSelected = selectedAnswer == option;
              bool isCorrect =
                  isAnswerValidated && option == currentExercise.correctAnswer;
              bool isIncorrect =
                  isAnswerValidated &&
                  isSelected &&
                  option != currentExercise.correctAnswer;

              // Add border when selected or validated
              BoxBorder? border;
              if (isCorrect) {
                border = Border.all(color: Colors.green, width: 2);
              } else if (isIncorrect) {
                border = Border.all(color: Colors.red, width: 2);
              } else if (isSelected) {
                border = Border.all(color: Colors.blue, width: 2);
              }

              return GestureDetector(
                onTap: () {
                  //* Only allow selection if not already validated
                  if (!isAnswerValidated) {
                    setState(() {
                      selectedAnswer = option;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(30),
                    border: border,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Get color for option button
  Color _getColorForOption(String option) {
    switch (option.toLowerCase()) {
      case "vert":
        return Colors.green;
      case "rouge":
        return Colors.red;
      case "jaune":
        return Colors.amber;
      case "bleu":
        return Colors.blue[800] ?? Colors.blue;
      case "violet":
        return Colors.purple;
      case "rose":
        return Colors.pink;
      case "chat":
      case "chien":
      case "lapin":
      case "oiseau":
      case "poisson":
      case "souris":
        return Colors.blueGrey;
      case "pomme":
      case "banane":
      case "orange":
      case "fraise":
      case "raisin":
      case "poire":
        return Colors.teal;
      default:
        // Default color for other options
        return Colors.grey;
    }
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // Retry button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: isAnswerValidated ? resetExercise : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA593F5),
                disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              icon: Icon(Icons.refresh, size: 18),
              label: Text("Réessayer", style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(width: 16),

          // Check/Next button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (!isAnswerValidated) {
                  // Validate the answer
                  validateAnswer();
                } else {
                  // Move to next exercise
                  nextExercise();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF22B07D),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              icon: Icon(
                isAnswerValidated ? Icons.arrow_forward : Icons.check,
                size: 18,
              ),
              label: Text(
                isAnswerValidated ? "Passer" : "Vérifier",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFFD6F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isExerciseCompleted
            ? "Félicitations! $points points gagnés"
            : "Obtenez 5 points",
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFFFF725E),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Perfectionne ton écriture et ta lecture",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            "La lecture et l'écriture sont essentielles pour maîtriser la langue française. Cet exercice interactif t'aide à enrichir ton vocabulaire et à améliorer ta compréhension des phrases.",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationFooter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFFF6F5E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous exercise button
          TextButton.icon(
            onPressed: () => navigateToPreviousExercise(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 12),
            label: Text(
              "Exercice précédent",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),

          // Next exercise button
          TextButton.icon(
            onPressed: () => navigateToNextExercise(),
            label: Text(
              "Exercice suivant",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 12),
          ),
        ],
      ),
    );
  }

  // Validate the current answer
  void validateAnswer() {
    if (selectedAnswer == null) {
      _showFeedbackSnackBar("Sélectionne une réponse avant de vérifier");
      return;
    }

    setState(() {
      isAnswerValidated = true;

      // Check if the answer is correct
      if (selectedAnswer == currentExercise.correctAnswer) {
        points += 5;
        _showFeedbackSnackBar("Bravo! C'est la bonne réponse!");
      } else {
        _showFeedbackSnackBar("Ce n'est pas la bonne réponse. Essaie encore!");
      }
    });
  }

  // Reset the current exercise
  void resetExercise() {
    setState(() {
      selectedAnswer = null;
      isAnswerValidated = false;
    });
  }

  // Move to the next exercise item
  void nextExercise() {
    if (currentExerciseIndex < currentExercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        resetExercise();
      });
    } else {
      // Completed all exercises in this set
      setState(() {
        isExerciseCompleted = true;
      });
      _showFeedbackSnackBar("Félicitations! Tu as terminé cet exercice!");
    }
  }

  // Navigate to the previous exercise set
  void navigateToPreviousExercise() {
    final currentIndex = exercisesList.indexOf(selectedExercise);
    if (currentIndex > 0) {
      setState(() {
        selectedExercise = exercisesList[currentIndex - 1];
        currentExerciseIndex = 0;
        resetExercise();
      });
      _showFeedbackSnackBar("Navigation à l'exercice précédent");
    } else {
      _showFeedbackSnackBar("Vous êtes déjà au premier exercice");
    }
  }

  // Navigate to the next exercise set
  void navigateToNextExercise() {
    final currentIndex = exercisesList.indexOf(selectedExercise);
    if (currentIndex < exercisesList.length - 1) {
      setState(() {
        selectedExercise = exercisesList[currentIndex + 1];
        currentExerciseIndex = 0;
        resetExercise();
      });
      _showFeedbackSnackBar("Navigation à l'exercice suivant");
    } else {
      _showFeedbackSnackBar("Vous êtes déjà au dernier exercice");
    }
  }

  // Show feedback snackbar
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

// Class to store association exercise data
