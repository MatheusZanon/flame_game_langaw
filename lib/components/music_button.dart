import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class MusicButton {
  final LangawGame game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.game) {
    rect= Rect.fromLTWH(
            game.tileSize * 0.25,
            game.tileSize * 0.25,
            game.tileSize,
            game.tileSize,
    );
    initialize();
    enabledSprite = Sprite ('ui/icon-music-enabled.png');
    disabledSprite = Sprite ('ui/icon-music-disabled.png');
  }

  void initialize() {
    isEnabled = true;
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    }
    else {
      disabledSprite.renderRect(c, rect);
    }
  }
  
  void onTapDown() {
    if (isEnabled) {
      isEnabled = false;
      game.homeBGM.setVolume(0);
      game.playingBGM.setVolume(0);
    }
    else {
      isEnabled = true;
      game.homeBGM.setVolume(0.25);
      game.playingBGM.setVolume(0.25);
    }
  }
}