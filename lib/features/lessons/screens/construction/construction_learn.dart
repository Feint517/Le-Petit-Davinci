import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/lessons/data/sentence_translation.dart';
import 'package:kids_learning_app/features/lessons/models/english_to_french.dart';

class ConstructionLearn extends StatefulWidget {
  final int day;

  const ConstructionLearn({Key? key, required this.day}) : super(key: key);

  @override
  _ConstructionLearnState createState() => _ConstructionLearnState();
}

class _ConstructionLearnState extends State<ConstructionLearn> {
  late List<EnglishToFrench> _sentences;
  int _currentIndex = 0;
  bool _showFrench = true;

  @override
  void initState() {
    super.initState();
    _sentences = SentencesData.getSentencesByDay(widget.day);
  }

  void _nextSentence() {
    setState(() {
      if (_currentIndex < _sentences.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _previousSentence() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  void _toggleFrench() {
    setState(() {
      _showFrench = !_showFrench;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${widget.day} - Learn'),
        actions: [
          IconButton(
            icon: Icon(_showFrench ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggleFrench,
            tooltip: 'Show/Hide French',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _sentences[_currentIndex].englishSentence,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    AnimatedOpacity(
                      opacity: _showFrench ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        _sentences[_currentIndex].frenchSentence,
                        style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${_currentIndex + 1}/${_sentences.length}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? _previousSentence : null,
                  child: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: _currentIndex < _sentences.length - 1 ? _nextSentence : null,
                  child: Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}