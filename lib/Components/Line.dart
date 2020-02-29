import 'dart:ui';

import 'package:flutter/material.dart';

import '../GameController.dart';

class Line{
  final GameController gameController;
  int strokeWidth;
  double x,y;
   Line(this.gameController,double p,double q){
     x=p;
     y=q;
    strokeWidth=4;
   }

   void render(Canvas c){

     Offset p1 = Offset(x, y);
     Offset p2 = Offset(x, gameController.screenSize.height);
     final paint = Paint()
       ..color = Colors.white
       ..strokeWidth = 6;
     c.drawLine(p1, p2, paint);

  }

}