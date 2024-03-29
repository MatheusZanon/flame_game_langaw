import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame_game_langaw/views.dart';

class HelpButton {
  final LangawGame game;
  Rect rect;
  Sprite sprite;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
              game.tileSize * 0.25,
              game.screenSize.height - (game.tileSize * 1.25),
              game.tileSize,
              game.tileSize
    );
    sprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }

} 