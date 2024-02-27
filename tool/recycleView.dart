import 'package:enviromental_friendly/onFirstOpen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class RecycleView extends StatefulWidget {
  const RecycleView({super.key});

  @override
  State<RecycleView> createState() => _RecycleViewState();
}

class _RecycleViewState extends State<RecycleView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 159, 22),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Progress"),
              SizedBox(
                height: 10,
              ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: globals.actualRecycle.value,
                    backgroundColor: Colors.deepPurple,
                    strokeWidth: 10,
                    color: Colors.lightGreen,
                  ),
                ),
              ],
            ),
          ),
          Visibility(visible: globals.gotNewTool.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Exchange your progress for tools!"),
              ListenableBuilder(listenable: globals.toolBox, 
              builder:(BuildContext buildContext, Widget? child){ 
                var actualTools = globals.toolBox.values;
                var totalTools = [['Pointer','Plastic'],['Gloves', 'Glass'],['Magnet','Metal'],['Pliers','Paper'],['Camera', 'Animal']];
                var toolsToAddTotal = [];

                var toolsNames = [];
                
                var toolsToRemove = [];

                for(var tool in totalTools){
                  toolsNames.add(tool[1]);
                }
                for(var tool in actualTools){
                  toolsToRemove.add(tool[0]);
                }
                toolsNames.removeWhere((element) => toolsToRemove.contains(element));
                toolsToAddTotal = totalTools.where((element){
                  return toolsNames.contains(element[1]);
                }).toList();

                return IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.white,),
              onPressed: ()async {
                var prefs = await SharedPreferences.getInstance();
                globals.gotNewTool.value = false;
                globals.actualRecycle.value = 0.0;
                prefs.setDouble('recycleProgress', globals.actualRecycle.value);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> OnFirstOpen(toolsToAddTotal)));
                 },);
                }
              ),
            ],
          )
             )
        ],
      ),
    );
  }
}