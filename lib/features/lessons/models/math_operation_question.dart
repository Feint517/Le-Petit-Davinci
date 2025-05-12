import 'package:flutter/material.dart';

enum OperationType {
  addition,
  subtraction,
}

class MathOperationQuestion {
  final String id;
  final String question;
  final OperationType operationType;
  final int firstNumber;
  final int secondNumber;
  final int correctAnswer;
  final List<int> options;
  final int points;
  final String? explanation;
  final String? imagePath;

  MathOperationQuestion({
    required this.id,
    required this.question,
    required this.operationType,
    required this.firstNumber,
    required this.secondNumber,
    required this.correctAnswer,
    required this.options,
    this.points = 10,
    this.explanation,
    this.imagePath,
  });

  // Factory method to create sample questions
  static List<MathOperationQuestion> getSampleQuestions() {
    return [
      // Addition questions
      MathOperationQuestion(
        id: 'a1',
        question: 'Combien font 2 + 3 ?',
        operationType: OperationType.addition,
        firstNumber: 2,
        secondNumber: 3,
        correctAnswer: 5,
        options: [4, 5, 6, 7],
        explanation: '2 + 3 = 5',
      ),
      MathOperationQuestion(
        id: 'a2',
        question: 'Combien font 1 + 4 ?',
        operationType: OperationType.addition,
        firstNumber: 1,
        secondNumber: 4,
        correctAnswer: 5,
        options: [3, 4, 5, 6],
        explanation: '1 + 4 = 5',
      ),
      MathOperationQuestion(
        id: 'a3',
        question: 'Combien font 3 + 2 ?',
        operationType: OperationType.addition,
        firstNumber: 3,
        secondNumber: 2,
        correctAnswer: 5,
        options: [4, 5, 6, 7],
        explanation: '3 + 2 = 5',
      ),
      // Subtraction questions
      MathOperationQuestion(
        id: 's1',
        question: 'Combien font 5 - 2 ?',
        operationType: OperationType.subtraction,
        firstNumber: 5,
        secondNumber: 2,
        correctAnswer: 3,
        options: [2, 3, 4, 5],
        explanation: '5 - 2 = 3',
      ),
      MathOperationQuestion(
        id: 's2',
        question: 'Combien font 6 - 3 ?',
        operationType: OperationType.subtraction,
        firstNumber: 6,
        secondNumber: 3,
        correctAnswer: 3,
        options: [2, 3, 4, 5],
        explanation: '6 - 3 = 3',
      ),
      MathOperationQuestion(
        id: 's3',
        question: 'Combien font 4 - 1 ?',
        operationType: OperationType.subtraction,
        firstNumber: 4,
        secondNumber: 1,
        correctAnswer: 3,
        options: [1, 2, 3, 4],
        explanation: '4 - 1 = 3',
      ),
    ];
  }
}