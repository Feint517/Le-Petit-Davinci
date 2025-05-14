import 'package:flutter/material.dart';

/// Type de dictée
enum DicteeType {
  phrasesSimples,
  motsBasiques,
  phrasesMoyennes,
  phrasesComplexes
}

/// Niveau de difficulté
enum DifficultySetting {
  facile,
  moyen,
  difficile
}

/// Mode de dictée
enum DicteeMode {
  standard,  // L'utilisateur compose la phrase entière
  trous,     // Certains mots sont déjà placés, l'utilisateur remplit les trous
  guidee     // Des indices supplémentaires sont fournis
}

/// Modèle principal pour les dictées interactives
class DicteeInteractiveModel {
  final String id;
  final String title;
  final String audioPath;
  final String? imagePath;
  final String? illustration;
  final DicteeType type;
  final List<String> correctWords;
  final List<String> wordBank;
  final List<String> distractors;
  final String? hint;
  final DifficultySetting difficulty;
  final DicteeMode mode;
  final int points;
  final List<DicteeWord> wordsList;
  
  /// Phrase complète (pour la vocalisation et la vérification)
  final String fullPhrase;
  
  DicteeInteractiveModel({
    required this.id,
    required this.title,
    required this.audioPath,
    this.imagePath,
    this.illustration,
    required this.type,
    required this.correctWords,
    List<String>? wordBank,
    List<String>? distractors,
    this.hint,
    required this.difficulty,
    required this.mode,
    required this.points,
    required this.fullPhrase,
    List<DicteeWord>? wordsList,
  }) : 
    wordBank = wordBank ?? correctWords,
    distractors = distractors ?? [],
    wordsList = wordsList ?? [];
  
  /// Vérifie si la réponse fournie est correcte
  bool checkAnswer(List<String> selectedWords) {
    if (selectedWords.length != correctWords.length) {
      return false;
    }
    
    for (int i = 0; i < selectedWords.length; i++) {
      if (selectedWords[i].trim().toLowerCase() != 
          correctWords[i].trim().toLowerCase()) {
        return false;
      }
    }
    
    return true;
  }
  
  /// Vérifie si le début de la phrase est correct
  bool isStartCorrect(List<String> selectedWords) {
    final endIdx = selectedWords.length < correctWords.length ? 
        selectedWords.length : correctWords.length;
    
    for (int i = 0; i < endIdx; i++) {
      if (selectedWords[i].trim().toLowerCase() != 
          correctWords[i].trim().toLowerCase()) {
        return false;
      }
    }
    
    return true;
  }
  
  /// Calcule la précision de la réponse en pourcentage
  double calculateAccuracy(List<String> selectedWords) {
    if (selectedWords.isEmpty) return 0;
    
    int correctCount = 0;
    final endIdx = selectedWords.length < correctWords.length ? 
        selectedWords.length : correctWords.length;
    
    for (int i = 0; i < endIdx; i++) {
      if (selectedWords[i].trim().toLowerCase() == 
          correctWords[i].trim().toLowerCase()) {
        correctCount++;
      }
    }
    
    return correctCount / correctWords.length * 100;
  }
  
  /// Donne un indice sur la position du mot suivant
  String getNextWordHint(List<String> currentWords) {
    if (currentWords.length >= correctWords.length) {
      return "La phrase est complète!";
    }
    
    final nextWordIndex = currentWords.length;
    final nextWord = correctWords[nextWordIndex];
    
    // Donne un indice différent selon la difficulté
    switch (difficulty) {
      case DifficultySetting.facile:
        return "Le mot suivant est \"$nextWord\".";
      case DifficultySetting.moyen:
        return "Le mot suivant commence par \"${nextWord[0]}\".";
      case DifficultySetting.difficile:
        return "Le mot suivant a ${nextWord.length} lettres.";
    }
  }
  
  /// Crée une dictée en mode trous (avec certains mots déjà placés)
  static DicteeInteractiveModel createGapFillDictee(DicteeInteractiveModel original) {
    // Remplace environ 40% des mots par des trous
    final List<DicteeWord> newWordsList = [];
    final List<String> newCorrectWords = List.from(original.correctWords);
    
    for (int i = 0; i < original.correctWords.length; i++) {
      // Détermine si ce mot sera un trou (mais jamais le premier mot)
      bool isGap = i > 0 && i % 3 == 0;
      
      newWordsList.add(DicteeWord(
        text: original.correctWords[i],
        isGap: isGap,
      ));
    }
    
    return DicteeInteractiveModel(
      id: original.id,
      title: "Complétez: ${original.title}",
      audioPath: original.audioPath,
      imagePath: original.imagePath,
      illustration: original.illustration,
      type: original.type,
      correctWords: newCorrectWords,
      wordBank: original.wordBank,
      distractors: original.distractors,
      hint: original.hint,
      difficulty: original.difficulty,
      mode: DicteeMode.trous,
      points: original.points,
      fullPhrase: original.fullPhrase,
      wordsList: newWordsList,
    );
  }
  
