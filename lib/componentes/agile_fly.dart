import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class AgileFly extends Mosca {
  AgileFly(LangawGame game, double x, double y) : super(game) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha * 1.5, game.tamanTelha * 1.5);
    moscaVoandoListaSprite = List<Sprite>();
    moscaVoandoListaSprite.add(Sprite('moscas/agile-fly-1.png'));
    moscaVoandoListaSprite.add(Sprite('moscas/agile-fly-2.png'));
    mortaSprite = Sprite('moscas/agile-fly-dead.png');
  }

}