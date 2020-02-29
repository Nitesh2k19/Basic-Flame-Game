import 'dart:ui';

import 'package:car_game/Components/State.dart';
import 'package:flame/flame.dart';
import 'package:flame/flame_audio.dart';
import 'package:flutter/material.dart';

import '../GameController.dart';

class Square {
  final GameController gameController;
  double speed;
  Rect squareRect;
  bool isDead = false;
  double x, y;
  Paint squareColor;

  Square(this.gameController, double p, double q) {
    speed = 300;
    x = p;
    y = q;
    squareRect =
        Rect.fromLTWH(x, y, gameController.screenSize.width / 4 * 0.5, 30);
  }

  void render(Canvas c) {
    squareColor = Paint()..color = Colors.red;
    c.drawRect(squareRect, squareColor);
  }
  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      Offset toPlayer = Offset(0, gameController.screenSize.height);
      Offset stepToPlayer =
          Offset.fromDirection(toPlayer.direction, stepDistance);
      squareRect = squareRect.shift(stepToPlayer);
    }
  }

  void carTouch1() {
    Rect v = squareRect.intersect(gameController.car1.rect);
    // print (v);
    // print("hello");
    Offset bottomRight = v.bottomRight;
    if (bottomRight.dy >= gameController.screenSize.height * 0.8 &&
        bottomRight.dy <= (gameController.screenSize.height * 0.8) + 69) {
      if (gameController.car1.rect.topLeft.dx == x) {
        gameController.audio.stop();
        Flame.audio.play("gameOver.mp3");
        gameController.State = state.over;
      }
    }
  }

  void carTouch2() {
    Rect v = squareRect.intersect(gameController.car2.rect);
    //print (v.topLeft.dx);
    // print("hello");
    Offset bottomRight = v.bottomRight;
    if (bottomRight.dy >= gameController.screenSize.height * 0.8 &&
        bottomRight.dy <= (gameController.screenSize.height * 0.8) + 69) {
      if (gameController.car2.rect.topLeft.dx == x) {
        gameController.audio.stop();
        Flame.audio.play("gameOver.mp3");
        gameController.State = state.over;
      }
    }
  }
}
