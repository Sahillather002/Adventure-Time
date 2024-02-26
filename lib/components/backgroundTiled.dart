import 'dart:async';

import 'package:adventure/adventure.dart';
import 'package:flame/components.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<Adventure> {
  final String color;
  BackgroundTile({
    this.color = 'Green',
    position,
  }) : super(position: position);

  final double scrollSpeed = 0.5;

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    priority = -1;
    size = Vector2.all(64.5);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update

    position.y += scrollSpeed;
    double tileSize = 64;
    int scrollHeight = (game.size.y / tileSize).floor();
    if (position.y > scrollHeight * tileSize) {
      position.y = -tileSize;
    }
    super.update(dt);
  }
}
