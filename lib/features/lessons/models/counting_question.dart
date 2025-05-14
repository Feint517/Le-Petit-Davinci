
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
        correctAnswer: 3,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 3 pommes sur l\'image.',
      ),
      CountingQuestion(
        id: 'q2',
        question: 'Combien d\'éléphants vois-tu?',
        imagePath: 'assets/images/exercises/elephant.png',
        correctAnswer: 2,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 2 éléphants sur l\'image.',
      ),
      CountingQuestion(
        id: 'q3',
        question: 'Combien de fleurs vois-tu?',
        imagePath: 'assets/images/exercises/flower.png',
        correctAnswer: 4,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 4 fleurs sur l\'image.',
      ),
      CountingQuestion(
        id: 'q4',
        question: 'Combien de lapins vois-tu?',
        imagePath: 'assets/images/exercises/rabbit.png',
        correctAnswer: 3,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 3 lapins sur l\'image.',
      ),
      CountingQuestion(
        id: 'q5',
        question: 'Combien d\'ours vois-tu?',
        imagePath: 'assets/images/exercises/bear.png',
        correctAnswer: 2,
        options: [1, 2, 3, 4],
        explanation: 'Il y a 2 ours sur l\'image.',
      ),
    ];
  }
}