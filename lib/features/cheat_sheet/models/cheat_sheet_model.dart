import 'package:flutter/material.dart';

class CheatSheetCategory {
  final String name;
  final Color color;
  final IconData icon;
  
  CheatSheetCategory({
    required this.name,
    required this.color,
    required this.icon,
  });
}

class CheatSheetCardModel {
  final String title;
  final Color color;
  final IconData icon;
  final Color alternateRowColor;
  final List<String> columns;
  final List<List<String>> rows;
  final String category;
  
  CheatSheetCardModel({
    required this.title,
    required this.color,
    required this.icon,
    required this.columns,
    required this.rows,
    required this.alternateRowColor,
    required this.category,
  });
}

class CheatSheetData {
  // French categories
  static final List<CheatSheetCategory> frenchCategories = [
    CheatSheetCategory(name: 'Alphabet', color: Colors.blue[300]!, icon: Icons.abc),
    CheatSheetCategory(name: 'Mois', color: Colors.red[300]!, icon: Icons.calendar_month),
    CheatSheetCategory(name: 'Jours', color: Colors.pink[300]!, icon: Icons.calendar_today),
    CheatSheetCategory(name: 'Heurs', color: Colors.amber[400]!, icon: Icons.access_time),
    CheatSheetCategory(name: 'Date', color: Colors.green[300]!, icon: Icons.date_range),
  ];
  
  // Math categories
  static final List<CheatSheetCategory> mathCategories = [
    CheatSheetCategory(name: 'Addition', color: Colors.purple[300]!, icon: Icons.add),
    CheatSheetCategory(name: 'Soustraction', color: Colors.orange[300]!, icon: Icons.remove),
    CheatSheetCategory(name: 'Multiplication', color: Colors.teal[300]!, icon: Icons.close),
    CheatSheetCategory(name: 'Division', color: Colors.indigo[300]!, icon: Icons.architecture),
    CheatSheetCategory(name: 'Fractions', color: Colors.deepOrange[300]!, icon: Icons.pie_chart),
  ];
  
  // French cheat sheets
  static final List<CheatSheetCardModel> frenchCheatSheets = [
    // Alphabet French
    CheatSheetCardModel(
      title: 'Alphabet Français',
      color: Colors.blue[300]!,
      icon: Icons.abc,
      columns: const ['', '', ''],
      rows: const [
        ['A', 'B', 'C'],
        ['D', 'E', 'F'],
        ['G', 'H', 'I'],
        ['J', 'K', 'L'],
        ['M', 'N', 'O'],
        ['P', 'Q', 'R'],
        ['S', 'T', 'U'],
        ['V', 'W', 'X'],
        ['Y', 'Z', ''],
      ],
      alternateRowColor: Colors.blue[100]!,
      category: 'Alphabet',
    ),
    
    // Months
    CheatSheetCardModel(
      title: 'Mois',
      color: Colors.red[300]!,
      icon: Icons.calendar_month,
      columns: const ['English', 'Français'],
      rows: const [
        ['January', 'Janvier'],
        ['February', 'Février'],
        ['March', 'Mars'],
        ['April', 'Avril'],
        ['May', 'Mai'],
        ['June', 'Juin'],
        ['July', 'Juillet'],
        ['August', 'Août'],
        ['September', 'Septembre'],
        ['October', 'Octobre'],
        ['November', 'Novembre'],
        ['December', 'Décembre'],
      ],
      alternateRowColor: Colors.red[100]!,
      category: 'Mois',
    ),
    
    // Days & Weeks
    CheatSheetCardModel(
      title: 'Jours et Semaines',
      color: Colors.pink[300]!,
      icon: Icons.calendar_today,
      columns: const ['English', 'Français'],
      rows: const [
        ['Today', 'Aujourd\'hui'],
        ['Tomorrow', 'Demain'],
        ['Yesterday', 'Hier'],
        ['Day Before Yesterday', 'Avant-hier'],
        ['Day After Tomorrow', 'Après-demain'],
        ['This Week', 'Cette semaine'],
        ['Last Week', 'La semaine dernière'],
        ['Next Week', 'La semaine prochaine'],
        ['Weekday', 'Jour de la semaine'],
        ['Weekend', 'Fin de semaine'],
      ],
      alternateRowColor: Colors.pink[100]!,
      category: 'Jours',
    ),
    
    // Time of Day
    CheatSheetCardModel(
      title: 'Moments de la Journée',
      color: Colors.amber[400]!,
      icon: Icons.access_time,
      columns: const ['English', 'Français'],
      rows: const [
        ['Morning', 'Matin'],
        ['Afternoon', 'Après-midi'],
        ['Evening', 'Soir'],
        ['Night', 'Nuit'],
        ['Mid-night', 'Minuit'],
        ['Late', 'Tard'],
        ['Early', 'Tôt'],
        ['Later', 'Plus tard'],
        ['Dusk', 'Crépuscule'],
        ['Dawn', 'Aube'],
        ['Hour', 'Heure'],
        ['Minutes', 'Minutes'],
        ['Seconds', 'Secondes'],
      ],
      alternateRowColor: Colors.amber[100]!,
      category: 'Heurs',
    ),
    
    // Date
    CheatSheetCardModel(
      title: 'Date',
      color: Colors.green[300]!,
      icon: Icons.date_range,
      columns: const ['English', 'Français'],
      rows: const [
        ['1st', 'Premier'],
        ['2nd', 'Deuxième'],
        ['3rd', 'Troisième'],
        ['4th', 'Quatrième'],
        ['5th', 'Cinquième'],
        ['6th', 'Sixième'],
        ['7th', 'Septième'],
        ['8th', 'Huitième'],
        ['9th', 'Neuvième'],
        ['10th', 'Dixième'],
        ['20th', 'Vingtième'],
        ['30th', 'Trentième'],
      ],
      alternateRowColor: Colors.green[100]!,
      category: 'Date',
    ),
  ];
  
