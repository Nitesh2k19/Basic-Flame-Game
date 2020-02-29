import 'package:car_game/Components/Square.dart';

import '../GameController.dart';

class Squarespawner {
  final GameController gameController;
  final int maxSpawnInterval = 1000;
  final int minSpawnInterval = 500;
  final int intervalChange = 25;
  int currentInterval;
  final int maxSquare = 2;
  int nextSpawn;

  Squarespawner(this.gameController) {
    initialize();
  }

  void initialize() {
    kiiAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void kiiAllEnemies() {
    gameController.squares.forEach((Square square) => square.isDead = true);
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
