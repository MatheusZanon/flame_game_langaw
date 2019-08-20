import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class DroolerFly extends Mosca {
  DroolerFly(LangawGame game, double x, double y) : super(game) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha * 1.5, game.tamanTelha * 1.5);
    moscaVoandoListaSprite = List<Sprite>();
    moscaVoandoListaSprite.add(Sprite('moscas/drooler-fly-1.png'));
    moscaVoandoListaSprite.add(Sprite('moscas/drooler-fly-2.png'));
    mortaSprite = Sprite('moscas/drooler-fly-dead.png');
  }

}