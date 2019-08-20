import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class MachoFly extends Mosca {
  double get velocidade => game.tamanTelha * 2.5;

  MachoFly(LangawGame game, double x, double y) : super(game) {
    moscaRect = Rect.fromLTWH(x, y, game.tamanTelha * 2.025, game.tamanTelha * 2.025);
    moscaVoandoListaSprite = List<Sprite>();
    moscaVoandoListaSprite.add(Sprite('moscas/macho-fly-1.png'));
    moscaVoandoListaSprite.add(Sprite('moscas/macho-fly-2.png'));
    mortaSprite = Sprite('moscas/macho-fly-dead.png');
  }

}