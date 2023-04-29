import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> gameStatus = List.filled(9, '');
  String player = 'X';
  bool _isThereWinner = false;
  String winner = '';
  int rightColor = 0xff0066ff;
  String x_status = "Your Turn X";
  String o_status = "";
  String draw = 'DRAW';

  List<List<int>> conditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  void ResetGame() {
    setState(() {
      gameStatus = List.filled(9, '');
      player = 'X';
      x_status = "Your Turn X";
      o_status = "";
    });
  }

  void Check() {
    for (int index = 0; index < conditions.length; index++) {
      if (gameStatus[conditions[index][0]] == '' ||
          gameStatus[conditions[index][1]] == '' ||
          gameStatus[conditions[index][2]] == '') {
        continue;
      }

      if ((gameStatus[conditions[index][0]] ==
              gameStatus[conditions[index][1]]) &&
          (gameStatus[conditions[index][0]] ==
              gameStatus[conditions[index][2]])) {
        setState(() {
          _isThereWinner = true;
          winner = gameStatus[conditions[index][0]];
          if (winner == 'X') {
            x_status = 'X wins';
            o_status = '';
          } else if (winner == 'O') {
            o_status = 'O wins';
            x_status = '';
          }
        });
        break;
      }
    }

    // check the draw

    if (!_isThereWinner) {
      int emptySpace = 9;

      for (int idx = 0; idx < gameStatus.length; idx++) {
        if (gameStatus[idx] == '') {
          emptySpace--;
        }
      }

      if (emptySpace == 0) {
        setState(() {
          o_status = x_status = draw;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.jpg"), fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  "Tic Tac Toe",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 110,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      x_status,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      o_status,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (gameStatus[index] == '') {
                        gameStatus[index] = player;

                        if (player == 'X') {
                          player = 'O';
                          x_status = "";
                          o_status = "Your Turn $player";
                        } else {
                          player = 'X';
                          x_status = "Your Turn $player";
                          o_status = "";
                        }
                      }
                    });

                    Check();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        gameStatus[index],
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                );
              },
            ),
            OutlinedButton(
              onPressed: () {
                ResetGame();
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(20),
                ),
              ),
              child: Text(
                "Reset the game",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
