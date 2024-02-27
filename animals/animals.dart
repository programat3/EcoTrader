import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:enviromental_friendly/game.dart';
import 'package:flame_audio/flame_audio.dart';
import '../globals.dart' as globals;
import 'package:flame/events.dart';

class Animal extends SpriteComponent with HasGameRef<MyGame>, TapCallbacks, CollisionCallbacks, HasVisibility{
  final String id;
  bool photographed;
  bool freed;
  final player = AudioPlayer();
  Animal({
    this.photographed = false,
    this.freed = true,
    this.id = '1',
    position,
    size,
    angle,
  }) : super(
      position: position,
      size: size,
      angle: angle,
      anchor: Anchor.bottomLeft,
      );
  
  @override
  void onTapUp(TapUpEvent event) async{
    var selectedTool = globals.toolBox.values[globals.currentTool.value][0];
    if (selectedTool== 'Animal'){
      if(!globals.savedAnimals.values.contains(id)){ 
        if(freed){
          await player.setSourceAsset('sounds/SFX_TakePhoto.ogg');
          photographed = true;
          globals.savedAnimals.addAnimal(id);
        }
        else{
          await player.setSourceAsset('sounds/SFX_CameraHPReduced.ogg');
        }
      }
    }else{
      await player.setSourceAsset('sounds/SFX_ToolHPReduced.ogg');
    }
    player.resume();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other){
    freed = false;
    super.onCollision(points, other);
  }

  @override
  void onCollisionEnd(PositionComponent other){
    freed = true;
    super.onCollisionEnd(other);
  }


  @override
  FutureOr<void> onLoad(){
    sprite = Sprite(game.images.fromCache('Animals/$id.png'));
    add(RectangleHitbox(position: position,size: size,anchor: Anchor.bottomLeft,collisionType: CollisionType.active));
    return super.onLoad();
  }
  @override
  void update(double dt){
    super.update(dt);
  }
}