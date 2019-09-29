import 'dart:convert';

import 'object.dart';

class Map{
  var objects = List<Obj>();
  var roads = List<Road>();


  createMapFromJson(String json){
    var decodeJson = jsonDecode(json);

    var objects = decodeJson['objects'];
    var roads = decodeJson['roads'];

    /*for(int i =0;i<objects.;i++){
      Obj obj = Obj();
      obj
      ..type = objects['type'];
    }*/

  }
}