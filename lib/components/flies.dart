import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/views.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  bool isDead = false;  //variavel que checa se a mosca morreu
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Offset targetLocation;
  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  } 

  void render(Canvas c) {
    if (isDead) {
       deadSprite.renderRect(c, flyRect.inflate(2));
    } 
    else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(c, flyRect.inflate(2));
    }
  }

  void update(double t) {                                              
    if (isDead) {                                                     
      flyRect = flyRect.translate(-0.5, game.tileSize * 8 * t);  
      if (flyRect.top > game.screenSize.height) {                  
        isOffScreen = true; 
      }
      /*translate é uma propriedade da classe Rect que recria o retangulo
      as novas coordenadas especificadas, no caso, 0 representa X e
      game.tileSize * 8 * t representa Y por meio da formula da variavel t de deslocamento */
    } 
    else {
      //bater asas
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;        
      }
      //mover a mosca
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if(stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      }
      else {
        flyRect = flyRect.shift(toTarget);
       setTargetLocation();
      }
    } 
  }                                                                  
  
  void onTapDown() {
    isDead = true;

    if (game.activeView == View.playing) {
      game.score += 1;
    }
  }

}