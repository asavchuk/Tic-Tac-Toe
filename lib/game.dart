import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'icon_logic.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int player1Score = 0;
  int player2Score = 0;
  int draw = 0;

  List<List<String>> pos = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  // current player
  String player = "player1";

  String player1;
  String player2;
  String player3;
  String player4;
  String player5;
  String player6;
  String player7;
  String player8;
  String player9;

  IconLogic iconLogic = IconLogic();

  void _resetCells() {
    pos = [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];
  }

  void _reset1() {
    setState(() {
      _resetCells();
      player1Score += 1;
    });
  }

  void _reset2() {
    setState(() {
      _resetCells();
      player2Score += 1;
    });
  }

  void _reset3() {
    setState(() {
      _resetCells();
      draw += 1;
    });
  }

  bool _isWon(String player) {
    if ((pos[0][0] == player && pos[0][1] == player && pos[0][2] == player) ||
        (pos[1][0] == player && pos[1][1] == player && pos[1][2] == player) ||
        (pos[2][0] == player && pos[2][1] == player && pos[2][2] == player) ||
        (pos[0][0] == player && pos[1][1] == player && pos[2][2] == player) ||
        (pos[0][2] == player && pos[1][1] == player && pos[2][0] == player) ||
        (pos[0][0] == player && pos[1][0] == player && pos[2][0] == player) ||
        (pos[0][1] == player && pos[1][1] == player && pos[2][1] == player) ||
        (pos[0][2] == player && pos[1][2] == player && pos[2][2] == player)) {
      return true;
    }
    return false;
  }

  // if all the cells checked
  bool _checkCells() {
    for (int i = 0; i < pos.length; i++) {
      for (int j = 0; j < pos.length; j++) {
        if (pos[i][j] == null) {
          return false;
        }
      }
    }
    return true;
  }

  void _check() {
    if (_isWon(player)) {
      if (player == "player1") {
        _gameFinishAlert('Player 1 won');
        _reset1();
        return;
      } else {
        _gameFinishAlert('Player 2 won');
        _reset2();
        return;
      }
    }

    if (_checkCells()) {
      _gameFinishAlert('No winner');
      _reset3();
    }
  }

  void _gameFinishAlert(String message) {
    Alert(
      context: context,
      closeFunction: () {},
      type: message != 'No winner' ? AlertType.success : AlertType.info,
      title: "Game finished",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void _switchPlayer() {
    player == "player1" ? player = "player2" : player = "player1";
  }

  @override
  Widget build(BuildContext context) {
    double verticalSpace = MediaQuery.of(context).size.height / 42;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(
                        MaterialCommunityIcons.circle_outline,
                        color: Color(0xFF39BCD4),
                        size: 42,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Text("$player1Score Wins"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        MaterialCommunityIcons.window_close,
                        size: 50,
                        color: Color(0xFF3989D4),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 0),
                      child: Text("$player2Score Wins"),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Octicons.law,
                        size: 42,
                        color: Color(0xFFAAAAAA),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7),
                      child: Text("$draw Draw"),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: verticalSpace,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: pos[0][0].isEmpty
                            ? null
                            : iconLogic.choice(player1),
                      ),
                      onTap: () {
                        if (pos[0][0].isNotEmpty) return;
                        setState(() {
                          player1 = player;
                          pos[0][0] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: pos[0][1].isEmpty
                            ? null
                            : iconLogic.choice(player2),
                      ),
                      onTap: () {
                        if (pos[0][1].isNotEmpty) return;
                        setState(() {
                          player2 = player;
                          pos[0][1] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: pos[0][2].isEmpty
                            ? null
                            : iconLogic.choice(player3),
                      ),
                      onTap: () {
                        if (pos[0][2].isNotEmpty) return;
                        setState(() {
                          player3 = player;
                          pos[0][2] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: pos[1][0].isEmpty
                            ? null
                            : iconLogic.choice(player4),
                      ),
                      onTap: () {
                        if (pos[1][0].isNotEmpty) return;
                        setState(() {
                          player4 = player;
                          pos[1][0] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: pos[1][1].isEmpty
                            ? null
                            : iconLogic.choice(player5),
                      ),
                      onTap: () {
                        if (pos[1][1].isNotEmpty) return;
                        setState(() {
                          player5 = player;
                          pos[1][1] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: pos[1][2].isEmpty
                            ? null
                            : iconLogic.choice(player6),
                      ),
                      onTap: () {
                        if (pos[1][2].isNotEmpty) return;
                        setState(() {
                          player6 = player;
                          pos[1][2] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: pos[2][0].isEmpty
                            ? null
                            : iconLogic.choice(player7),
                      ),
                      onTap: () {
                        if (pos[2][0].isNotEmpty) return;
                        setState(() {
                          player7 = player;
                          pos[2][0] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: pos[2][1].isEmpty
                            ? null
                            : iconLogic.choice(player8),
                      ),
                      onTap: () {
                        if (pos[2][1] != null) return;
                        setState(() {
                          player8 = player;
                          pos[2][1] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: pos[2][2].isEmpty
                            ? null
                            : iconLogic.choice(player9),
                      ),
                      onTap: () {
                        if (pos[2][2].isNotEmpty) return;
                        setState(() {
                          player9 = player;
                          pos[2][2] = player;
                          _check();
                          _switchPlayer();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: verticalSpace,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(80),
                    ),
                    color: Color(0xFFAAAAAA),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _resetCells();
                        player = 'player1';
                        player1Score = 0;
                        player2Score = 0;
                        draw = 0;
                        pos = [
                          [null, null, null],
                          [null, null, null],
                          [null, null, null],
                        ];
                      });
                    },
                    color: Colors.white,
                    iconSize: 20,
                    icon: Icon(
                      Icons.refresh,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, left: 25),
                  height: 50,
                  child: Text(
                    'Next move: $player',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
