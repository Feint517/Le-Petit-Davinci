//* Exercises list for dropdown
import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/practice/models/color_combination_item.dart';
import 'package:kids_learning_app/features/practice/models/association_item.dart';
import 'package:kids_learning_app/features/practice/models/color_identification_item.dart';
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
          imagePath: "assets/images/exercises/colors/green_dotted_mug.png",
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
};
