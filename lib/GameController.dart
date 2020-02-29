import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:car_game/Components/Game_Over.dart';
import 'package:car_game/Components/Square.dart';
import 'package:car_game/Components/Squarespawner.dart';
import 'package:car_game/Components/Start_Text.dart';
import 'package:car_game/Components/State.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

import 'Components/Car.dart';
import 'Components/Car2.dart';
import 'Components/Circle.dart';
import 'Components/Game_Name.dart';
import 'Components/Line.dart';
import 'Components/OvalSpawner.dart';
import 'Components/Start.dart';
import 'Components/score_text.dart';

class GameController extends Game with TapDetector {
  Random rand;
  Car car1;
  Car2 car2;
  Canvas cnavas;
  Sprite sprite1, sprite2;
  List<Oval> ovals;
  ScoreText scoreText;
  state State = state.menu;
  Game_Over over;
  Start_Text startText;
  int score=0,a;
  AudioPlayer audio;
 int position=0;
 List<int> track;
  //Car car2;
  Size screenSize;
  Game_Name name;
  Line l1, l2, l3;
  int i = 1, j = 1, k = 1;
  List<Square> squares;
  Squarespawner squareSpawner;
  OvalSpawner ovalSpawner;
  Start start;

  GameController() {
    State = state.menu;
    initialize();
  }

  void initialize() async {
    if (State == state.playing)
      audio = await Flame.audio.loopLongAudio('backgroundMusic.mp3');
    resize(await Flame.util.initialDimensions());
    l1 = Line(this, screenSize.width / 4.0, 0.0);
    l2 = Line(this, screenSize.width / 2, 0);
    l3 = Line(this, screenSize.width - screenSize.width / 4, 0);
    car1 = Car(this);
    car2 = Car2(this);
    startText = Start_Text(this);
    rand = Random();
    track=List<int>();
    ovals = List<Oval>();
    squares = List<Square>();
    scoreText = ScoreText(this);
    squareSpawner = Squarespawner(this);
    ovalSpawner = OvalSpawner(this);
    score = 0;
    position=0;
    name = Game_Name(this);
    over = Game_Over(this);
    sprite1 = Sprite("background.jpg");
    sprite2 = Sprite("over.png");
    start = Start(this);

    //  car2=Car2(this,2,screenSize.width*0.8, screenSize.height*0.8);
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    if (State == state.playing) {
      sprite1.renderRect(c, background);
      l1.render(c);
      l2.render(c);
      l3.render(c);
      scoreText.render(c);
      if (j % 2 == 0) {
        car2.render(c, screenSize.width / 2 * 1.1, screenSize.height * 0.8);
      } else
        car2.render(c, screenSize.width * 0.82, screenSize.height * 0.8);
      if (i % 2 == 0)
        car1.render(c, screenSize.width / 2 * 0.6, screenSize.height * 0.8);
      else
        car1.render(c, 30, screenSize.height * 0.8);
      squares.forEach((Square square) => square.render(c));
      ovals.forEach((Oval oval) => oval.render(c));
    } else if (State == state.over) {
      over.render(c);
      sprite2.renderRect(c, background);
      startText.render(c);
    } else if (State == state.menu) {
      sprite1.renderRect(c, background);
      name.render(c);
      start.render(c);
    }
  }

  void update(double t) {
    if (State == state.playing) {
      squareSpawner.update(t);
      squares.forEach((Square square) => square.update(t));
      squares.forEach((Square square) => square.carTouch1());
      squares.forEach((Square square) => square.carTouch2());
      ovalSpawner.update(t);
      ovals.forEach((Oval oval) => oval.carTouch1());
      ovals.forEach((Oval oval) => oval.carTouch2());
      ovals.forEach((Oval oval) => oval.update(t));
      ovals.removeWhere((Oval oval) => oval.isDead);
      scoreText.update(t);
    } else if (State == state.over) {
      over.update(t);
      startText.update(t);
    } else if (State == state.menu) name.update(t);
    start.update(t);
  }

  void resize(Size s) {
    screenSize = s;
  }

  void onTapDown(TapDownDetails d) {
    if (d.globalPosition.dx <= screenSize.width / 2)
      i++;
    else
      j++;
    if (k == 1) if (start.contains(d.globalPosition.dx, d.globalPosition.dy)) {
      State = state.playing;
      initialize();
      k++;
    }
    if (startText.contains(d.globalPosition.dx, d.globalPosition.dy)) {
      State = state.playing;
      initialize();
    }
  }

  void spawnsquare() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
        // 1 column
       a=1;
        x = 30;
        y = -10;
        break;
      case 1:
        // 2 column
       a=2;
        x = screenSize.width / 2 * 0.6;
        y = -10;
        break;
      case 2:
        // 3 column
        a=3;
        x = screenSize.width / 2 * 1.1;
        y = -10;
        break;
      case 3:
        // 4 column
       a=4;
        x = screenSize.width * 0.82;
        y = -10;
        break;
    }
    int k1;
    if(position!=0 && position!=1 && position!=2 && position!=3 && position!=4)
     k1=rand.nextInt(2);
    else
      k1=0;
    switch (k1) {
      case 0:
        track.add(a);
        if(position==0)
        squares.add(Square(this, x, y));
        else
          {
            if(track[position]==1 && track[position-1]!=2)
              squares.add(Square(this, x, y));
            if(track[position]==2 && track[position-1]!=1)
              squares.add(Square(this, x, y));
            if(track[position]==3 && track[position-1]!=4)
              squares.add(Square(this, x, y));
            if(track[position]==4 && track[position-1]!=3)
              squares.add(Square(this, x, y));
          }
        position++;
       print(position);
        break;
      case 1:
      print("Hello");
       if(position==0)
        ovals.add(Oval(this, x, y));
       else
         {
           if(track[position-1]!=a && track[position-2]!=a && track[position-3]!=a && track[position-4]!=a)
             ovals.add(Oval(this, x, y));
         }
        break;
    }
  }
}
