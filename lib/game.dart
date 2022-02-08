import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Game {
  final id;
  String text;
  Color col;
  bool enabled;
  Game({
    this.id,
    this.col = Colors.grey,
    this.enabled = true,
    this.text = "",
  });
}
