import 'package:enviromental_friendly/tool/tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../globals.dart' as globals;

final icons = ListenableBuilder(listenable: globals.toolBox, builder: (BuildContext context,  Widget? child) {
      return  CupertinoPicker(
                              magnification: 2.2,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32,
                              scrollController: FixedExtentScrollController(
                              initialItem: globals.currentTool.value,
                                                    ),
                              onSelectedItemChanged: (i) => globals.currentTool.value=i,
                            children:List<Widget>.generate(globals.toolBox.values.length, (index) => Center(child: RotatedBox(quarterTurns: -1, child:MyTool(['assets/images/tools/'+globals.toolBox.values[index][0]+'.png', globals.toolBox.values[index][1]])))
                            )
                            );
                            }
                            );

class ButtonController extends StatelessWidget {
  const ButtonController({super.key});
  
    void _showDialog(Widget child, context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 150,
        padding: const EdgeInsets.only(top: 2.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {

    return CupertinoButton(onPressed: ()=>_showDialog(
                                  RotatedBox(
                              quarterTurns: 1,
                              child: icons,
                            ), context
    ), 
    child: ListenableBuilder(listenable: globals.currentTool,builder: ((BuildContext context, Widget?child){return ListenableBuilder(listenable: globals.toolBox,builder: ((BuildContext context, Widget?child){return MyTool(['assets/images/tools/'+globals.toolBox.values[globals.currentTool.value][0]+'.png', globals.toolBox.values[globals.currentTool.value][1]]);}));}),));
  }
}