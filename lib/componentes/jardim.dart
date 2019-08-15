import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class Jardim {
  final LangawGame game;
  Sprite backgSprite;

  Jardim(this.game) {
    backgSprite = Sprite('background/backyard.png');
  }

  void render(Canvas canvas){}

  void update(double t){}

}