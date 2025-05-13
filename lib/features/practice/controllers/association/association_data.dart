//* Exercises list for dropdown
import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/practice/models/color_combination_item.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/features/practice/models/color_identification_item.dart';
import 'package:kids_learning_app/features/practice/models/counting_exercise_item.dart';
import 'package:kids_learning_app/features/practice/models/counting_item.dart';
import 'package:kids_learning_app/features/practice/models/matching_item.dart';
import 'package:kids_learning_app/features/practice/models/rainbow_colors_item.dart';
import 'package:kids_learning_app/features/practice/models/size_comparison_item.dart';

final List<String> exercisesList = [
  "Serie 1 - la bonne couleur",
  "Serie 1 - les animaux",
  "Serie 1 - les fruits",
  "Serie 2 - grand et petit 1",
  "Serie 2 - grand et petit 2",
  "Serie 2 - grand et petit 3",
  "Serie 2 - grand et petit 4",
  "Serie 2 - grand et petit 5",
  "Serie 2 - grand et petit 6",
  "Serie 2 - grand et petit 7",
  "Serie 2 - grand et petit 8",
  "Serie 3 - Couleurs 1",
  "Serie 3 - Couleurs 2",
  "Serie 3 - Couleurs 3",
  "Serie 3 - Couleurs 4",
  "Serie 3 - Couleurs 5",
  "Serie 4 - Couleurs et Objets 1",
  "Serie 4 - Couleurs et Objets 2",
  "Serie 4 - Couleurs et Objets 3",
  "Serie 4 - Couleurs et Objets 4",
  "Serie 5 - Arc-en-ciel 1",
  // "Serie 5 - Arc-en-ciel 2",
  "Serie 6 - Connecter en Français 1",
  "Serie 6 - Connecter en Français 2",
  "Serie 6 - Connecter en Français 3",
  "Serie 7 - Compter les objets 1",
  "Serie 7 - Compter les objets 2",
  "Serie 7 - Compter les objets 3",
  "Serie 8 - Compter les objets 1",
  "Serie 8 - Compter les objets 2",
  "Serie 8 - Compter les objets 3",
  "Serie 8 - Compter les objets 4",
  "Serie 8 - Compter les objets 5",
  "Serie 8 - Compter les objets 6",
  "Serie 8 - Compter les objets 7",
  "Serie 8 - Compter les objets 8",
  "Serie 8 - Compter les objets 9",
  "Serie 8 - Compter les objets 10",
];

