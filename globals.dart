library my_tools.globals;

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

class ListModel with ChangeNotifier{
  final List values = [];
  final player = AudioPlayer();

  void gastar(int tool) async{
    values[tool][1] -= 0.1;
    if(values[tool][1]>0.1){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? storagedTools = prefs.getStringList("toolbox");
      for (var jsonTool in storagedTools!) {
        var toolI = jsonDecode(jsonTool);
        if(toolI["type"] == values[tool][0]){
          toolI["usage"] -= 0.1;
          var toolToStore = jsonEncode(toolI);
          storagedTools[storagedTools.indexWhere((element) => element.contains(toolI["type"]))] = toolToStore;
        }
      }
      prefs.setStringList("toolbox", storagedTools);
    }
  else{
    eliminar(tool);
  }
  if(values[tool][0] != 'Animal'){
    await player.setSource(AssetSource('sounds/SFX_ToolHPReduced.ogg'));
  }
  else{
    await player.setSource(AssetSource('sounds/SFX_CameraHPReduced.ogg'));
  }
    await player.resume();
    notifyListeners();
  }

  void update(List<String>? data){
    if(data != null){
    data.forEach((element) {
      var newArr = [];
      var jsonData = (jsonDecode(element));
        newArr.add(jsonData['type']);
        newArr.add(jsonData['usage']);
        values.add(newArr);
      });}
  }

  void eliminar(int tool) async{
    SystemSound.play(SystemSoundType.alert);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? storagedTools = prefs.getStringList("toolbox");
    final toRemove = [];
    for (var jsonTool in storagedTools!) {
      var toolI = jsonDecode(jsonTool);
      if(toolI["type"] == values[tool][0]){
        var jsonTool = jsonEncode(toolI);
        toRemove.add(jsonTool);
      }
    }
    if(values.length>1){
      globals.currentTool.value = 0;
    }
    else{
      addTool('No-Tools');
      globals.currentTool.value = 0;
    }
    storagedTools.removeWhere((element) => toRemove.contains(element));
    
    prefs.setStringList("toolbox", storagedTools);
    values.removeAt(tool);
    notifyListeners();
  }

  Future<AlertDialog> addTool(String type) async{
    var dialogo;
    bool exists = false;
    for(var tool in values){
      if(tool.contains(type)){
        exists = true;
      }
    }
    if(!exists){
      var newTool = [];
      newTool.add(type);
      newTool.add(1.0);
      values.add(newTool);
      final Map<String, dynamic> item = Map<String, dynamic>();
      item['type'] = type;
      item['usage'] = 1.0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? toolbox = prefs.getStringList("toolbox");

      if(toolbox == null) toolbox=[];

      toolbox.add(jsonEncode(item));
      prefs.setStringList("toolbox", toolbox);

      dialogo = AlertDialog(title: Text('You got a New Tool'), content: Text('A tool for '+type+' was added to your toolbox'));
    }
    else{
      SystemSound.play(SystemSoundType.alert);
      dialogo = AlertDialog(title: Text('You can\'t add this Tool'), content: Text('You already have a tool for '+type + ' in your toolbox'));
    }
    return(dialogo);
  }
}

class AnimalList with ChangeNotifier{
  final List values = [];

  void addAnimal(String name) async{
    var prefs = await SharedPreferences.getInstance();
    List<String>? rescues = prefs.getStringList("savedAnimals");
    if(rescues == null) rescues = [];

    rescues.add(name);
    SystemSound.play(SystemSoundType.click);
    values.add(name);
    prefs.setStringList("savedAnimals", rescues);
    notifyListeners();
  }
  void update(var listAnimals){
    if(listAnimals != null){
      if(values.length == 0){
        listAnimals.forEach((element) {
        values.add(element);
        notifyListeners();
      });
      }
    }
  }
}

ListModel toolBox = ListModel();
AnimalList savedAnimals = AnimalList();

final ValueNotifier<int> currentTool = ValueNotifier(0);
ValueNotifier<double> actualRecycle = ValueNotifier(0.0);
ValueNotifier<bool> gotNewTool = ValueNotifier(false);

final AudioPlayer bgMusic = AudioPlayer();