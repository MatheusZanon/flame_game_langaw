import 'package:flame/sprite.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/langaw_game.dart';

class MachoFly extends Mosca {
  MachoFly(LangawGame game, double x, double y) : super(game, x, y) {
    moscaVoandoSprite = List<Sprite>();
    moscaVoandoSprite.add(Sprite('moscas/macho-fly-1.png'));
    moscaVoandoSprite.add(Sprite('moscas/macho-fly-2.png'));
    mortaSprite = Sprite('moscas/macho-fly-dead.png');
  }

}