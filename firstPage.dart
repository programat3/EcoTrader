import 'package:audioplayers/audioplayers.dart';
import 'package:enviromental_friendly/main.dart';
import 'package:enviromental_friendly/onFirstOpen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;
import 'package:flutter/cupertino.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;


  void _showInformation(context){
    showCupertinoModalPopup<void>(context: context,
     builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 2.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.top,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("""
          Credits
          
          Programming
          * Lía Da Silva
          Game Design
          * Vale Dupouy
          * Lía Da Silva
          * Dany Rodríguez
          Art
          * Dany Rodríguez
          SFX
          * Vale Dupouy
          Music
          * Vale Dupouy
          * Monet
          External Assets
          - Recycle items art by Clint Bellanger
          """, style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none),),
            ),
          )
        ),
      ));
  }


  void onItemTapped() async{

    bool first_open = await IsFirstRun.isFirstRun();
    if(first_open){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OnFirstOpen([['Pointer','Plastic'],['Gloves', 'Glass'],['Magnet','Metal'],['Pliers','Paper']])));
    } 
    else{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? data = prefs.getStringList("toolbox");
      globals.toolBox.update(data);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyNavigation(width,height)));
    }

  }
  globals.bgMusic.play(AssetSource('sounds/drum_loop.ogg'));
    return Stack(
      children: [Container(width: MediaQuery.of(context).size.width, decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/background/Background.png'), fit: BoxFit.fill)
      )
      ),
      Align(
        alignment: Alignment(0.8, 0.8),
        child: Container(
          width: 90,
          height: 40,
          child: ElevatedButton(child: Icon(Icons.play_arrow_rounded),onPressed: onItemTapped),
        ),
      ),
      Align(
        alignment: Alignment(-0.8,0.8),
        child: ElevatedButton(child: Icon(Icons.info),onPressed: ()=>_showInformation(context)),
      )],
    );
  }
}

