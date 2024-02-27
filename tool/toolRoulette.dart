import 'dart:async';
import 'dart:math';
import 'package:enviromental_friendly/main.dart';
import 'package:enviromental_friendly/tool/arrow.dart';
import 'package:enviromental_friendly/tool/getNewTools.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:roulette/roulette.dart';
import '../globals.dart' as globals;

class ToolPickerRoulette extends StatefulWidget {
  final tools;
  final firstOpen;
  const ToolPickerRoulette(this.tools,this.firstOpen);

  @override
  State<ToolPickerRoulette> createState() => _ToolPickerRouletteState();
}

class _ToolPickerRouletteState extends State<ToolPickerRoulette> with SingleTickerProviderStateMixin {
  final player = AudioPlayer();
  static final _random = Random();
  static final index = Random();
  late int chosenTool;
  late var dialog;
  bool _isLoading = true;
  late RouletteController controller;
  bool isButtonToTurnVisible = true;



  var images;

  List<ImageProvider> getToolImages(){
    var routesToImages = <ImageProvider>[];
    for (var tool in widget.tools) {
      var singleRoute = 'assets/images/googleImages/' + tool[1] + '.png';
      routesToImages.add(AssetImage(singleRoute));
    }
    return routesToImages;
  }

  void getDialog()async{
    isButtonToTurnVisible = false;
    dialog = await globals.toolBox.addTool(widget.tools[chosenTool][1]);
    if(widget.firstOpen){
      globals.toolBox.addTool('Animal');
    }
    
  }


  @override
  void initState(){
    super.initState();
    player.setSource(AssetSource('sounds/SFX_Roulette.ogg'));
    images = getToolImages();
    controller = RouletteController(
      group: RouletteGroup.uniformImages(
        images.length,
        imageBuilder: (index) => images[index],
    ),
      vsync: this,
       // TickerProvider, usually from SingleTickerProviderStateMixin
);
    chosenTool = index.nextInt(images.length);
  }
  @override
  Widget build(BuildContext context) {
    // Initialize controller
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(width: 250, child: Stack(alignment: Alignment.topCenter, children:[ Roulette(controller: controller), Arrow()])),
        ),
        Visibility(
          visible: isButtonToTurnVisible,
          child: FloatingActionButton(child: Icon(Icons.north_west), onPressed: (){
            controller.rollTo(chosenTool,duration: Duration(seconds: 3),clockwise: true,offset: _random.nextDouble());
            player.resume();
          Timer(Duration(seconds: 5, milliseconds: 5), () { 
            getDialog();
            setState(() {
                _isLoading = false;
                showDialog(context: context, builder: (context) => dialog);
            });
          });
          }),
        ),
        if(!_isLoading)...[
          Container(
            width: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(fit: BoxFit.fitWidth, child: Text('You got '+widget.tools[chosenTool][0], style: TextStyle(color: Colors.white, decoration: TextDecoration.none),)),
                  FittedBox(fit: BoxFit.fitWidth,child: Text('Use it to pick up ' + widget.tools[chosenTool][1], style: TextStyle(color: Colors.white, decoration: TextDecoration.none),)),
                  GetNewTool(chosenTool),
                  ElevatedButton(onPressed: (){
                    if(widget.firstOpen){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyNavigation(100, 100)));}
                    else{Navigator.pop(context);}
                    }, child: Row(children: [Icon(Icons.play_arrow_rounded), Text('Begin Collecting!')],))
                ],
              ),
            ),
          )
        ]
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }
}
