import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class HouseFly extends Mosca {
  HouseFly(LangawGame game, double x, double y) : super(game, x, y) {
    moscaVoandoSprite = List<Sprite>();
    moscaVoandoSprite.add(Sprite('moscas/house-fly-1.png'));
    moscaVoandoSprite.add(Sprite('moscas/house-fly-2.png'));
    mortaSprite = Sprite('moscas/house-fly-dead.png');
  }

}