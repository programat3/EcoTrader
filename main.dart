import 'package:audioplayers/audioplayers.dart';
import 'package:enviromental_friendly/animals/rescues.dart';
import 'package:enviromental_friendly/buttonController.dart';
import 'package:enviromental_friendly/firstPage.dart';
import 'package:enviromental_friendly/game.dart';
import 'package:enviromental_friendly/informationController.dart';
import 'package:enviromental_friendly/navbar.dart';
import 'package:enviromental_friendly/tool/newTool.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;


import 'tool/toolbox.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(MaterialApp(
    home: FirstPage(),
  ),
  );
}
class MyNavigation extends StatefulWidget {
  final width;
  final height;
  const MyNavigation(this.width, this.height);

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
    late MyGame game;
  bool navbarVisible = false;
  int _selectedIndex = 0;
  
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    globals.bgMusic.play(AssetSource('sounds/music_loop_placeholder.ogg'));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    game = MyGame('level0.tmx',width, height);
    return GestureDetector(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [GameWidget(game: game, overlayBuilderMap: {
            'ButtonController': (BuildContext context, MyGame game) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ButtonController(), InformationController()]);
            },
          },
              ),
            MyToolbox(),
            Rescues(),
            MyCamera(),
        ]
        ),
      drawer: MyNavbar(_selectedIndex,_onItemTapped),
      ),
    );
  }
   @override
  void initState(){
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
}
