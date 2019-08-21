import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame/sprite.dart';

class Mosca {
  final LangawGame game;
  Rect moscaRect;
  bool taMorta = false;  //variavel que checa se a mosca morreu
  bool saiuDaTela = false;
  List<Sprite> moscaVoandoListaSprite;
  Sprite mortaSprite;
  double voandoSpriteIndex = 0;
  Offset destinoAlvo;
  double get velocidade => game.tamanTelha * 3;

  Mosca(this.game) {
    determinarAlvo();
  }

  void determinarAlvo() {
    double x = game.rnd.nextDouble() * (game.tamanTela.width - (game.tamanTelha * 2.025));
    double y = game.rnd.nextDouble() * (game.tamanTela.height - (game.tamanTelha * 2.025));
    destinoAlvo = Offset(x, y);
  } 

  void render(Canvas c) {
    if (taMorta) {
       mortaSprite.renderRect(c, moscaRect.inflate(2));
    } 
    else {
      moscaVoandoListaSprite[voandoSpriteIndex.toInt()].renderRect(c, moscaRect.inflate(2));
    }
  }

  void update(double t) {                                              
    if (taMorta) {                                                     
      moscaRect = moscaRect.translate(-0.5, game.tamanTelha * 8 * t);  
      if (moscaRect.top > game.tamanTela.height) {                  
        saiuDaTela = true; 
      }
    } 
    else {
      //bater asas
      voandoSpriteIndex += 30 * t;
      if (voandoSpriteIndex >= 2) {
        voandoSpriteIndex -= 2;        
      }
      //mover a mosca
      double distanciaPasso = velocidade * t;
      Offset paraDestino = destinoAlvo - Offset(moscaRect.left, moscaRect.top);
      if(distanciaPasso < paraDestino.distance) {
        Offset voaParaDestino = Offset.fromDirection(paraDestino.direction, distanciaPasso);
        moscaRect = moscaRect.shift(voaParaDestino);
      }
      else {
        moscaRect = moscaRect.shift(paraDestino);
        determinarAlvo();
      }
    } 
    
    /*translate é uma propriedade da classe Rect que recria o retangulo
    as novas coordenadas especificadas, no caso, 0 representa X e
    game.tamanTelha * 8 * t representa Y por meio da formula da variavel t de deslocamento */
  }                                                                  
  
  void onTapDown() {
    taMorta = true;
    game.spawnMosca();
  }

}