//* Exercise data map
final Map<String, dynamic> allExercises = {
  "Serie 1 - la bonne couleur": [
    AssociationItem(
      instruction: "Choisis la bonne couleur telle que tu la vois sur l'image.",
      imagePath: "assets/images/exercises/mittens_red.png",
      options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
      correctAnswer: "Rouge",
    ),
    AssociationItem(
      instruction: "Choisis la bonne couleur telle que tu la vois sur l'image.",
      imagePath: "assets/images/exercises/banana.png",
      options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
      correctAnswer: "Jaune",
    ),
    AssociationItem(
      instruction: "Choisis la bonne couleur telle que tu la vois sur l'image.",
      imagePath: "assets/images/exercises/apple.png",
      options: ["Vert", "Rouge", "Jaune", "Bleu", "Violet", "Rose"],
      correctAnswer: "Rouge",
    ),
  ],
  "Serie 1 - les animaux": [
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
  "Serie 1 - les fruits": [
    // Fixed key name from "Exercice 3 - les fruits"
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

  //  SERIES 2 EXERCISES
  "Serie 2 - grand et petit 1": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Hippopotames",
        category: "Animaux sauvages",
        imagePath: "assets/images/exercises/size/hippo.png",
        sizeOptions: [
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 2": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Vélos",
        category: "Véhicules",
        imagePath: "assets/images/exercises/size/bicycle.png",
        sizeOptions: [
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 3": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Cerfs",
        category: "Animaux sauvages",
        imagePath: "assets/images/exercises/size/deer.png",
        sizeOptions: [
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 4": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Marteaux",
        category: "Outils",
        imagePath: "assets/images/exercises/size/hammer.png",
        sizeOptions: [
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 5": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Chiens",
        category: "Animaux domestiques",
        imagePath: "assets/images/exercises/size/dog.png",
        sizeOptions: [
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 6": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Lunettes",
        category: "Accessoires",
        imagePath: "assets/images/exercises/size/glasses.png",
        sizeOptions: [
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 7": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Pandas",
        category: "Animaux sauvages",
        imagePath: "assets/images/exercises/size/panda.png",
        sizeOptions: [
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
        ],
      ),
    ),
  ],
  "Serie 2 - grand et petit 8": [
    SizeComparisonItem(
      instruction: "Sélectionne l'image la plus grande.",
      itemGroup: ItemGroup(
        groupName: "Stylos",
        category: "Fournitures scolaires",
        imagePath: "assets/images/exercises/size/pen.png",
        sizeOptions: [
          SizeOption(size: "grand", label: "Grand", scale: 1.0),
          SizeOption(size: "moyen", label: "Moyen", scale: 0.7),
          SizeOption(size: "petit", label: "Petit", scale: 0.5),
        ],
      ),
    ),
  ],

  // Add Series 3 exercises
  "Serie 3 - Couleurs 1": [
    ColorCombinationItem(
      firstColor: "Rouge",
      secondColor: "Bleu",
      resultColor: "Violet",
      firstColorHex: Colors.red,
      secondColorHex: Colors.blue,
      resultColorHex: Colors.purple,
    ),
  ],
  "Serie 3 - Couleurs 2": [
    ColorCombinationItem(
      firstColor: "Bleu",
      secondColor: "Jaune",
      resultColor: "Vert",
      firstColorHex: Colors.blue,
      secondColorHex: Colors.yellow,
      resultColorHex: Colors.green,
    ),
  ],
  "Serie 3 - Couleurs 3": [
    ColorCombinationItem(
      firstColor: "Jaune",
      secondColor: "Rouge",
      resultColor: "Orange",
      firstColorHex: Colors.yellow,
      secondColorHex: Colors.red,
      resultColorHex: Colors.orange,
    ),
  ],
  "Serie 3 - Couleurs 4": [
    ColorCombinationItem(
      firstColor: "Blanc",
      secondColor: "Rouge",
      resultColor: "Rose",
      firstColorHex: Colors.white,
      secondColorHex: Colors.red,
      resultColorHex: Color(0xFFFF69B4), // Pink
    ),
  ],
  "Serie 3 - Couleurs 5": [
    ColorCombinationItem(
      firstColor: "Noir",
      secondColor: "Blanc",
      resultColor: "Gris",
      firstColorHex: Colors.black,
      secondColorHex: Colors.white,
      resultColorHex: Colors.grey,
    ),
  ],

  // Series 4 - Color Identification Exercises
  "Serie 4 - Couleurs et Objets 1": [
    ColorIdentificationItem(
      targetColor: "Jaune",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_jar.png",
          colorName: "Jaune",
          objectName: "bocal jaune",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/blue_elephant.png",
          colorName: "Bleu",
          objectName: "éléphant bleu",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/grey_koala.png",
          colorName: "Gris",
          objectName: "koala gris",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_mug.png",
          colorName: "Rouge",
          objectName: "tasse rouge",
        ),
      ],
      correctIndex: 0, // Yellow jar
    ),
    ColorIdentificationItem(
      targetColor: "Rose",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_leaf.png",
          colorName: "Jaune",
          objectName: "feuille jaune",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_mug.png",
          colorName: "Rouge",
          objectName: "tasse rouge",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/green_mug.png",
          colorName: "Vert",
          objectName: "tasse verte",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/pink_butterfly.png",
          colorName: "Rose",
          objectName: "papillon rose",
        ),
      ],
      correctIndex: 3, // Pink butterfly
    ),
  ],
  "Serie 4 - Couleurs et Objets 2": [
    ColorIdentificationItem(
      targetColor: "Vert",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_leaf.png",
          colorName: "Jaune",
          objectName: "feuille jaune",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_mug.png",
          colorName: "Rouge",
          objectName: "tasse rouge",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/green_mug.png",
          colorName: "Vert",
          objectName: "tasse verte",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/pink_butterfly.png",
          colorName: "Rose",
          objectName: "papillon rose",
        ),
      ],
      correctIndex: 2, // Green mug
    ),
    ColorIdentificationItem(
      targetColor: "Marron",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/brown_book.png",
          colorName: "Marron",
          objectName: "livre marron",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/green_cactus.png",
          colorName: "Vert",
          objectName: "cactus vert",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_cherries.png",
          colorName: "Rouge",
          objectName: "cerises rouges",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/penguin.png",
          colorName: "Noir",
          objectName: "penguin",
        ),
      ],
      correctIndex: 0, // Brown book
    ),
  ],
  "Serie 4 - Couleurs et Objets 3": [
    ColorIdentificationItem(
      targetColor: "Bleu",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_jar.png",
          colorName: "Jaune",
          objectName: "bocal jaune",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/blue_elephant.png",
          colorName: "Bleu",
          objectName: "éléphant bleu",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/grey_koala.png",
          colorName: "Gris",
          objectName: "koala gris",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_giraffe.png",
          colorName: "Jaune",
          objectName: "girafe jaune",
        ),
      ],
      correctIndex: 1, // Blue elephant
    ),
    ColorIdentificationItem(
      targetColor: "Gris",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_jar.png",
          colorName: "Jaune",
          objectName: "bocal jaune",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/blue_elephant.png",
          colorName: "Bleu",
          objectName: "éléphant bleu",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/gray_koala.png",
          colorName: "Gris",
          objectName: "koala gris",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/yellow_giraffe.png",
          colorName: "Jaune",
          objectName: "girafe jaune",
        ),
      ],
      correctIndex: 2, // Gray koala
    ),
  ],
  "Serie 4 - Couleurs et Objets 4": [
    ColorIdentificationItem(
      targetColor: "Vert",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/brown_book.png",
          colorName: "Marron",
          objectName: "livre marron",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/green_cactus.png",
          colorName: "Vert",
          objectName: "cactus vert",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_cherries.png",
          colorName: "Rouge",
          objectName: "cerises rouges",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/penguin.png",
          colorName: "Noir",
          objectName: "penguin",
        ),
      ],
      correctIndex: 1, // Green cactus
    ),
    ColorIdentificationItem(
      targetColor: "Rouge",
      images: [
        ColorImage(
          imagePath: "assets/images/exercises/colors/brown_book.png",
          colorName: "Marron",
          objectName: "livre marron",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/green_cactus.png",
          colorName: "Vert",
          objectName: "cactus vert",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/red_cherries.png",
          colorName: "Rouge",
          objectName: "cerises rouges",
        ),
        ColorImage(
          imagePath: "assets/images/exercises/colors/penguin.png",
          colorName: "Noir",
          objectName: "penguin",
        ),
      ],
      correctIndex: 2, // Red cherries
    ),
  ],

  // Series 5 - Rainbow Colors
  "Serie 5 - Arc-en-ciel 1": [
    RainbowColorsItem(
      instruction:
          "Clique sur chaque ligne de l'arc-en-ciel et choisis sa couleur",
      bands: [
        RainbowBand(name: "Rouge", color: Colors.red, text: "Rouge"),
        RainbowBand(name: "Orange", color: Colors.orange, text: "Orange"),
        RainbowBand(name: "Jaune", color: Colors.yellow, text: "Jaune"),
        RainbowBand(name: "Vert", color: Colors.green, text: "Vert"),
        RainbowBand(name: "Bleu", color: Colors.blue, text: "Bleu"),
        RainbowBand(
          name: "Indigo",
          color: const Color(0xFF4B0082),
          text: "Indigo",
        ),
        RainbowBand(name: "Violet", color: Colors.purple, text: "Violet"),
      ],
      colorOptions: [
        "Rouge",
        "Orange",
        "Jaune",
        "Vert",
        "Bleu",
        "Indigo",
        "Violet",
      ],
    ),
  ],

  "Serie 6 - Connecter en Français 1": [
    MatchingItem(
      title: "Animaux (Animals)",
      instruction: "Trace une ligne pour relier les animaux identiques.",
      pairs: [
        MatchPair(
          id: "giraffe",
          leftLabel: "Giraffe",
          rightLabel: "Girafe",
          leftImagePath: "assets/images/exercises/colors/yellow_giraffe.png",
          rightImagePath: "assets/images/exercises/colors/yellow_giraffe.png",
        ),
        MatchPair(
          id: "lion",
          leftLabel: "Lion",
          rightLabel: "Lion",
          leftImagePath: "assets/images/exercises/lion.png",
          rightImagePath: "assets/images/exercises/lion.png",
        ),
        // todo: rabbit
        MatchPair(
          id: "rabbit",
          leftLabel: "Rabbit",
          rightLabel: "Lapin",
          leftImagePath: "assets/images/exercises/matching/rabbit_en.png",
          rightImagePath: "assets/images/exercises/matching/rabbit_fr.png",
        ),
      ],
    ),
  ],
  "Serie 6 - Connecter en Français 2": [
    MatchingItem(
      title: "Plus d'Animaux (More Animals)",
      instruction: "Relie chaque animal avec sa traduction.",
      pairs: [
        MatchPair(
          id: "bear",
          leftLabel: "Bear",
          rightLabel: "Ours",
          leftImagePath: "assets/images/exercises/bear.png",
          rightImagePath: "assets/images/exercises/bear.png",
        ),
        MatchPair(
          id: "elephant",
          leftLabel: "Elephant",
          rightLabel: "Éléphant",
          leftImagePath: "assets/images/exercises/matching/elephant_en.png",
          rightImagePath: "assets/images/exercises/matching/elephant_fr.png",
        ),
        MatchPair(
          id: "cat",
          leftLabel: "Cat",
          rightLabel: "Chat",
          leftImagePath: "assets/images/exercises/matching/cat_en.png",
          rightImagePath: "assets/images/exercises/matching/cat_fr.png",
        ),
      ],
    ),
  ],
  "Serie 6 - Connecter en Français 3": [
    MatchingItem(
      title: "Connecter les Moitiés (Connect the Halves)",
      instruction: "Relie chaque moitié avec sa traduction.",
      pairs: [
        MatchPair(
          id: "butterfly",
          leftLabel: "Butterfly",
          rightLabel: "Papillon",
          leftImagePath: "assets/images/exercises/colors/pink_butterfly.png",
          rightImagePath: "assets/images/exercises/colors/pink_butterfly.png",
        ),
        MatchPair(
          id: "leaf",
          leftLabel: "Leaf",
          rightLabel: "Feuille",
          leftImagePath: "assets/images/exercises/colors/yellow_leaf.png",
          rightImagePath: "assets/images/exercises/colors/yellow_leaf.png",
        ),
        MatchPair(
          id: "flower",
          leftLabel: "Flower",
          rightLabel: "Fleur",
          leftImagePath: "assets/images/exercises/flower.png",
          rightImagePath: "assets/images/exercises/flower.png",
        ),
        MatchPair(
          id: "mushroom",
          leftLabel: "Mushroom",
          rightLabel: "Champignon",
          leftImagePath: "assets/images/exercises/mushroom.png",
          rightImagePath: "assets/images/exercises/mushroom.png",
        ),
      ],
    ),
  ],
  
  // Add Series 7 exercises
  "Serie 7 - Compter les objets 1": [
    CountingItem(
      instruction:
          "Directions: Compte les objets ci-dessous et écris le nombre correct.",
      imagePath: "assets/images/exercises/counting/objects_set1.png",
      categories: [
        CountingCategory(
          name: "Cactus",
          iconPath: "assets/images/exercises/colors/green_cactus.png",
          correctCount: 4,
        ),
        CountingCategory(
          name: "Miel",
          iconPath: "assets/images/exercises/honey.png",
          correctCount: 3,
        ),
        CountingCategory(
          name: "Stylo",
          iconPath: "assets/images/exercises/pencil.png",
          correctCount: 2,
        ),
      ],
    ),
  ],
  "Serie 7 - Compter les objets 2": [
    CountingItem(
      instruction: "Compte combien il y a d'objets de chaque type.",
      imagePath: "assets/images/exercises/counting/objects_set2.png",
      categories: [
        CountingCategory(
          name: "Pomme",
          iconPath: "assets/images/exercises/apple.png",
          correctCount: 5,
        ),
        CountingCategory(
          name: "Livre",
          // TODO: add
          iconPath: "assets/images/exercises/colors/brown_book.png",
          correctCount: 3,
        ),
        CountingCategory(
          name: "Étoile",
          iconPath: "assets/images/exercises/star.png",
          correctCount: 6,
        ),
      ],
    ),
  ],
  "Serie 7 - Compter les objets 3": [
    CountingItem(
      instruction: "Combien y a-t-il de chaque animal?",
      imagePath: "assets/images/exercises/counting/objects_set3.png",
      categories: [
        CountingCategory(
          name: "Chat",
          iconPath: "assets/images/exercises/cat.png",
          correctCount: 2,
        ),
        CountingCategory(
          name: "Chien",
          iconPath: "assets/images/exercises/size/dog.png",
          correctCount: 3,
        ),
        CountingCategory(
          name: "Oiseau",
          iconPath: "assets/images/exercises/bird_.png",
          correctCount: 4,
        ),
      ],
    ),
  ],

  "Serie 8 - Compter les objets 1": [
    CountingExerciseItem(
      instruction: "Compte les vélos et entoure le bon nombre.",
      imagePath: "assets/images/exercises/bicycle.png",
      correctCount: 1,
      objectName: "vélos",
      options: [
        CountingOption(text: "SIX", number: 6),
        CountingOption(text: "UN", number: 1),
        CountingOption(text: "NEUF", number: 9),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 2": [
    CountingExerciseItem(
      instruction: "Compte les lions et entoure le bon nombre.",
      imagePath: "assets/images/exercises/lions.png",
      correctCount: 2,
      objectName: "lions",
      options: [
        CountingOption(text: "TROIS", number: 3),
        CountingOption(text: "CINQ", number: 5),
        CountingOption(text: "DEUX", number: 2),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 3": [
    CountingExerciseItem(
      instruction: "Compte les éléphants et entoure le bon nombre.",
      imagePath: "assets/images/exercises/elephants.png",
      correctCount: 3,
      objectName: "éléphants",
      options: [
        CountingOption(text: "DEUX", number: 2),
        CountingOption(text: "TROIS", number: 3),
        CountingOption(text: "CINQ", number: 5),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 4": [
    CountingExerciseItem(
      instruction: "Compte les tasses et entoure le bon nombre.",
      imagePath: "assets/images/exercises/cups.png",
      correctCount: 4,
      objectName: "tasses",
      options: [
        CountingOption(text: "QUATRE", number: 4),
        CountingOption(text: "HUIT", number: 8),
        CountingOption(text: "DEUX", number: 2),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 5": [
    CountingExerciseItem(
      instruction: "Compte les cerises et entoure le bon nombre.",
      imagePath: "assets/images/exercises/colors/red_cherries.png",
      correctCount: 5,
      objectName: "cerises",
      options: [
        CountingOption(text: "SEPT", number: 7),
        CountingOption(text: "CINQ", number: 5),
        CountingOption(text: "QUATRE", number: 4),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 6": [
    CountingExerciseItem(
      instruction: "Compte les pandas et entoure le bon nombre.",
      imagePath: "assets/images/exercises/size/panda.png",
      correctCount: 6,
      objectName: "pandas",
      options: [
        CountingOption(text: "SIX", number: 6),
        CountingOption(text: "UN", number: 1),
        CountingOption(text: "NEUF", number: 9),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 7": [
    CountingExerciseItem(
      instruction: "Compte les chapeaux et entoure le bon nombre.",
      imagePath: "assets/images/exercises/hat.png",
      correctCount: 7,
      objectName: "chapeaux",
      options: [
        CountingOption(text: "SIX", number: 6),
        CountingOption(text: "NEUF", number: 9),
        CountingOption(text: "SEPT", number: 7),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 8": [
    CountingExerciseItem(
      instruction: "Compte les étoiles et entoure le bon nombre.",
      imagePath: "assets/images/exercises/star.png",
      correctCount: 8,
      objectName: "etoiles",
      options: [
        CountingOption(text: "HUIT", number: 8),
        CountingOption(text: "QUATRE", number: 4),
        CountingOption(text: "CINQ", number: 5),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 9": [
    CountingExerciseItem(
      instruction: "Compte les pingouins et entoure le bon nombre.",
      imagePath: "assets/images/exercises/penguin.png",
      correctCount: 9,
      objectName: "pingouins",
      options: [
        CountingOption(text: "HUIT", number: 8),
        CountingOption(text: "NEUF", number: 9),
        CountingOption(text: "SEPT", number: 7),
      ],
    ),
  ],
  "Serie 8 - Compter les objets 10": [
    CountingExerciseItem(
      instruction: "Compte les girafes et entoure le bon nombre.",
      imagePath: "assets/images/exercises/colors/yellow_giraffe.png",
      correctCount: 10,
      objectName: "girafes",
      options: [
        CountingOption(text: "SIX", number: 6),
        CountingOption(text: "DIX", number: 10),
        CountingOption(text: "NEUF", number: 9),
      ],
    ),
  ],
};
