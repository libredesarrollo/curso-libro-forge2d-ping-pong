import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:pinball04/components/ball_body.dart';
// import 'package:pinball04/components/bar_body.dart';
import 'package:pinball04/utils/boundaries.dart';
import 'package:pinball04/utils/obstacles.dart';
import 'package:pinball04/utils/levels.dart' as level;

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame with HasKeyboardHandlerComponents {
  MyGame() : super(gravity: Vector2(0, 20));

  int _currentLevel = 1;

  @override
  FutureOr<void> onLoad() {
    world.add(BallBody());
    // world.add(BarBody());
    world.addAll(createBoundaries(this, type: 2));
    _addObstacles();
    return super.onLoad();
  }

  _addObstacles() {
    for (var o in level.getCurrentLevel(level: _currentLevel)) {
      switch (o.typeObstacle) {
        case level.TypeObstacle.box:
          world.add(
              RectangleBody(position: screenToWorld(o.position), size: o.size));
        case level.TypeObstacle.circle:
          world.add(
              CircleBody(position: screenToWorld(o.position), size: o.size.x));
      }
    }
  }
}