  // Math cheat sheets
  static final List<CheatSheetCardModel> mathCheatSheets = [
    // Addition Table
    CheatSheetCardModel(
      title: 'Table d\'Addition',
      color: Colors.purple[300]!,
      icon: Icons.add,
      columns: const ['', '1', '2', '3', '4', '5'],
      rows: const [
        ['1', '2', '3', '4', '5', '6'],
        ['2', '3', '4', '5', '6', '7'],
        ['3', '4', '5', '6', '7', '8'],
        ['4', '5', '6', '7', '8', '9'],
        ['5', '6', '7', '8', '9', '10'],
      ],
      alternateRowColor: Colors.purple[100]!,
      category: 'Addition',
    ),
    
    // Addition Properties
    CheatSheetCardModel(
      title: 'Propriétés d\'Addition',
      color: Colors.purple[300]!,
      icon: Icons.add,
      columns: const ['Propriété', 'Exemple'],
      rows: const [
        ['Commutativité', 'a + b = b + a'],
        ['Associativité', '(a + b) + c = a + (b + c)'],
        ['Élément neutre', 'a + 0 = a'],
        ['Opposé', 'a + (-a) = 0'],
      ],
      alternateRowColor: Colors.purple[100]!,
      category: 'Addition',
    ),
    
    // Subtraction Table
    CheatSheetCardModel(
      title: 'Table de Soustraction',
      color: Colors.orange[300]!,
      icon: Icons.remove,
      columns: const ['', '1', '2', '3', '4', '5'],
      rows: const [
        ['5', '4', '3', '2', '1', '0'],
        ['6', '5', '4', '3', '2', '1'],
        ['7', '6', '5', '4', '3', '2'],
        ['8', '7', '6', '5', '4', '3'],
        ['9', '8', '7', '6', '5', '4'],
      ],
      alternateRowColor: Colors.orange[100]!,
      category: 'Soustraction',
    ),
    
    // Multiplication Table
    CheatSheetCardModel(
      title: 'Table de Multiplication',
      color: Colors.teal[300]!,
      icon: Icons.close,
      columns: const ['×', '1', '2', '3', '4', '5'],
      rows: const [
        ['1', '1', '2', '3', '4', '5'],
        ['2', '2', '4', '6', '8', '10'],
        ['3', '3', '6', '9', '12', '15'],
        ['4', '4', '8', '12', '16', '20'],
        ['5', '5', '10', '15', '20', '25'],
      ],
      alternateRowColor: Colors.teal[100]!,
      category: 'Multiplication',
    ),
    
    // Multiplication Properties
    CheatSheetCardModel(
      title: 'Propriétés de Multiplication',
      color: Colors.teal[300]!,
      icon: Icons.close,
      columns: const ['Propriété', 'Exemple'],
      rows: const [
        ['Commutativité', 'a × b = b × a'],
        ['Associativité', '(a × b) × c = a × (b × c)'],
        ['Distributivité', 'a × (b + c) = a × b + a × c'],
        ['Élément neutre', 'a × 1 = a'],
        ['Élément absorbant', 'a × 0 = 0'],
      ],
      alternateRowColor: Colors.teal[100]!,
      category: 'Multiplication',
    ),
    
    // Division Basics
    CheatSheetCardModel(
      title: 'Bases de Division',
      color: Colors.indigo[300]!,
      icon: Icons.architecture,
      columns: const ['Division', 'Résultat'],
      rows: const [
        ['10 ÷ 2', '5'],
        ['15 ÷ 3', '5'],
        ['20 ÷ 4', '5'],
        ['25 ÷ 5', '5'],
        ['30 ÷ 6', '5'],
        ['35 ÷ 7', '5'],
        ['40 ÷ 8', '5'],
        ['45 ÷ 9', '5'],
      ],
      alternateRowColor: Colors.indigo[100]!,
      category: 'Division',
    ),
    
    // Fractions
    CheatSheetCardModel(
      title: 'Fractions Simples',
      color: Colors.deepOrange[300]!,
      icon: Icons.pie_chart,
      columns: const ['Fraction', 'Décimal', 'Pourcentage'],
      rows: const [
        ['1/2', '0.5', '50%'],
        ['1/3', '0.33', '33.3%'],
        ['1/4', '0.25', '25%'],
        ['1/5', '0.2', '20%'],
        ['1/10', '0.1', '10%'],
      ],
      alternateRowColor: Colors.deepOrange[100]!,
      category: 'Fractions',
    ),
  ];
}