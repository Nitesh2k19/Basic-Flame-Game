import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../GameController.dart';

class Game_Over {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  Game_Over(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {

      painter.text = TextSpan(
        text: "Game Over",
        style: TextStyle(
          color: Colors.white,
          fontSize: 70.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2) - (painter.width / 2),
        (gameController.screenSize.height * 0.2) - (painter.height / 2),
      );

}}