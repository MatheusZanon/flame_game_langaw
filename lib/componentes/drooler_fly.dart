import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class DroolerFly extends Mosca {
  DroolerFly(LangawGame game, double x, double y) : super(game, x, y) {
    moscaVoandoSprite = List<Sprite>();
    moscaVoandoSprite.add(Sprite('moscas/drooler-fly-1.png'));
    moscaVoandoSprite.add(Sprite('moscas/drooler-fly-2.png'));
    mortaSprite = Sprite('moscas/drooler-fly-dead.png');
  }

}