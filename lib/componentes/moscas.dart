import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';

class Mosca {
  final LangawGame game;
  Rect moscaRect;
  Paint moscaPaint;
  bool taMorta = false;  //variavel que checa se a mosca morreu
  bool saiuDaTela = false;

  Mosca(this.game, double x, double y) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha, game.tamanTelha);
    moscaPaint = Paint();
    moscaPaint.color = Color(0xff27ae60);
  }

  void render(Canvas c) {
    c.drawRect(moscaRect, moscaPaint);
  }

  void update(double t) {                                              //translate é uma propriedade da classe Rect que recria o retangulo
    if (taMorta) {                                                     //as novas coordenadas especificadas, no caso, 0 representa X e
      moscaRect = moscaRect.translate(-0.5, game.tamanTelha * 8 * t);  //game.tamanTelha * 12 * t representa Y por meio da formula da variavel
      if (moscaRect.top > game.tamanTela.height) {                     //t de deslocamento
        saiuDaTela = true; 
      } 
    }                                                                                                                              
  }                                                                  

  void onTapDown() {
    taMorta = true;
    moscaPaint.color = Color(0xffff3838); 
    game.spawnMosca();
  }
}