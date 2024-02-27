import 'dart:async';
import 'dart:math';

import 'package:enviromental_friendly/animals/animals.dart';
import 'package:enviromental_friendly/background.dart';
import 'package:enviromental_friendly/game.dart';
import 'package:enviromental_friendly/trash/garbage.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
class Level extends World with HasGameRef<MyGame>{
  String level_name;
  late TiledComponent level;
  Level(this.level_name);

  @override
  FutureOr<void> onLoad() async{

    level = await TiledComponent.load(level_name, Vector2(1920,1080));
    var backgroundCol = Background(position: Vector2(0,0),size: Vector2(1920, 1080));

    add(level);
    add(backgroundCol);
    gameRef.cam.viewfinder.anchor = Anchor.topLeft;
    _spawningAnimals();
    _spawningRandomObjects();
    add(TimerComponent(
      period: 64, 
      repeat: true, 
      onTick: ()=> _spawningRandomObjects(),
    ));
    return super.onLoad();
  }


    void _spawningRandomObjects(){
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    
    if(spawnPointsLayer != null){
      final boolList = List<bool>.generate(spawnPointsLayer.objects.length, (index) => Random().nextBool());
      int cont = 0;
      for (final spawnPoint in spawnPointsLayer.objects.reversed){
        final trash = Trash(type: spawnPoint.type,
                            id: spawnPoint.name,
                            angle: (spawnPoint.rotation*0.0174533),
                            position: Vector2(spawnPoint.x, spawnPoint.y),
                            size: Vector2(spawnPoint.width*1.2,spawnPoint.height*1.2),
        );
        if(boolList[cont]){
          add(trash);
        }
        cont ++;
      }
    }
  }

  void _spawningAnimals(){
    final spawnAnimalLayer = level.tileMap.getLayer<ObjectGroup>('AnimalPoints');
    if (spawnAnimalLayer != null){
      for(final animalPoint in spawnAnimalLayer.objects.reversed){
        final animal = Animal(position: Vector2(animalPoint.x, animalPoint.y), 
                              size: Vector2(animalPoint.width, animalPoint.height), 
                              id: animalPoint.name);
        add(animal);
      }
    }
  }
}



