import 'package:car_game/Components/Circle.dart';

import '../GameController.dart';

class OvalSpawner {
  final GameController gameController;
  final int maxSpawnInterval = 1500;
  final int minSpawnInterval = 1000;
  final int intervalChange = 25;
  int currentInterval;

  //final int maxSquare=2;
  int nextSpawn;

  OvalSpawner(this.gameController) {
    initialize();
  }

  void initialize() {
    kiiAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void kiiAllEnemies() {
    gameController.ovals.forEach((Oval oval) => oval.isDead = true);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now >= nextSpawn) {
      gameController.spawnsquare();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }
}
