import 'package:flutter_svg/flutter_svg.dart';

class QuizQuestion {
  final String id;
  final String question;
  final String imagePath;
  final List<String> options;
  final String correctAnswer;
  final int points;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.imagePath,
    required this.options,
    required this.correctAnswer,
    required this.points,
  });

  // Sample questions for demonstration purposes
  static List<QuizQuestion> getSampleQuestions() {
    return [
      QuizQuestion(
        id: '1',
        question: 'Devinez le mot correspondant à cette image !',
        imagePath: 'assets/svgs/avion.svg', // Path to the airplane SVG image
        options: ['Avion', 'Dauphin', 'Lampe'],
        correctAnswer: 'Avion',
        points: 10,
      ),
      QuizQuestion(
        id: '2',
        question: 'Quel animal est représenté sur cette image ?',
        imagePath: 'assets/images/illustrations/lion.png', // Path to a lion image
        options: ['Éléphant', 'Lion', 'Tigre'],
        correctAnswer: 'Lion',
        points: 10,
      ),
      QuizQuestion(
        id: '3',
        question: 'Quel est cet objet ?',
        imagePath: 'assets/images/quiz/lampe.png', // Path to a lamp image
        options: ['Télévision', 'Radio', 'Lampe'],
        correctAnswer: 'Lampe',
        points: 10,
      ),
      QuizQuestion(
        id: '4',
        question: 'Quel fruit est montré ici ?',
        imagePath: 'assets/images/quiz/pomme.png', // Path to an apple image
        options: ['Banane', 'Pomme', 'Orange'],
        correctAnswer: 'Pomme',
        points: 10,
      ),
      QuizQuestion(
        id: '5',
        question: 'Cet animal vit dans l\'eau. Quel est son nom ?',
        imagePath: 'assets/images/quiz/dauphin.png', // Path to a dolphin image
        options: ['Dauphin', 'Baleine', 'Requin'],
        correctAnswer: 'Dauphin',
        points: 10,
      ),
    ];
  }
}
