import 'dart:convert';

import 'package:indoor_navigation/model/pair.dart';

import 'object.dart';

class Map{
  String jsonMap;
  List<Obj> listObjects = List<Obj>();
  var listRoads = List<Road>();

  Map(this.jsonMap);


  createMapFromJson(){
    var decodeJson = jsonDecode(jsonMap);

    var objects = json.decode(decodeJson['polygones']);
    var roads = json.decode(decodeJson['lines']);

    for (var obj in objects) {
      Obj objec = Obj();
      objec.cy = obj['top']*1.0;
      objec.cx = obj['left']*1.0;

      listObjects.add(objec);
    }

    for (var line in roads) {
      Road road = Road();
      road.start = Dot(line['x_first']*1.0, line['y_first']*1.0);
      road.end = Dot(line['x_second']*1.0, line['y_second']*1.0);

      listRoads.add(road);
    }
  }
}