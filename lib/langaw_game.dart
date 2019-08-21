import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_game_langaw/componentes/moscas.dart';
import 'package:flame_game_langaw/componentes/house_fly.dart';
import 'package:flame_game_langaw/componentes/agile_fly.dart';
import 'package:flame_game_langaw/componentes/drooler_fly.dart';
import 'package:flame_game_langaw/componentes/hungry_fly.dart';
import 'package:flame_game_langaw/componentes/macho_fly.dart';
import 'package:flame_game_langaw/componentes/quintal.dart';
import 'package:flame_game_langaw/janelas/janelas.dart';
import 'package:flame_game_langaw/janelas/pagina_inicial.dart';


class LangawGame extends Game {
  Size tamanTela;
  double tamanTelha;
  Quintal background;
  List<Mosca> moscas;
  Random rnd;
  Janela janelaAtiva = Janela.inicial;
  PaginaInicial paginaInicial;
  
  LangawGame() {          
    initialize();                     
   /*constructor necessario pra chamar o método initialize,
   que por ser assincrono nao pode ser iniciado diretamente no constructor */
  }                

  void initialize() async {
    moscas = List<Mosca>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    /*background deve ser colocado após o tamanho da tela ser determinado porque 
    o constructor usa os valores das variaveis tamanTela e tamanTelha*/
    background = Quintal(this);
    paginaInicial = PaginaInicial(this);
    spawnMosca();  
  } 

  void spawnMosca(){
    double x = rnd.nextDouble() * (tamanTela.width - tamanTelha * 2.025);
    double y = rnd.nextDouble() * (tamanTela.height - tamanTelha * 2.025);
    switch (rnd.nextInt(5)) {
    case 0:  
      moscas.add(HouseFly(this, x, y));  
      break;
    case 1:  
      moscas.add(AgileFly(this, x, y));  
      break;
    case 2:  
      moscas.add(HungryFly(this, x, y));  
      break;
    case 3:  
      moscas.add(MachoFly(this, x, y));  
      break;
    case 4:  
      moscas.add(DroolerFly(this, x, y));  
      break;
    }
  }
  
  void render(Canvas canvas) {
    background.render(canvas);
    moscas.forEach((Mosca mosca) => mosca.render(canvas));
    if (janelaAtiva == Janela.inicial) paginaInicial.render(canvas);


    /*Rect backgRect =  Rect.fromLTWH(0, 0, tamanTela.width, tamanTela.height);
    Paint backgPaint = Paint();
    backgPaint.color = Color(0xff3d3d3d);
    canvas.drawRect(backgRect, backgPaint);
    moscas.forEach((Mosca mosca) {mosca.render(canvas);} ); */ 
    
    /*para cada mosca, renderiza o canvas
     forEach precisa tem o formato padrao de conter um parametro para cada item da lista que vai no (), 
     e uma function também para cada item da lista que vai no {}.
     ((Mosca mosca) {mosca.render(canvas);} ); poderia ter sido escrito como > ((Mosca mosca) => mosca.render(canvas)); */
  }

  void update(double t) {    
    moscas.forEach((Mosca mosca) {mosca.update(t);} );           
    moscas.removeWhere((Mosca mosca) {return mosca.saiuDaTela;} ); 
    
    /*chama o método update do componente mosca.dart para cada mosca da lista,
    ou seja, presente na tela e depois checa se o topo do retangulo da mosca
    é maior que a altura da tela, se nao for (se for menor), a mosca é removida
    da lista, isso evita dados desnecessarios no processo e a sobrecarregar o aparelho */
    }                                                            
                                                                
  void resize(Size tamanho) {        
    tamanTela = tamanho;
    tamanTelha = tamanTela.width / 9;
    //tamanTela recebe as dimensoes da tela do dispositivo e tamanTelha divide a largura por 9 pedaços, criando as "telhas" 
  }

  void onTapDown(TapDownDetails d) {
    moscas.forEach((Mosca mosca) {  
     if (mosca.moscaRect.contains(d.globalPosition)) {
       mosca.onTapDown();
     }
    });
  }

}

