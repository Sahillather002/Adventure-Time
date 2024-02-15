import 'dart:async';

import 'package:adventure/adventure.dart';
import 'package:flame/components.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent with HasGameRef<Adventure> {
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation
    };
    current = PlayerState.running;
    return super.onLoad();
  }

  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Run', 12);
    runningAnimation = _spriteAnimation('Run', 11);
  }

  SpriteAnimation _spriteAnimation(String state, int frameAmount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: frameAmount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
