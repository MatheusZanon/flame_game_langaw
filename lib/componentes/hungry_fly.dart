import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class HungryFly extends Mosca {
  HungryFly(LangawGame game, double x, double y) : super(game, x, y) {
    moscaVoandoSprite = List<Sprite>();
    moscaVoandoSprite.add(Sprite('moscas/hungry-fly-1.png'));
    moscaVoandoSprite.add(Sprite('moscas/hungry-fly-2.png'));
    mortaSprite = Sprite('moscas/hungry-fly-dead.png');
  }

}