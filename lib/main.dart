import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(GuessTheNumberGame());
}

class GuessTheNumberGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess The Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuessPage(),
    );
  }
}

class GuessPage extends StatefulWidget {
  @override
  _GuessPageState createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  final _random = Random();
  late int _targetNumber;
  late int _guess;
  late String _message;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _targetNumber = _random.nextInt(100) + 1;
    _guess = 0;
    _message = 'Guess a number between 1 and 100';
    _controller.text = "";
  }

  void _checkGuess() {
    if (_guess == null) return;
    setState(() {
      if (_guess == _targetNumber) {
        _message = 'Congratulations! You guessed the number $_targetNumber!';
      } else if (_guess < _targetNumber) {
        _message = 'Try a higher number';
      } else {
        _message = 'Try a lower number';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess The Number'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _message,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _guess = int.tryParse(value)!;
                });
              },
              onSubmitted: (_) {
                _checkGuess();
              },
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              child: Text('Guess'),
              onPressed: () {
                _checkGuess();
              },
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  _resetGame();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
