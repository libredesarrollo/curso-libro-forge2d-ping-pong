import 'package:flame/extensions.dart';

enum TypeObstacle { box, circle }

class Obstacle {
  Vector2 position;
  Vector2 size;
  TypeObstacle typeObstacle;

  Obstacle(
      {required this.position, required this.size, required this.typeObstacle});
}

List<Obstacle> getCurrentLevel({int level = 1}) {
  switch (level) {
    case 1:
      return [
        Obstacle(
            position: Vector2(140, 170),
            size: Vector2(5, 5),
            typeObstacle: TypeObstacle.circle),
        Obstacle(
            position: Vector2(300, 400),
            size: Vector2(6, 6),
            typeObstacle: TypeObstacle.circle),
        Obstacle(
            position: Vector2(350, 150),
            size: Vector2(5, 5),
            typeObstacle: TypeObstacle.box),
        Obstacle(
            position: Vector2(400, 250),
            size: Vector2(10, 2),
            typeObstacle: TypeObstacle.box),
        Obstacle(
            position: Vector2(500, 500),
            size: Vector2(3, 3),
            typeObstacle: TypeObstacle.circle),
        Obstacle(
            position: Vector2(700, 250),
            size: Vector2(10, 10),
            typeObstacle: TypeObstacle.box),
      ];
    default:
      return [];
  }
}
