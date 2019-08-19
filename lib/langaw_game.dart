import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/componentes/quintal.dart';


class LangawGame extends Game {
  Size tamanTela;
  double tamanTelha;
  Quintal background;
  List<Mosca> moscas;
  Random rnd;
  
  LangawGame() {          
    initialize();                     
  
  // constructor necessario pra chamar o método initialize,
  // que por ser assincrono nao pode ser iniciado diretamente no constructor
  }                

  void initialize() async {
    moscas = List<Mosca>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Quintal(this);
    spawnMosca();  
  } 

  void spawnMosca(){
    double x = rnd.nextDouble() * (tamanTela.width - tamanTelha);
    double y = rnd.nextDouble() * (tamanTela.height - tamanTelha);
    moscas.add(Mosca(this, x, y));
  }
  
  void render(Canvas canvas) {
    background.render(canvas);
    moscas.forEach((Mosca mosca) => mosca.render(canvas));

    /*Rect backgRect =  Rect.fromLTWH(0, 0, tamanTela.width, tamanTela.height);
    Paint backgPaint = Paint();
    backgPaint.color = Color(0xff3d3d3d);
    canvas.drawRect(backgRect, backgPaint);
    moscas.forEach((Mosca mosca) {mosca.render(canvas);} ); */ 
    
    //para cada mosca, renderiza o canvas
    // forEach precisa tem o formato padrao de conter um parametro para cada item da lista que vai no (), 
    // e uma function também para cada item da lista que vai no {}.
    // ((Mosca mosca) {mosca.render(canvas);} ); poderia ter sido escrito como > ((Mosca mosca) => mosca.render(canvas));
  }

  void update(double t) {    
   moscas.forEach((Mosca mosca) {mosca.update(t);} );           
   moscas.removeWhere((Mosca mosca) {return mosca.saiuDaTela;} ); 
  
   //chama o método update do componente mosca.dart para cada mosca da lista,
  //ou seja, presente na tela e depois checa se o topo do retangulo da mosca
  //é maior que a altura da tela, se nao for (se for menor), a mosca é removida
  //da lista, isso evita dados desnecessarios no processo e a sobrecarregar o aparelho
  }                                                            
                                                                
  void resize(Size tamanho) {        
    tamanTela = tamanho;
    tamanTelha = tamanTela.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    moscas.forEach((Mosca mosca) {  
     if (mosca.moscaRect.contains(d.globalPosition)) {
       mosca.onTapDown();
     }
    });
  }

}

