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
      debugShowCheckedModeBanner: false,
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
  late int attempt;
  double score = 0;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    _targetNumber = _random.nextInt(100) + 1;
    _guess = 0;
    _message = '';
    _controller.text = "";
    attempt = 0;
  }

  void _checkGuess() {
    if (_guess == null) return;
    setState(() {
      if (_guess == _targetNumber) {
        score = 10;
        _message = 'Congratulations! You guessed the number $_targetNumber!';
        score = score - attempt;
      } else if (_guess < _targetNumber) {
        attempt++;
        _message = 'Try a higher number';
      } else {
        attempt++;
        _message = 'Try a lower number';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 250, 247, 1),
        elevation: 0,
        title: const Text(
          'Guess The Number',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "I'm thinking of a number between 1  and 100...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              cursorColor: const Color.fromRGBO(253, 225, 180, 1),
              decoration: InputDecoration(
                  suffixIconColor: const Color.fromRGBO(156, 128, 74, 1),
                  suffixIcon: Icon(_message == 'Try a higher number'
                      ? Icons.keyboard_arrow_up
                      : _message == "Try a lower number"
                          ? Icons.keyboard_arrow_down
                          : _message == ""
                              ? Icons.question_mark
                              : Icons.check),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(245, 240, 232, 1),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(245, 240, 232, 1),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(245, 240, 232, 1),
                    ),
                  ),
                  fillColor: const Color.fromRGBO(245, 240, 232, 1),
                  filled: true),
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _guess = int.parse(value);
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _resetGame();
                      });
                    },
                    elevation: 0,
                    height: 45,
                    hoverElevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: const Color.fromRGBO(245, 240, 232, 1),
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: MaterialButton(
                    hoverElevation: 0,
                    onPressed: () {
                      _checkGuess();
                    },
                    height: 45,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: const Color.fromRGBO(242, 163, 13, 1),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.leaderboard_outlined),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 240, 232, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text("Attempts : $attempt"),
                  flex: 7,
                  fit: FlexFit.loose,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _message,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              "A game by vectorcrop.com",
              style: TextStyle(
                  fontSize: 10.0, color: Color.fromRGBO(156, 128, 74, 1)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(20.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         _message,
      //         style: TextStyle(fontSize: 20.0),
      //         textAlign: TextAlign.center,
      //       ),
      //       TextField(
      //         controller: _controller,
      //         keyboardType: TextInputType.number,
      //         onChanged: (value) {
      //           setState(() {
      //             _guess = int.tryParse(value)!;
      //           });
      //         },
      //         onSubmitted: (_) {
      //           _checkGuess();
      //         },
      //       ),
      //       SizedBox(height: 20.0),
      //       MaterialButton(
      //         child: Text('Guess'),
      //         onPressed: () {
      //           _checkGuess();
      //         },
      //       ),
      //       SizedBox(height: 20.0),
      //       MaterialButton(
      //         child: Text('Reset'),
      //         onPressed: () {
      //           setState(() {
      //             _resetGame();
      //           });
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
