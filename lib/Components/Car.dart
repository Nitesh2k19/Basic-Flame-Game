import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

import '../GameController.dart';

class Car {
  final GameController gameController;
   Sprite sprite;
   Rect rect;

  Car(this.gameController) {
     sprite = Sprite('Car1.png');

  }

  void render(Canvas c,double x,double y) {
    rect=Rect.fromLTWH(x, y, 40, 70);
  sprite.renderRect(c, rect);
    }

    void update(double t,Canvas c){


    }


}