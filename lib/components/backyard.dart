import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class Backyard {
  final LangawGame game; //instancia da variavel que age como link pra instancia do game (e suas propriedades) contendo esse componente
  Sprite backgSprite;   //contem os dados do sprite q serao chamados na tela posteriormente
  Rect backgRect;

  Backyard(this.game) {
    backgSprite = Sprite('background/backyard.png');
    backgRect = Rect.fromLTWH(0, 
                              game.screenSize.height - (game.tileSize * 23), 
                              game.tileSize * 9, 
                              game.tileSize * 23
                             );
  }

  void render(Canvas c){
    backgSprite.renderRect(c, backgRect);
  }

  void update(double t){}

}