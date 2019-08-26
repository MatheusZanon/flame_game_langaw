import 'dart:ui';
import 'package:flutter/painting.dart'; //dá acesso á class TextPainter
import 'package:flame_game_langaw/langaw_game.dart';

class ScoreDisplay {
  final LangawGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;


  ScoreDisplay(this.game) {
    painter = TextPainter(
       textAlign: TextAlign.center,
       textDirection: TextDirection.ltr // ltr significa left to right
    );

    textStyle = TextStyle(
      color: Color(0xffffffff), // essa cor é solid white
      fontSize: 90,
      shadows: <Shadow> [
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3), // 3 pixels lógicos para a direita e para baixo
        ),
      ],
    );
    
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
  
  void update(double t) {
    if ((painter.text?.text ?? '') != game.score.toString()) {
        painter.text = TextSpan(
          text: game.score.toString(),
          style: textStyle,
        );

      painter.layout();

      position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * 0.25) - (painter.height / 2),
      );
    }
  }

}