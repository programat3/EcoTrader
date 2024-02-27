import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class Rescues extends StatelessWidget {
  const Rescues({super.key});
  
  void getAnimals() async{
    var prefs = await SharedPreferences.getInstance();
    var rescues = prefs.getStringList("savedAnimals");
    globals.savedAnimals.update(rescues);
  }

  @override
  Widget build(BuildContext context) {
    getAnimals();
    var icons = ListenableBuilder(listenable: globals.savedAnimals, builder: (BuildContext context, Widget? child){
      return Center(
        child: (){ 
          if(globals.savedAnimals.values.length > 0){
            return GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            children: List<Widget>.generate(globals.savedAnimals.values.length, (index) { return Center(
              child: Image(image: AssetImage('assets/images/Animals/'+ globals.savedAnimals.values[index]+'.png'),)
            );}),
        );}
        else{
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [Icon(Icons.visibility), Text('¡Intenta encontrar más animales!')],
            ),
          );
        }

        }()
      );
      });
    return icons;
  }
}