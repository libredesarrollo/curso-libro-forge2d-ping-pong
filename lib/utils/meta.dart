import 'dart:ui';

import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

BodyComponent createMeta(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();

  topLeft.x /= 6;
  topRight.x /= 6;

  return Meta(topLeft, topRight);
}

class Meta extends BodyComponent {
  Vector2 start;
  Vector2 end;
  late final Vector2 gameSize;
  int fact = 50;
  final double strokeWidth;

  Meta(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  Future<void> onLoad() {
    gameSize = game.screenToWorld(camera.viewport.size);
    return super.onLoad();
  }

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final bodyDef = BodyDef(
        position: Vector2.zero(), type: BodyType.static, userData: this);

    final fixtureDef = FixtureDef(shape, friction: 1, density: 5);

    paint = BasicPalette.red.paint();
    paint.strokeWidth = strokeWidth;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    // if (body.position.x > gameSize.x || body.position.x < 0) {
    // if (body.position.x > gameSize.x || body.position.x < -gameSize.x) {
    if (body.position.x.abs() >= gameSize.x) {
      fact *= -1;
    }

    body.setTransform(
        Vector2(
            clampDouble(body.position.x + fact * dt, -gameSize.x, gameSize.x),
            body.position.y),
        0);

    super.update(dt);
  }
}
