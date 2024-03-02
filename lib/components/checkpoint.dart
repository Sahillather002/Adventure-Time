import 'dart:async';

import 'package:adventure/adventure.dart';
import 'package:adventure/components/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Checkpoint extends SpriteAnimationComponent
    with HasGameRef<Adventure>, CollisionCallbacks {
  Checkpoint({
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  bool reachedCheckpoint = false;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(
      position: Vector2(18, 56),
      size: Vector2(12, 8),
      collisionType: CollisionType.passive,
    ));
    animation = SpriteAnimation.fromFrameData(
        game.images
            .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
        SpriteAnimationData.sequenced(
          amount: 1,
          stepTime: 0.01,
          textureSize: Vector2.all(64),
        ));
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if (other is Player && !reachedCheckpoint) {
      _reachedCheckpoint();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _reachedCheckpoint() {
    reachedCheckpoint = true;
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(
          'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
      SpriteAnimationData.sequenced(
        amount: 26,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
        loop: false,
      ),
    );
    const flagDuration = Duration(milliseconds: 50 * 26);
    Future.delayed(flagDuration, () {
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
        SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: 0.05,
          textureSize: Vector2.all(64),
          loop: false,
        ),
      );
    });
  }
}
