import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class Quintal {
  final LangawGame game; //instancia da variavel que age como link pra instancia do game (e suas propriedades) contendo esse componente
  Sprite backgSprite;   //contem os dados do sprite q serao chamados na tela posteriormente
  Rect backgRect;

  Quintal(this.game) {
    backgSprite = Sprite('imagens/agile-fly-1.png');
    backgRect = Rect.fromLTWH(0, 
                              game.tamanTela.height - (game.tamanTelha * 23), 
                              game.tamanTelha * 9, 
                              game.tamanTelha * 23
                             );
  }

  void render(Canvas canvas){
    backgSprite.renderRect(canvas, backgRect);
  }

  void update(double t){}

}