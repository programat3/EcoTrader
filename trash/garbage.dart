import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:enviromental_friendly/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;
import 'package:flame/events.dart';

class Trash extends SpriteComponent with HasGameRef<MyGame>, TapCallbacks{
  final String type;
  final String id;
  final String group;
  

  Trash({
    this.type = 'Glass',
    this.id = '1',
    this.group = '1',
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
  Future<void> onTapUp(TapUpEvent event) async {
    final player = AudioPlayer();
    var prefs = await SharedPreferences.getInstance();
    var selectedTool = globals.toolBox.values[globals.currentTool.value][0];
    await player.setSourceAsset('sounds/SFX_Pickup$selectedTool.ogg');
    if (selectedTool== type){
      player.resume();
      globals.actualRecycle.value += 0.1;
      prefs.setDouble('recycleProgress', globals.actualRecycle.value);
      if(globals.actualRecycle.value >= 1.0){
        globals.gotNewTool.value = true;
      }
      removeFromParent();
    }
    else{
        globals.toolBox.gastar(globals.currentTool.value);
    }
  }

  @override
  FutureOr<void> onLoad() async{
    RectangleHitbox hitBox = RectangleHitbox(position: position, size: size,angle: angle ,anchor: Anchor.bottomLeft, collisionType: CollisionType.active);
    add(hitBox);
    sprite = Sprite(game.images.fromCache('Garbage/$type/$id.png'));
    var prefs = await SharedPreferences.getInstance();
    var recycleProgress = prefs.getDouble('recycleProgress');
        if (recycleProgress == null){
          prefs.setDouble('recycleProgress', globals.actualRecycle.value);
        }
        else{
          globals.actualRecycle.value = recycleProgress;
          if(recycleProgress>=1.0){
            globals.gotNewTool.value = true;
          }
        }
    return super.onLoad();
  }
}