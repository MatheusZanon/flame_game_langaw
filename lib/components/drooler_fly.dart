import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/components/flies.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class DroolerFly extends Fly {
  double get speed => game.tileSize * 1.5;

  DroolerFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');
  }

}