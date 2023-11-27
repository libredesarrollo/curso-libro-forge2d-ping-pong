import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:forge2d/src/dynamics/body.dart';

import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BarBody extends BodyComponent with KeyboardHandler {
  bool _hit = false;

  final double _timeToHit = 1;
  double _elapseTimeToHit = 0;
  bool _barBack = false;
  int _barDirection = 1;

  final double _speedBar = 5;

  Vector2 position;
  Vector2 size;

  BarBody(this.position, this.size) : super() {
    // renderBody = true;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(size.x, size.y);
    final bodyDef =
        BodyDef(position: position, type: BodyType.kinematic, userData: this);

    final fixtureDef =
        FixtureDef(shape, friction: 1, density: 1, restitution: 0);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains((LogicalKeyboardKey.arrowRight))) {
      _hit = true;
      _barDirection = 1;
    } else if (keysPressed.contains((LogicalKeyboardKey.arrowLeft))) {
      _hit = true;
      _barDirection = -1;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    if (_elapseTimeToHit < _timeToHit && _hit & !_barBack) {
      // bar move
      _elapseTimeToHit += dt * _speedBar;

      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);
      body.angularVelocity = math.pi * 3 * _barDirection;
      if (_elapseTimeToHit >= _timeToHit) {
        // the bar exceed the maximum movement allowed, the bar must go back
        _barBack = true;
      }
    } else if (body.angle * _barDirection > 0 && _barBack) {
      // bar return
      _elapseTimeToHit -= dt * _speedBar;
      body.angularVelocity = -math.pi * 3 * _barDirection;
      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);
    } else {
      _hit = false;
      _barBack = false;
      _elapseTimeToHit = 0;
      body.angularVelocity = 0;
      body.setTransform(body.position, 0);
    }

    super.update(dt);
  }
}
