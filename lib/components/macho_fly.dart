import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/components/flies.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class MachoFly extends Fly {
  double get velocidade => game.tileSize * 2.5;

  MachoFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }

}