import 'package:flame/components.dart';
import 'package:enviromental_friendly/game.dart';
import '../globals.dart' as globals;
import 'package:flame/events.dart';

class Background extends PositionComponent with HasGameRef<MyGame>, TapCallbacks{
  Background({
    position,
    size,
  }):super(position: position, size: size);
  @override
  void onTapUp(TapUpEvent event){
      globals.toolBox.gastar(globals.currentTool.value);
  }

  @override
  void onLoad(){
    super.onLoad();
  }
}