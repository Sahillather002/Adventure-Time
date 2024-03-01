import 'dart:async';

import 'package:adventure/adventure.dart';
import 'package:adventure/components/PlayerHitBox.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<Adventure>, CollisionCallbacks {
  final String fruit;

  Fruit({
    this.fruit = 'Cherries',
    position,
    size,
  }) : super(
          position: position,
        );

  final double stepTime = 0.05;
  bool _collected = false;

  final hitbox = PlayerHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    priority = -1;

    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
        collisionType: CollisionType.passive,
      ),
    );
    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/$fruit.png'),
        SpriteAnimationData.sequenced(
          amount: 17,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ));
    return super.onLoad();
  }

  void collidingWithPlayer() {
    if (!_collected) {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Items/Fruits/Collected.png'),
        SpriteAnimationData.sequenced(
          amount: 17,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
          loop: false,
        ),
      );

      _collected = true;
    }
    Future.delayed(
      const Duration(milliseconds: 512),
      () => removeFromParent(),
    );
  }
}
