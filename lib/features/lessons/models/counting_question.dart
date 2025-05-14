
class CountingQuestion {
  final String id;
  final String question;
  final String imagePath;
  final int correctAnswer;
  final List<int> options;
  final int points;
  final String? explanation;

  CountingQuestion({
    required this.id,
    required this.question,
    required this.imagePath,
    required this.correctAnswer,
    required this.options,
    this.points = 10,
    this.explanation,
  });

  // Factory method to create sample questions
  static List<CountingQuestion> getSampleQuestions() {
    return [
      CountingQuestion(
        id: 'q1',
        question: 'Combien de pommes vois-tu?',
        imagePath: 'assets/images/exercises/apple.png',
        correctAnswer: 1,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 1 pomme sur l\'image.',
      ),
      CountingQuestion(
        id: 'q2',
        question: 'Combien d\'éléphants vois-tu?',
        imagePath: 'assets/images/exercises/elephant.png',
        correctAnswer: 1,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 1 éléphant sur l\'image.',
      ),
      CountingQuestion(
        id: 'q3',
        question: 'Combien de fleurs vois-tu?',
        imagePath: 'assets/images/exercises/flower.png',
        correctAnswer: 1,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 1 fleur sur l\'image.',
      ),
      CountingQuestion(
        id: 'q4',
        question: 'Combien de lapins vois-tu?',
        imagePath: 'assets/images/exercises/rabbit.png',
        correctAnswer: 1,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 1 lapin sur l\'image.',
      ),
      CountingQuestion(
        id: 'q5',
        question: 'Combien d\'ours vois-tu?',
        imagePath: 'assets/images/exercises/bear.png',
        correctAnswer: 1,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 1 ours sur l\'image.',
      ),
    ];
  }
}