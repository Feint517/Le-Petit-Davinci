import 'package:flutter/material.dart';

/// Type de quiz
enum QuizType {
  imageWord,     // Association image-mot
  wordDefinition, // Définition de mot
  sentenceCompletion, // Phrase à compléter
  pronunciation, // Prononciation correcte
  categorySort   // Trier par catégorie
}

/// Niveau de difficulté
enum QuizDifficultySetting {
  facile,
  moyen,
  difficile
}

/// Mode de quiz
enum QuizMode {
  standard,    // Choix multiple classique
  drag,        // Glisser-déposer la réponse
  reorder,     // Réorganiser les éléments
  interactive  // Interaction personnalisée
}

/// Format de réponse
enum AnswerFormat {
  text,        // Texte simple
  image,       // Image
  audio,       // Son
  mixed        // Combinaison de formats
}

/// Modèle principal pour les quiz interactifs
class QuizInteractiveModel {
  final String id;
  final String title;
  final String question;
  final String? audioPath;
  final String? imagePath;
  final String? illustration;
  final QuizType type;
  final List<QuizOptionModel> options;
  final String correctAnswer;
  final String? explanation;
  final String? hint;
  final QuizDifficultySetting difficulty;
  final QuizMode mode;
  final int points;
  final AnswerFormat answerFormat;
  final List<String>? categories; // Pour les quiz de catégories
  final Map<String, dynamic>? metadata; // Données supplémentaires spécifiques au type de quiz
  
  QuizInteractiveModel({
    required this.id,
    required this.title,
    required this.question,
    this.audioPath,
    this.imagePath,
    this.illustration,
    required this.type,
    required this.options,
    required this.correctAnswer,
    this.explanation,
    this.hint,
    required this.difficulty,
    required this.mode,
    required this.points,
    required this.answerFormat,
    this.categories,
    this.metadata,
  });
  
  /// Vérifie si la réponse fournie est correcte
  bool checkAnswer(String selectedAnswer) {
    return selectedAnswer.trim().toLowerCase() == correctAnswer.trim().toLowerCase();
  }
  
  /// Récupère l'explication après réponse
  String getExplanation(bool isCorrect) {
    if (explanation != null) {
      return explanation!;
    }
    
    if (isCorrect) {
      switch (difficulty) {
        case QuizDifficultySetting.facile:
          return "Bravo ! Tu as bien répondu à cette question !";
        case QuizDifficultySetting.moyen:
          return "Excellent ! C'était une question de niveau intermédiaire.";
        case QuizDifficultySetting.difficile:
          return "Impressionnant ! Tu as réussi une question difficile !";
      }
    } else {
      return "La bonne réponse était : $correctAnswer. Continue tes efforts !";
    }
  }
  
  /// Crée un quiz avec mode de glisser-déposer
  static QuizInteractiveModel createDragQuiz(QuizInteractiveModel original) {
    return QuizInteractiveModel(
      id: original.id,
      title: original.title,
      question: original.question,
      audioPath: original.audioPath,
      imagePath: original.imagePath,
      illustration: original.illustration,
      type: original.type,
      options: original.options,
      correctAnswer: original.correctAnswer,
      explanation: original.explanation,
      hint: original.hint,
      difficulty: original.difficulty,
      mode: QuizMode.drag,
      points: original.points,
      answerFormat: original.answerFormat,
      categories: original.categories,
      metadata: original.metadata,
    );
  }
  
  /// Création d'échantillons de quiz pour tester
  static List<QuizInteractiveModel> getSampleQuizzes() {
    return [
      // Niveau facile - Association image-mot
      QuizInteractiveModel(
        id: "quiz_f1",
        title: "Les animaux",
        question: "Quel animal vois-tu sur cette image ?",
        imagePath: "assets/images/illustrations/lion.png",
        type: QuizType.imageWord,
        options: [
          QuizOptionModel(value: "Lion", isCorrect: true),
          QuizOptionModel(value: "Tigre", isCorrect: false),
          QuizOptionModel(value: "Éléphant", isCorrect: false),
        ],
        correctAnswer: "Lion",
        hint: "C'est le roi de la jungle.",
        difficulty: QuizDifficultySetting.facile,
        mode: QuizMode.standard,
        points: 5,
        answerFormat: AnswerFormat.text,
      ),
      
      QuizInteractiveModel(
        id: "quiz_f2",
        title: "Les fruits",
        question: "Quel est ce fruit ?",
        imagePath: "assets/images/exercises/apple.png",
        type: QuizType.imageWord,
        options: [
          QuizOptionModel(value: "Banane", isCorrect: false),
          QuizOptionModel(value: "Pomme", isCorrect: true),
          QuizOptionModel(value: "Orange", isCorrect: false),
        ],
        correctAnswer: "Pomme",
        explanation: "La pomme est un fruit rond et croquant qui pousse sur un pommier.",
        difficulty: QuizDifficultySetting.facile,
        mode: QuizMode.interactive,
        points: 5,
        answerFormat: AnswerFormat.text,
      ),
      
      // Niveau moyen - Complétion de phrase
      QuizInteractiveModel(
        id: "quiz_m1",
        title: "Complète la phrase",
        question: "Le chat _______ sur le canapé.",
        type: QuizType.sentenceCompletion,
        options: [
          QuizOptionModel(value: "mange", isCorrect: false),
          QuizOptionModel(value: "dort", isCorrect: true),
          QuizOptionModel(value: "joue", isCorrect: false),
          QuizOptionModel(value: "saute", isCorrect: false),
        ],
        correctAnswer: "dort",
        hint: "Que fait-on quand on est fatigué ?",
        difficulty: QuizDifficultySetting.moyen,
        mode: QuizMode.drag,
        points: 10,
        answerFormat: AnswerFormat.text,
      ),
      
      // Niveau difficile - Catégorisation
      QuizInteractiveModel(
        id: "quiz_d1",
        title: "Tri par catégories",
        question: "Place chaque mot dans la bonne catégorie.",
        type: QuizType.categorySort,
        options: [
          QuizOptionModel(value: "pomme", category: "Fruits", isCorrect: true),
          QuizOptionModel(value: "carotte", category: "Légumes", isCorrect: true),
          QuizOptionModel(value: "banane", category: "Fruits", isCorrect: true),
          QuizOptionModel(value: "poivron", category: "Légumes", isCorrect: true),
          QuizOptionModel(value: "orange", category: "Fruits", isCorrect: true),
          QuizOptionModel(value: "tomate", category: "Légumes", isCorrect: true),
        ],
        correctAnswer: "ALL_CORRECT",  // Spécial pour catégorisation
        categories: ["Fruits", "Légumes"],
        difficulty: QuizDifficultySetting.difficile,
        mode: QuizMode.reorder,
        points: 15,
        answerFormat: AnswerFormat.mixed,
        metadata: {
          "categoryColors": {
            "Fruits": Colors.orange.value,
            "Légumes": Colors.green.value,
          }
        },
      ),
    ];
  }
}

/// Modèle pour les options de quiz
class QuizOptionModel {
  final String value;
  final bool isCorrect;
  final String? imagePath;
  final String? audioPath;
  final String? category; // Pour les quiz de catégories
  final Map<String, dynamic>? metadata; // Données supplémentaires spécifiques à l'option
  
  QuizOptionModel({
    required this.value,
    required this.isCorrect,
    this.imagePath,
    this.audioPath,
    this.category,
    this.metadata,
  });
}