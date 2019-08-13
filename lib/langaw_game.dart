import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';

class LangawGame extends Game {
  Size tamanTela;
  double tamanTelha;
  List<Mosca> moscas;

  
  LangawGame() {
    initialize();
  }

  void initialize() async {
    moscas = List<Mosca>();
    resize(await Flame.util.initialDimensions());
    spawnMosca();  
  } 

  void spawnMosca(){
    moscas.add(Mosca(this, 50, 50));
  }
  
  void render(Canvas canvas) {
    Rect backgRect =  Rect.fromLTWH(0, 0, tamanTela.width, tamanTela.height);
    Paint backgPaint = Paint();
    backgPaint.color = Color(0xff8e44ad);
    canvas.drawRect(backgRect, backgPaint);
    moscas.forEach((Mosca mosca) {mosca.render(canvas);} ); 
    // forEach precisa tem o formato padrao de conter um parametro para cada item da lista que vai no (), 
    // e uma function também para cada item da lista que vai no {}.
    // ((Mosca mosca) {mosca.render(canvas);} ); poderia ter sido escrito como > ((Mosca mosca) => mosca.render(canvas));
  }

  void update(double t) {    
   moscas.forEach((Mosca mosca) {mosca.update(t);} );
  }

  void resize(Size tamanho) {
    tamanTela = tamanho;
    tamanTelha = tamanTela.width / 9;

  }

}

