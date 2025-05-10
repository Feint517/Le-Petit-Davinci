import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/lessons/data/sentence_translation.dart';
import 'package:kids_learning_app/features/lessons/models/english_to_french.dart'; 

class ExercisePage extends StatefulWidget {
  final int day;

  const ExercisePage({Key? key, required this.day}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late List<EnglishToFrench> _sentences;
  int _currentIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  bool _showResult = false;
  bool _isCorrect = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _sentences = SentencesData.getSentencesByDay(widget.day);
    // Optional: shuffle sentences for more challenge
    // _sentences.shuffle();
  }

  void _checkAnswer() {
    setState(() {
      _showResult = true;
      // Simple comparison - you might want to improve this
      _isCorrect = _answerController.text.trim().toLowerCase() == 
                  _sentences[_currentIndex].frenchSentence.toLowerCase();
      
      if (_isCorrect) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _sentences.length - 1) {
        _currentIndex++;
        _answerController.clear();
        _showResult = false;
      } else {
        // Show final score or navigate to results page
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Exercise Complete!'),
        content: Text('Your score: $_score/${_sentences.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Return to previous screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day} - Exercise'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Score: $_score/${_sentences.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Translate to French:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              _sentences[_currentIndex].englishSentence,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Your Translation',
                border: OutlineInputBorder(),
                suffixIcon: _showResult
                    ? Icon(
                        _isCorrect ? Icons.check_circle : Icons.cancel,
                        color: _isCorrect ? Colors.green : Colors.red,
                      )
                    : null,
              ),
              enabled: !_showResult,
              onSubmitted: (_) => _checkAnswer(),
            ),
            SizedBox(height: 20),
            if (_showResult)
              Text(
                _isCorrect 
                    ? 'Correct!' 
                    : 'Not quite. The correct answer is: ${_sentences[_currentIndex].frenchSentence}',
                style: TextStyle(
                  color: _isCorrect ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!_showResult)
                  ElevatedButton(
                    onPressed: _checkAnswer,
                    child: Text('Check Answer'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text(_currentIndex < _sentences.length - 1 
                        ? 'Next Question' 
                        : 'Finish'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Question ${_currentIndex + 1} of ${_sentences.length}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
}