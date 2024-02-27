import 'package:enviromental_friendly/tool/tool.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class MyToolbox extends StatelessWidget {
  const MyToolbox({super.key});
  
  @override
  Widget build(BuildContext context) {
    var icons = ListenableBuilder(listenable: globals.toolBox, builder: (BuildContext context, Widget? child){
      return Center(
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        crossAxisCount: 2,
        children: List<Widget>.generate(globals.toolBox.values.length, (index) => Center(child: MyTool(['assets/images/tools/'+globals.toolBox.values[index][0]+'.png', globals.toolBox.values[index][1]]))),
      ),
    );
    });
    return icons;
  }
}