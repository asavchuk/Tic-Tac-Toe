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

  var player = "player1"; // current player

  String player1;
  String player2;
  String player3;
  String player4;
  String player5;
  String player6;
  String player7;
  String player8;
  String player9;

  int flag1 = 0,
      flag2 = 0,
      flag3 = 0,
      flag4 = 0,
      flag5 = 0,
      flag6 = 0,
      flag7 = 0,
      flag8 = 0,
      flag9 = 0;

  IconLogic iconLogic = IconLogic();

  void _resetData() {
    flag1 = 0;
    flag2 = 0;
    flag3 = 0;
    flag4 = 0;
    flag5 = 0;
    flag6 = 0;
    flag7 = 0;
    flag8 = 0;
    flag9 = 0;
    pos = [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];
  }

  void reset1() {
    setState(() {
      _resetData();
      player1Score += 1;
    });
  }

  void reset2() {
    setState(() {
      _resetData();
      player2Score += 1;
    });
  }

  void reset3() {
    setState(() {
      _resetData();
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

  bool _checkFlags() {
    if (flag1 == 1 &&
        flag2 == 1 &&
        flag3 == 1 &&
        flag4 == 1 &&
        flag5 == 1 &&
        flag6 == 1 &&
        flag7 == 1 &&
        flag8 == 1 &&
        flag9 == 1) {
      return true;
    }
    return false;
  }

  void check() {
    if (_isWon(player)) {
      if (player == "player1") {
        gameFinishAlert('Player 1 won');
        reset1();
        return;
      } else {
        gameFinishAlert('Player 2 won');
        reset2();
        return;
      }
    }

    if (_checkFlags()) {
      gameFinishAlert('No winner');
      reset3();
    }
  }

  void gameFinishAlert(String message) {
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

  void switchPlayer() {
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
                        child: flag1 == 0 ? null : iconLogic.choice(player1),
                      ),
                      onTap: () {
                        if (flag1 != 0) return;
                        setState(() {
                          flag1 = 1;
                          player1 = player;
                          pos[0][0] = player;
                          check();
                          switchPlayer();
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
                        child: flag2 == 0 ? null : iconLogic.choice(player2),
                      ),
                      onTap: () {
                        if (flag2 != 0) return;
                        setState(() {
                          flag2 = 1;
                          player2 = player;
                          pos[0][1] = player;
                          check();
                          switchPlayer();
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
                        child: flag3 == 0 ? null : iconLogic.choice(player3),
                      ),
                      onTap: () {
                        if (flag3 != 0) return;
                        setState(() {
                          flag3 = 1;
                          player3 = player;
                          pos[0][2] = player;
                          check();
                          switchPlayer();
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
                        child: flag4 == 0 ? null : iconLogic.choice(player4),
                      ),
                      onTap: () {
                        if (flag4 != 0) return;
                        setState(() {
                          flag4 = 1;
                          player4 = player;
                          pos[1][0] = player;
                          check();
                          switchPlayer();
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
                        child: flag5 == 0 ? null : iconLogic.choice(player5),
                      ),
                      onTap: () {
                        if (flag5 != 0) return;
                        setState(() {
                          flag5 = 1;
                          player5 = player;
                          pos[1][1] = player;
                          check();
                          switchPlayer();
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
                        child: flag6 == 0 ? null : iconLogic.choice(player6),
                      ),
                      onTap: () {
                        if (flag6 != 0) return;
                        setState(() {
                          flag6 = 1;
                          player6 = player;
                          pos[1][2] = player;
                          check();
                          switchPlayer();
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
                        child: flag7 == 0 ? null : iconLogic.choice(player7),
                      ),
                      onTap: () {
                        if (flag7 != 0) return;
                        setState(() {
                          flag7 = 1;
                          player7 = player;
                          pos[2][0] = player;
                          check();
                          switchPlayer();
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
                        child: flag8 == 0 ? null : iconLogic.choice(player8),
                      ),
                      onTap: () {
                        if (flag8 != 0) return;
                        setState(() {
                          flag8 = 1;
                          player8 = player;
                          pos[2][1] = player;
                          check();
                          switchPlayer();
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
                        child: flag9 == 0 ? null : iconLogic.choice(player9),
                      ),
                      onTap: () {
                        if (flag9 != 0) return;
                        setState(() {
                          flag9 = 1;
                          player9 = player;
                          pos[2][2] = player;
                          check();
                          switchPlayer();
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
                        _resetData();
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
