import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class PaginaInicial {
   final LangawGame game;
   Rect tituloRect;
   Sprite tituloSprite;
  
   PaginaInicial(this.game){
     tituloRect = Rect.fromLTWH(
                    game.tamanTelha, 
                   (game.tamanTela.height / 2) - (game.tamanTelha * 4),
                    game.tamanTelha * 7,  
                    game.tamanTelha * 4,
     );
     tituloSprite = Sprite('interface/title.png');
   }

   void render(Canvas c){
     tituloSprite.renderRect(c, tituloRect);
   }

   void update(){}

}