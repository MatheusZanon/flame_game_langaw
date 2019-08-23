import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_game_langaw/components/flies.dart';
import 'package:flame_game_langaw/components/house_fly.dart';
import 'package:flame_game_langaw/components/agile_fly.dart';
import 'package:flame_game_langaw/components/drooler_fly.dart';
import 'package:flame_game_langaw/components/hungry_fly.dart';
import 'package:flame_game_langaw/components/macho_fly.dart';
import 'package:flame_game_langaw/components/backyard.dart';
import 'package:flame_game_langaw/components/start_button.dart';
import 'package:flame_game_langaw/components/help_button.dart';
import 'package:flame_game_langaw/components/credits_button.dart';
import 'package:flame_game_langaw/controller/spawner.dart';
import 'package:flame_game_langaw/views.dart';
import 'package:flame_game_langaw/views/home_view.dart';
import 'package:flame_game_langaw/views/lost_view.dart';
import 'package:flame_game_langaw/views/help_view.dart';
import 'package:flame_game_langaw/views/credits_view.dart';

class LangawGame extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;
  
  Backyard background;
  List<Fly> flies;
  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;
  
  FlySpawner spawner;
  
  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  HelpView helpView;
  CreditsView creditsView;
  
  LangawGame() {          
   initialize();                     
   /*constructor necessario pra chamar o método initialize,
   que por ser assincrono nao pode ser iniciado diretamente no constructor */
  }                

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    /*background deve ser colocado após o tamanho da tela ser determinado porque 
    o constructor usa os valores das variaveis screenSize e tileSize*/
    background = Backyard(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    spawner = FlySpawner(this); 
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
  } 

  void spawnFly(){
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2.025);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2.025);
    switch (rnd.nextInt(5)) {
    case 0:  
      flies.add(HouseFly(this, x, y));  
      break;
    case 1:  
      flies.add(AgileFly(this, x, y));  
      break;
    case 2:  
      flies.add(HungryFly(this, x, y));  
      break;
    case 3:  
      flies.add(MachoFly(this, x, y));  
      break;
    case 4:  
      flies.add(DroolerFly(this, x, y));  
      break;
    }
  }
  
  void render(Canvas canvas) {
    background.render(canvas);
    flies.forEach((Fly fly) => fly.render(canvas));
    
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    //fala pro startbutton, helpbutton e creditsbutton aparecerem tanto na tela "home" quanto na "lost"
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);

    /*Rect backgRect =  Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgPaint = Paint();
    backgPaint.color = Color(0xff3d3d3d);
    canvas.drawRect(backgRect, backgPaint);
    flies.forEach((Fly fly) {fly.render(canvas);} ); */ 
    
    /*para cada mosca, renderiza o canvas
     forEach precisa tem o formato padrao de conter um parametro para cada item da lista que vai no (), 
     e uma function também para cada item da lista que vai no {}.
     ((Fly fly) {fly.render(canvas);} ); poderia ter sido escrito como > ((Fly fly) => fly.render(canvas)); */
  }

  void update(double t) {    
    spawner.update(t);
    //chama a instância do controlador FlySpawner. Controllers são chamados no metodo update e não no render, já que não usam nada gráfico
    
    flies.forEach((Fly fly) {fly.update(t);} );           
    flies.removeWhere((Fly fly) {return fly.isOffScreen;} ); 
    /*chama o método update do componente flies.dart para cada mosca da lista,
    ou seja, presente na tela, e depois checa se o topo do retangulo da mosca
    é maior que a altura da tela, se nao for (se for menor), a mosca é removida
    da lista, isso evita dados desnecessarios no processo e a sobrecarregar o aparelho */
  }                                                            
                                                                
  void resize(Size size) {        
    screenSize = size;
    tileSize = screenSize.width / 9;
    //screenSize recebe as dimensoes da tela do dispositivo e tileSize divide a largura por 9 pedaços, criando as "telhas" 
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false; // lembra se o cuidador de taps ja foi chamado
    
    //dialog boxes
    if(!isHandled) {
      if(activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    //startbutton
    if(!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;      
      }
    }

    //helpbutton
    if(!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;      
      }
    }
    
    //creditsbutton
    if(!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;      
      }
    }

    //flies
    if(!isHandled) {  
      bool didHitAFly = false;
      flies.forEach((Fly fly) {  
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if(activeView == View.playing && !didHitAFly) {
        activeView = View.lost; 
      }
    } 
 
  }

}

