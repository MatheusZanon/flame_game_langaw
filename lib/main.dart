import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  
  SharedPreferences storage = await SharedPreferences.getInstance();

  Flame.images.loadAll(<String>[
    'background/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
    'background/lose-splash.png',
    'branding/title.png',
    'ui/dialog-credits.png', 
    'ui/dialog-help.png', 
    'ui/icon-credits.png', 
    'ui/icon-help.png', 
    'ui/start-button.png',
    'ui/callout.png',
  ]);

  LangawGame game = LangawGame(storage);
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
