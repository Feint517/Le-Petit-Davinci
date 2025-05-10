class AppariementQuestion {
  final String id;
  final String imagePath;
  final List<String> options;
  final String correctAnswer;
  final int points;
  
  AppariementQuestion({
    required this.id,
    required this.imagePath,
    required this.options,
    required this.correctAnswer,
    required this.points,
  });

  //* Sample questions for demonstration purposes
  static List<AppariementQuestion> getSampleQuestions() {
    return [
      AppariementQuestion(
        id: '1',
        imagePath: 'assets/images/illustrations/shoes.png',
        options: ['bottes', 'baskets', 'escarpins', 'sandales'],
        correctAnswer: 'baskets',
        points: 10,
      ),
      AppariementQuestion(
        id: '2',
        imagePath: 'assets/images/quiz/hat.png',
        options: ['chapeau', 'casquette', 'béret', 'bonnet'],
        correctAnswer: 'chapeau',
        points: 10,
      ),
      AppariementQuestion(
        id: '3',
        imagePath: 'assets/images/quiz/shirt.png',
        options: ['chemise', 't-shirt', 'pull', 'veste'],
        correctAnswer: 'chemise',
        points: 10,
      ),
    ];
  }
}
