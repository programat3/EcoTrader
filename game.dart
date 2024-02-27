import 'dart:async';
import 'dart:ui';
import 'package:enviromental_friendly/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class MyGame extends FlameGame with HasCollisionDetection{
  String level_name;
  late final CameraComponent cam;
  late final world;
  final double width;
  final double height;
  MyGame(this.level_name, this.width, this.height);
@override
Color backgroundColor() => Color.fromARGB(255, 66, 129, 53);
 @override
 FutureOr<void> onLoad() async{
  world  = Level(level_name);
  var rate = width/1920;
  await images.loadAllImages();
  cam = CameraComponent(world: world);
  cam.viewfinder.zoom = rate;
  addAll([cam, world]);
  overlays.add('ButtonController');
  return super.onLoad();
 }
         
}
 