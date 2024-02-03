import 'dart:async';

import 'package:adventure/adventure.dart';
import 'package:flame/components.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent with HasGameRef<Adventure> {
  String character;
  Player({required this.character});

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
    idleAnimation = SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/Ninja Frog/Idle (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: 11, stepTime: stepTime, textureSize: Vector2.all(32)));
    runningAnimation = _spriteAnimation();
  }

  SpriteAnimation _spriteAnimation(String character) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/Ninja Frog/Run (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: 12, stepTime: stepTime, textureSize: Vector2.all(32)));
  }
}
