import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flame_game_langaw/langaw_game.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  
  Flame.images.loadAll(<String>[
    'background/backyard.png',
    'moscas/agile-fly-1.png',
    'moscas/agile-fly-2.png',
    'moscas/agile-fly-dead.png',
    'moscas/drooler-fly-1.png',
    'moscas/drooler-fly-2.png',
    'moscas/drooler-fly-dead.png',
    'moscas/house-fly-1.png',
    'moscas/house-fly-2.png',
    'moscas/house-fly-dead.png',
    'moscas/hungry-fly-1.png',
    'moscas/hungry-fly-2.png',
    'moscas/hungry-fly-dead.png',
    'moscas/macho-fly-1.png',
    'moscas/macho-fly-2.png',
    'moscas/macho-fly-dead.png',
  ]);

  LangawGame game = LangawGame();
  runApp(game.widget);

  TapGestureRecognizer pressionaTela = TapGestureRecognizer();
  pressionaTela.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(pressionaTela);
}