  /// Crée une liste de dictées pour différents niveaux
  static List<DicteeInteractiveModel> getSampleDictees() {
    return [
      // Niveau facile - Phrases simples
      DicteeInteractiveModel(
        id: "dictee_f1",
        title: "Les animaux de la ferme",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/illustrations/onBoarding_giraffe1.png",
        type: DicteeType.phrasesSimples,
        correctWords: ["Le", "chat", "joue", "avec", "une", "balle", "rouge"],
        wordBank: ["Le", "chat", "joue", "avec", "une", "balle", "rouge", "souris", "bleu", "petit", "mange"],
        hint: "Cette phrase parle d'un animal qui s'amuse.",
        difficulty: DifficultySetting.facile,
        mode: DicteeMode.standard,
        points: 5,
        fullPhrase: "Le chat joue avec une balle rouge.",
      ),

      DicteeInteractiveModel(
        id: "dictee_f2",
        title: "La journée d'école",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/mascots/owl/happy_owl.png",
        type: DicteeType.phrasesSimples,
        correctWords: ["Ma", "soeur", "va", "à", "l'école", "tous", "les", "jours"],
        wordBank: ["Ma", "soeur", "va", "à", "l'école", "tous", "les", "jours", "frère", "maison", "parfois", "matin"],
        hint: "Cette phrase parle de quelqu'un qui va à l'école.",
        difficulty: DifficultySetting.facile,
        mode: DicteeMode.standard,
        points: 8,
        fullPhrase: "Ma soeur va à l'école tous les jours.",
      ),

      // Niveau moyen
      DicteeInteractiveModel(
        id: "dictee_m1",
        title: "La forêt enchantée",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/illustrations/lion.png",
        type: DicteeType.phrasesMoyennes,
        correctWords: ["Les", "oiseaux", "chantent", "dans", "les", "grands", "arbres", "verts"],
        wordBank: ["Les", "oiseaux", "chantent", "dans", "les", "grands", "arbres", "verts", "petits", "bleus", "volent", "noirs", "forêt"],
        hint: "Cette phrase parle d'animaux qui font de la musique.",
        difficulty: DifficultySetting.moyen,
        mode: DicteeMode.standard,
        points: 10,
        fullPhrase: "Les oiseaux chantent dans les grands arbres verts.",
      ),

      DicteeInteractiveModel(
        id: "dictee_m2",
        title: "Le voyage imaginaire",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/illustrations/onBoarding_giraffe2.png",
        type: DicteeType.phrasesMoyennes,
        correctWords: ["Nous", "avons", "visité", "un", "château", "magique", "pendant", "les", "vacances"],
        wordBank: ["Nous", "avons", "visité", "un", "château", "magique", "pendant", "les", "vacances", "grand", "beau", "après", "avant", "maison"],
        hint: "Cette phrase parle d'un lieu féerique qu'on a vu.",
        difficulty: DifficultySetting.moyen,
        mode: DicteeMode.standard,
        points: 12,
        fullPhrase: "Nous avons visité un château magique pendant les vacances.",
      ),

      // Niveau difficile
      DicteeInteractiveModel(
        id: "dictee_d1",
        title: "L'aventure sportive",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/illustrations/sorry.png",
        type: DicteeType.phrasesComplexes,
        correctWords: ["Les", "enfants", "courageux", "ont", "escaladé", "la", "montagne", "malgré", "la", "pluie"],
        wordBank: ["Les", "enfants", "courageux", "ont", "escaladé", "la", "montagne", "malgré", "la", "pluie", "neige", "vent", "dangereux", "rapidement", "lentement", "facilement"],
        hint: "Cette phrase parle d'une activité physique difficile.",
        difficulty: DifficultySetting.difficile,
        mode: DicteeMode.standard,
        points: 15,
        fullPhrase: "Les enfants courageux ont escaladé la montagne malgré la pluie.",
      ),

      DicteeInteractiveModel(
        id: "dictee_d2",
        title: "La grande exploration",
        audioPath: "assets/sfx/winner.mp3", // Son plaisant et clair
        imagePath: "assets/images/illustrations/onBoarding_giraffe3.png",
        type: DicteeType.phrasesComplexes,
        correctWords: ["Le", "scientifique", "a", "découvert", "une", "nouvelle", "espèce", "d'insecte", "dans", "la", "forêt", "tropicale"],
        wordBank: ["Le", "scientifique", "a", "découvert", "une", "nouvelle", "espèce", "d'insecte", "dans", "la", "forêt", "tropicale", "plante", "animale", "savant", "chercheur", "jungle", "grande"],
        hint: "Cette phrase parle d'une trouvaille importante.",
        difficulty: DifficultySetting.difficile,
        mode: DicteeMode.standard,
        points: 20,
        fullPhrase: "Le scientifique a découvert une nouvelle espèce d'insecte dans la forêt tropicale.",
      ),
    ];
  }
}

/// Représente un mot individuel dans une dictée avec des propriétés supplémentaires
class DicteeWord {
  final String text;
  final bool isGap;
  final bool isPreplaced;
  final Color? backgroundColor;
  
  DicteeWord({
    required this.text,
    this.isGap = false,
    this.isPreplaced = false,
    this.backgroundColor,
  });
}