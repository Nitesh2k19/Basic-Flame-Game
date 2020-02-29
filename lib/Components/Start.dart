import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../GameController.dart';

class Start {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  Start(this.gameController) {
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
    if ((painter.text ?? '') != 'Start') {
      painter.text = TextSpan(
        text: "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 80.0,
        ),
      );
      painter.layout();

      position = Offset(
        (gameController.screenSize.width / 2) - (painter.width / 2),
        (gameController.screenSize.height * 0.8) - (painter.height / 2),
      );
    }
  }

  bool contains(double x, double y) {
    if (x > position.dx &&
        x < position.dx + painter.width &&
        y > position.dy &&
        y < position.dy + painter.height) {
      return true;
    }
    return false;
  }
}
