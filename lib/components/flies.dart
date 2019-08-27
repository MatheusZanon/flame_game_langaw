import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/views.dart';
import 'package:flame_game_langaw/components/callout.dart';
import 'package:flame/flame.dart';

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
  Callout callout;

  Fly(this.game) {
    callout = Callout(this);
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
      if (game.activeView == View.playing) {
        callout.render(c);
      }
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
      
      //callout
      callout.update(t); 
    }
  }                                                                  
  
  void onTapDown() {
    isDead = true;

    /*chama o método play da livraria de audio do Flame, passando o nome do arquivo de audio que vai ser usado 
    quando a mosca morre. O + 1 é acrescentado para o array que inicialmente vai de 0 a 10, passe a ir de 1 a 11
    e assim coincida com os numeros dos arquivos de som */
    Flame.audio.play('sfx/ouch' + (game.rnd.nextInt(11) + 1).toString() + '.ogg');

    // adiciona + 1 no score para cada mosca que morrer no tap do player e salvando pontuaçao mais alta no highscore
    if (game.activeView == View.playing) {  
      game.score += 1;
      if (game.score > (game.storage.getInt('highscore') ?? 0)) {
        game.storage.setInt('highscore', game.score);
        game.highscoreDisplay.updateHighscore();      
      }
    }
  }

}