import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
import 'package:flame_game_langaw/langaw_game.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  LangawGame game = LangawGame();
  runApp(game.widget);

  TapGestureRecognizer pressionaTela = TapGestureRecognizer();
  pressionaTela.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(pressionaTela);
}
