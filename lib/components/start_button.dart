import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame_game_langaw/views.dart';

class StartButton {
   final LangawGame game;
   Rect rect;
   Sprite sprite;

   StartButton(this.game){
     rect = Rect.fromLTWH( game.tileSize * 1.5,
                          (game.screenSize.height * 0.75) - (game.tileSize * 1.5),
                           game.tileSize * 6,
                           game.tileSize * 3,
     );
     sprite = Sprite ('ui/start-button.png');
   } 

   void render(Canvas c){
     sprite.renderRect(c, rect);
   }

   void update(double t){

   }

   void onTapDown(){
     game.activeView = View.playing;
     game.spawner.start();
     game.score = 0;
     game.playPlayingBGM();
   }

}