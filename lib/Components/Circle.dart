import 'dart:ui';

import 'package:car_game/Components/State.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../GameController.dart';

class Oval{
  final GameController gameController;
  double speed;
  Rect squareRect;
  bool isDead = false;
  double x,y;
  int k=0,p=0;
  Paint squareColor;

  Oval(this.gameController, double p, double q) {
    speed = 300;
    x=p;
    y=q;
    squareRect = Rect.fromLTWH(x,
        y,
        gameController.screenSize.width/4*0.5,
        30
    );
  }

  void render(Canvas c) {
    squareColor = Paint()..color = Colors.greenAccent;
    c.drawOval(squareRect, squareColor);
  }

  void update(double t) {
    if (!isDead) {
      double stepDistance = speed * t;
      Offset toPlayer = Offset(0,gameController.screenSize.height);
      Offset stepToPlayer = Offset.fromDirection(toPlayer.direction, stepDistance);
      squareRect = squareRect.shift(stepToPlayer);

    }
  }

  void carTouch1(){
     Rect v= squareRect.intersect(gameController.car1.rect);
    // print (v);
     // print("hello");
      Offset bottomRight=v.bottomRight;
      if(bottomRight.dy>=gameController.screenSize.height*0.8 && bottomRight.dy<=(gameController.screenSize.height*0.8)+60)
        {
          k++;
          if(gameController.car1.rect.topLeft.dx==x) {
            isDead = true;
            gameController.score++;
            Flame.audio.play("collectPointAudio.mp3");
          p++;
          }
            if(k!=0 && p==0 && bottomRight.dy>=(gameController.screenSize.height*0.8)+70)
              {
                gameController.audio.stop();
                Flame.audio.play("gameOver.mp3");
                gameController.State=state.over;
          }}

    }
    void carTouch2(){
      Rect v= squareRect.intersect(gameController.car2.rect);
     //  print (v.topLeft.dx);
      // print("hello");
      Offset bottomRight=v.bottomRight;
      if(bottomRight.dy>=gameController.screenSize.height*0.8 && bottomRight.dy<=(gameController.screenSize.height*0.8)+60)
      {
        k++;
         if(gameController.car2.rect.topLeft.dx==x)
         { isDead=true;
         gameController.score++;
         Flame.audio.play("collectPointAudio.mp3");
         p++;
         }
      }
      if(k!=0 && p==0 && bottomRight.dy>=(gameController.screenSize.height*0.8)+70) {
        gameController.audio.stop();
        Flame.audio.play("gameOver.mp3");
        gameController.State = state.over;
      }
    }


}