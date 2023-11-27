import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

class BallBody extends BodyComponent {
  BallBody() : super() {
    // renderBody = true;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 2;
    final bodyDef = BodyDef(
        position: Vector2(8, 0), type: BodyType.dynamic, userData: this);

    final fixtureDef =
        FixtureDef(shape, friction: 1, density: 5, restitution: 0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
