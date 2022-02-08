import 'dart:math';

import 'package:flutter/material.dart';
import 'dialog.dart';
import 'game.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Game> buttonsList;
  var player1;
  var player2;
  var playeractive;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<Game> doInit() {
    player1 = [];
    player2 = [];
    playeractive = 1;
    var gamebuttom = <Game>[
      Game(id: 1),
      Game(id: 2),
      Game(id: 3),
      Game(id: 4),
      Game(id: 5),
      Game(id: 6),
      Game(id: 7),
      Game(id: 8),
      Game(id: 9),
    ];
    return gamebuttom;
  }

  void playGame(Game cha) {
    setState(() {
      if (playeractive == 1) {
        cha.text = "X";
        cha.col = Colors.red;
        playeractive = 2;
        player1.add(cha.id);
      } else {
        cha.text = "0";
        cha.col = Colors.black;
        playeractive = 1;
        player2.add(cha.id);
      }
      cha.enabled = false;
      int winner = checkwinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => DialogeShow(
                  "Game tied", resetGame, "Press Reset for start again game"));
        } else {
          playeractive == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = [];
    var list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }
    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkwinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => DialogeShow("Player 1 Winner", resetGame,
                "Press Reset for start ner game"));
      } else {
        showDialog(
            context: context,
            builder: (_) => DialogeShow("Player 2 Winner", resetGame,
                "Press Reset for start ner game"));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9),
              itemCount: buttonsList.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100,
                height: 100,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8),
                  onPressed: buttonsList[i].enabled
                      ? () => playGame(buttonsList[i])
                      : null,
                  child: Text(
                    buttonsList[i].text,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: buttonsList[i].col,
                  disabledColor: buttonsList[i].col,
                ),
              ),
            ),
          ),
          RaisedButton(
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
            color: Colors.red,
            padding: EdgeInsets.all(20),
            onPressed: resetGame,
          ),
        ],
      ),
    );
  }
}
