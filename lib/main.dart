import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'GameController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  //SharedPreferences storage = await SharedPreferences.getInstance();
  GameController gameController = GameController();
  runApp(gameController.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
 tapper.onTapDown = gameController.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

}