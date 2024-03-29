import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class HighscoreDisplay {
   final LangawGame game;
   TextPainter painter;
   TextStyle textStyle;
   Offset position;

   HighscoreDisplay(this.game) {
     painter = TextPainter(
       textAlign: TextAlign.center,
       textDirection: TextDirection.ltr,
     );

     Shadow shadow = Shadow(
       blurRadius: 3,
       color: Color(0xff000000),
       offset: Offset.zero,
     );

     textStyle = TextStyle(
       color: Color(0xffffffff),
       fontSize: 30,
       shadows: [shadow, shadow, shadow, shadow],
     );

     position = Offset.zero;

     updateHighscore();
   }

   void updateHighscore() {
     int highscore = game.storage.getInt('highscore') ?? 0;

     painter.text = TextSpan(
       text: 'High-score: ' + highscore.toString(),
       style: textStyle,
     );

     painter.layout(); //determina o tamanho do texto quando pintado

     position = Offset(
       game.screenSize.width - (game.tileSize * 0.25) - painter.width,
       game.tileSize * 0.25,
     );
   }

   void render(Canvas c) {
     painter.paint(c, position);
     //pinta o highscore na posiçao pre-calculada pelo metodo updateHighscore()
   }


}