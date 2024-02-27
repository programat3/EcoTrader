import 'package:flutter/material.dart';

import 'globals.dart' as globals;

class MyNavbar extends StatelessWidget {
  final selectedIndex;
  final onItemTapped;
  const MyNavbar(this.selectedIndex, this.onItemTapped);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: RotatedBox(
        quarterTurns: -1,
        child: BottomNavigationBar(items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: RotatedBox(quarterTurns: 1,child: Icon(Icons.recycling)),
            label: ''
          ),
           BottomNavigationBarItem(
            icon: RotatedBox(quarterTurns: 1,child: Icon(Icons.build)),
            label: ''
            ),
           BottomNavigationBarItem(
            icon: RotatedBox(quarterTurns: 1,child: Icon(Icons.cruelty_free)),
            label: ''
            ),
          BottomNavigationBarItem(
            icon: RotatedBox(quarterTurns: 1,child: Builder(builder: (context){
              if(globals.gotNewTool.value){
              return(Stack(children: [Icon(Icons.add_box),Positioned(child: Icon(Icons.brightness_1, color: Colors.red, size: 9.0,))]));}
              else{
                return(Icon(Icons.add_box));
              }
              } )),
            label: ''
            ),
        ],
        currentIndex: this.selectedIndex,
        selectedItemColor: Color.fromARGB(255,253 ,231 , 76),
        unselectedItemColor: Color.fromARGB(255, 64,78, 77),
        backgroundColor: Color.fromARGB(255, 155, 197, 61),
        onTap: this.onItemTapped,

        ),
      ),
      width: 100.0,
    );
  }
}