import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame/sprite.dart';

class Mosca {
  final LangawGame game;
  Rect moscaRect;
  bool taMorta = false;  //variavel que checa se a mosca morreu
  bool saiuDaTela = false;
  List<Sprite> moscaVoandoSprite;
  Sprite mortaSprite;
  double voandoSpriteIndex = 0;

  Mosca(this.game, double x, double y) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha, game.tamanTelha);
  }

  void render(Canvas c) {
    if (taMorta) {
       mortaSprite.renderRect(c, moscaRect.inflate(4));
    } else {
      moscaVoandoSprite[voandoSpriteIndex.toInt()].renderRect(c, moscaRect.inflate(4));
    }
  }

  void update(double t) {                                              
    if (taMorta) {                                                     
      moscaRect = moscaRect.translate(-0.5, game.tamanTelha * 8 * t);  
      if (moscaRect.top > game.tamanTela.height) {                  
        saiuDaTela = true; 
      } 
    } 

    //translate é uma propriedade da classe Rect que recria o retangulo
    //as novas coordenadas especificadas, no caso, 0 representa X e
    //game.tamanTelha * 12 * t representa Y por meio da formula da variavel t de deslocamento
  }                                                                  

  void onTapDown() {
    taMorta = true;
    game.spawnMosca();
  }
}