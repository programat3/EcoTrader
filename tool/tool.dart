import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class MyTool extends StatelessWidget {
  final toolData;
  const MyTool(this.toolData);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 60,
      child: Column(
            children: [
              Expanded (child: Image(image: AssetImage(toolData[0]),)),
              Container(
                width: 50,
                height: 5,
                child: ListenableBuilder(
                  listenable: globals.toolBox,
                  builder: (BuildContext context, Widget? child){
                      return LinearProgressIndicator(
                      value: toolData[1],
                      semanticsLabel: 'Usage',
                    );
                  },
                  
                ),
              ),
            ],
          ),
    );
  }
}