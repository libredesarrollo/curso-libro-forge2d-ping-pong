import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class CircleBody extends BodyComponent {
  Vector2 position;
  double size;

  CircleBody({required this.position, required this.size}) : super() {
    // renderBody = true;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = size;
    final bodyDef =
        BodyDef(position: position, type: BodyType.static, userData: this);

    final fixtureDef =
        FixtureDef(shape, friction: 1, density: 5, restitution: 0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class RectangleBody extends BodyComponent {
  Vector2 position;
  Vector2 size;

  RectangleBody({required this.position, required this.size}) : super() {
    // renderBody = true;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(size.x, size.y);
    final bodyDef =
        BodyDef(position: position, type: BodyType.static, userData: this);

    final fixtureDef =
        FixtureDef(shape, friction: 1, density: 5, restitution: 0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
