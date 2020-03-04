import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconLogic {
  Icon choice(String player) {
    return player == "player1"
        ? Icon(
            MaterialCommunityIcons.circle_outline,
            color: Color(0xFF39BCD4),
            size: 42,
          )
        : Icon(
            MaterialCommunityIcons.window_close,
            color: Color(0xFF3989D4),
            size: 50,
          );
  }
}
