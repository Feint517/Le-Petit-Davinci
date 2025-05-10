class DicteeQuestion {
  final String id;
  final String audioPath;
  final String imagePath;
  final List<String> wordBank;
  final List<String> correctAnswer;
  final int points;
  
  DicteeQuestion({
    required this.id,
    required this.audioPath,
    required this.imagePath,
    required this.wordBank,
    required this.correctAnswer,
    required this.points,
  });
  
  //* Sample questions for demonstration purposes
  static List<DicteeQuestion> getSampleQuestions() {
    return [
      DicteeQuestion(
        id: '1',
        audioPath: 'assets/sfx/dictee_sample1.mp3', // Replace with actual audio path
        imagePath: 'assets/images/illustrations/onBoarding_giraffe1.png', // Changed from giraffe.png to an existing image
        wordBank: ['chat', 'joue', 'avec', 'la', 'balle', 'rouge', 'dans', 'jardin'],
        correctAnswer: ['chat', 'joue', 'avec', 'la', 'balle', 'rouge', 'dans', 'jardin'],
        points: 10,
      ),
      DicteeQuestion(
        id: '2',
        audioPath: 'assets/sfx/dictee_sample2.mp3', // Replace with actual audio path
        imagePath: 'assets/images/illustrations/lion.png', // Using the lion image that exists
        wordBank: ['enfant', 'lit', 'un', 'livre', 'sur', 'le', 'canapé', 'bleu'],
        correctAnswer: ['enfant', 'lit', 'un', 'livre', 'sur', 'le', 'canapé', 'bleu'],
        points: 15,
      ),
      DicteeQuestion(
        id: '3',
        audioPath: 'assets/sfx/dictee_sample3.mp3', // Replace with actual audio path
        imagePath: 'assets/images/mascots/owl/happy_owl.png', // This path should be verified
        wordBank: ['chien', 'aboie', 'fort', 'quand', 'il', 'voit', 'facteur', 'arriver'],
        correctAnswer: ['chien', 'aboie', 'fort', 'quand', 'il', 'voit', 'facteur', 'arriver'],
        points: 20,
      ),
    ];
  }
}