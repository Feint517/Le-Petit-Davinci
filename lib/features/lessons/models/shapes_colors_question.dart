class ShapesColorsQuestion {
  final String id;
  final String question;
  final String imagePath;
  final String correctAnswer;
  final List<String> options;
  final int points;
  final String? explanation;
  final QuestionType type;

  ShapesColorsQuestion({
    required this.id,
    required this.question,
    required this.imagePath,
    required this.correctAnswer,
    required this.options,
    required this.type,
    this.points = 10,
    this.explanation,
  });

  // Factory method to create sample questions
  static List<ShapesColorsQuestion> getSampleQuestions() {
    return [
      // Shape identification questions
      ShapesColorsQuestion(
        id: 'shape1',
        question: 'Quelle forme vois-tu?',
        imagePath: 'assets/images/exercises/shapes/circle.png',
        correctAnswer: 'Cercle',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.shapeIdentification,
        explanation: 'Cette forme est un cercle. Un cercle est une forme ronde parfaite.',
      ),
      ShapesColorsQuestion(
        id: 'shape2',
        question: 'Quelle forme vois-tu?',
        imagePath: 'assets/images/exercises/shapes/square.png',
        correctAnswer: 'Carré',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.shapeIdentification,
        explanation: 'Cette forme est un carré. Un carré a 4 côtés égaux et 4 angles droits.',
      ),
      ShapesColorsQuestion(
        id: 'shape3',
        question: 'Quelle forme vois-tu?',
        imagePath: 'assets/images/exercises/shapes/triangle.png',
        correctAnswer: 'Triangle',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.shapeIdentification,
        explanation: 'Cette forme est un triangle. Un triangle a 3 côtés et 3 angles.',
      ),
      ShapesColorsQuestion(
        id: 'shape4',
        question: 'Quelle forme vois-tu?',
        imagePath: 'assets/images/exercises/shapes/rectangle.png',
        correctAnswer: 'Rectangle',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.shapeIdentification,
        explanation: 'Cette forme est un rectangle. Un rectangle a 4 côtés et 4 angles droits, avec des côtés opposés de même longueur.',
      ),
      
      // Color identification questions
      ShapesColorsQuestion(
        id: 'color1',
        question: 'De quelle couleur est cette forme?',
        imagePath: 'assets/images/exercises/colors/red_circle.png',
        correctAnswer: 'Rouge',
        options: ['Rouge', 'Bleu', 'Vert', 'Jaune'],
        type: QuestionType.colorIdentification,
        explanation: 'La couleur de cette forme est rouge.',
      ),
      ShapesColorsQuestion(
        id: 'color2',
        question: 'De quelle couleur est cette forme?',
        imagePath: 'assets/images/exercises/colors/blue_square.png',
        correctAnswer: 'Bleu',
        options: ['Rouge', 'Bleu', 'Vert', 'Jaune'],
        type: QuestionType.colorIdentification,
        explanation: 'La couleur de cette forme est bleue.',
      ),
      ShapesColorsQuestion(
        id: 'color3',
        question: 'De quelle couleur est cette forme?',
        imagePath: 'assets/images/exercises/colors/green_triangle.png',
        correctAnswer: 'Vert',
        options: ['Rouge', 'Bleu', 'Vert', 'Jaune'],
        type: QuestionType.colorIdentification,
        explanation: 'La couleur de cette forme est verte.',
      ),
      ShapesColorsQuestion(
        id: 'color4',
        question: 'De quelle couleur est cette forme?',
        imagePath: 'assets/images/exercises/colors/yellow_rectangle.png',
        correctAnswer: 'Jaune',
        options: ['Rouge', 'Bleu', 'Vert', 'Jaune'],
        type: QuestionType.colorIdentification,
        explanation: 'La couleur de cette forme est jaune.',
      ),
      
      // Combined questions (shape and color)
      ShapesColorsQuestion(
        id: 'combined1',
        question: 'Quelle est la forme rouge?',
        imagePath: 'assets/images/exercises/shapes_colors/multiple_shapes.png',
        correctAnswer: 'Cercle',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.combinedQuestion,
        explanation: 'Le cercle est la forme rouge dans cette image.',
      ),
      ShapesColorsQuestion(
        id: 'combined2',
        question: 'Quelle forme est bleue?',
        imagePath: 'assets/images/exercises/shapes_colors/multiple_shapes.png',
        correctAnswer: 'Carré',
        options: ['Cercle', 'Carré', 'Triangle', 'Rectangle'],
        type: QuestionType.combinedQuestion,
        explanation: 'Le carré est la forme bleue dans cette image.',
      ),
    ];
  }
}

enum QuestionType {
  shapeIdentification,
  colorIdentification,
  combinedQuestion,
}