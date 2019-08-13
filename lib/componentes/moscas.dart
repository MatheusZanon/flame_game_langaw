import 'dart:ui';
import 'package:flame_game_langaw/langaw_game.dart';

class Mosca {
  final LangawGame game;
  Rect moscaRect;
  Paint moscaPaint;

  Mosca(this.game, double x, double y) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha, game.tamanTelha);
    moscaPaint = Paint();
    moscaPaint.color = Color(0xff27ae60);
  }

  void render(Canvas c) {
   c.drawRect(moscaRect, moscaPaint);
  }

  void update(double t) {

  }

}