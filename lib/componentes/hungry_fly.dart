import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class HungryFly extends Mosca {
  HungryFly(LangawGame game, double x, double y) : super(game) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha * 1.65, game.tamanTelha * 1.65);
    moscaVoandoListaSprite = List<Sprite>();
    moscaVoandoListaSprite.add(Sprite('moscas/hungry-fly-1.png'));
    moscaVoandoListaSprite.add(Sprite('moscas/hungry-fly-2.png'));
    mortaSprite = Sprite('moscas/hungry-fly-dead.png');
  }

}