import 'package:flame_game_langaw/langaw_game.dart';
import 'package:flame_game_langaw/components/flies.dart';


class FlySpawner {
  final LangawGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int maxFliesOnScreen = 12;
  final int intervalChange = 3;
  int currentInterval;
  int nextSpawn; 
  
  FlySpawner(this.game) {
    start();
    game.spawnFly();  
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.flies.forEach((Fly fly) => fly.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.flies.forEach((Fly fly) {
      if (!fly.isDead) livingFlies += 1; // ou livingFlies = livingFlies + 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if(currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}