import 'dart:math';
import 'dart:ui';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:indoor_navigation/model/map.dart' as prefix1;
import 'package:indoor_navigation/model/object.dart';
import 'package:indoor_navigation/model/pair.dart';

class MyPainter extends CustomPainter{
  var names = ['Склад 1','Склад 2','Сборочный цех','Конвейер 1'];
  Size screenSize;
  Dot currentLocation;
  prefix1.Map map;
  MyPainter(this.screenSize, this.currentLocation,this.map);

  get cWidth => screenSize.width/2;
  get cHeight => screenSize.height/2;

  drawMap(Canvas canvas){
    var colors = [Colors.red, Colors.green, Colors.indigo, Colors.orange, Colors.yellow];
    for (var road in map.listRoads) {
      drawRoad(canvas, Offset(road.start.dx, road.start.dy), Offset(road.end.dx, road.end.dy));
    }
    for (int i =0;i<map.listObjects.length;i++) {
      var obj = map.listObjects[i];
      drawRectLTRB(canvas, obj, colors[i]);
      drawName(canvas, 'ABCDEFG'[i], obj.cx, obj.cy);
    }


    drawUserLocation(canvas);
  }
  drawMapManual(Canvas canvas){
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black12
      ..isAntiAlias = true
      ..strokeWidth = 3;

    //canvas.drawRect(Rect.fromCenter(center: Offset(screenSize.width/2, screenSize.height/2), width: 350, height: 350), paint );
    print('${screenSize.height}  ${screenSize.width}');
    drawChecks(canvas);
    drowNames(canvas);
    drawRoads(canvas);
    drawUserLocation(canvas);


  }

  drawName(Canvas canvas, String text, double x, double y){
    Offset offset = Offset(x, y);
    ParagraphBuilder pgBuilder = ParagraphBuilder(ParagraphStyle());
    pgBuilder.pushStyle(prefix0.TextStyle(color: Colors.white, fontSize: 20,));
    pgBuilder.addText(text);
    pgBuilder.pop();

    Paragraph paragraph = pgBuilder.build();
    paragraph.layout(ParagraphConstraints(width: 4));

    canvas.drawParagraph(paragraph,offset);
  }

  drowNames(Canvas canvas){
    drawName(canvas, 'A', cWidth, cHeight);
    drawName(canvas, 'B', cWidth-148, cHeight);
    drawName(canvas, 'C', cWidth, cHeight-148);
    drawName(canvas, 'D', cWidth-74, cHeight+148);
    drawName(canvas, 'E', cWidth+148, cHeight+74);
  }

  drawChecks(Canvas canvas){
    drawRect(canvas, cWidth, cHeight, Colors.green);
    drawRect(canvas, cWidth-148, cHeight, Colors.blue);
    drawRect(canvas, cWidth, cHeight-148, Colors.purple);
    drawRect(canvas, cWidth-74, cHeight+148, Colors.red);
    drawRect(canvas, cWidth+148, cHeight+74, Colors.amber);
  }

  drawRoads(Canvas canvas){
    drawRoad(canvas, Offset(cWidth-74, cHeight+123), Offset(cWidth-74, cHeight));
    drawRoad(canvas, Offset(cWidth-123, cHeight), Offset(cWidth-25, cHeight));
    drawRoad(canvas, Offset(cWidth+123, cHeight+74), Offset(cWidth-74, cHeight+74));
    drawRoad(canvas, Offset(cWidth, cHeight+25), Offset(cWidth, cHeight+74));
    drawRoad(canvas, Offset(cWidth, cHeight-25), Offset(cWidth, cHeight-123));
    drawRoad(canvas, Offset(cWidth-148, cHeight-25), Offset(cWidth-148, cHeight-148));
    drawRoad(canvas, Offset(cWidth-148, cHeight-148), Offset(cWidth-25, cHeight-148));
    drawRoad(canvas, Offset(cWidth+25, cHeight-148), Offset(cWidth+148, cHeight-148));
    drawRoad(canvas, Offset(cWidth+148, cHeight-148), Offset(cWidth+148, cHeight+49));
    drawRoad(canvas, Offset(cWidth-148, cHeight+25), Offset(cWidth-148, cHeight+148));
    drawRoad(canvas, Offset(cWidth-148, cHeight+148), Offset(cWidth-99, cHeight+148));
    drawRoad(canvas, Offset(cWidth-49, cHeight+148), Offset(cWidth+148, cHeight+148));
    drawRoad(canvas, Offset(cWidth+148, cHeight+148), Offset(cWidth+148, cHeight+99));
  }

  drawRoad(Canvas canvas, Offset start, Offset end){
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black54
      ..isAntiAlias = true
      ..strokeWidth = 5;
    canvas.drawLine(start, end, paint);
  }
  
  drawUserLocation(Canvas canvas){
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue[200]
      ..isAntiAlias = true
      ..strokeWidth = 3;
    if(currentLocation != null){
      canvas.drawCircle(Offset((700*currentLocation.dy), (700*currentLocation.dx)), 10, paint);
    }
  }

  drawRect(Canvas canvas, double cx, double cy, Color color) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..isAntiAlias = true;

    var offset = Offset(cx, cy);

    canvas.drawRect(Rect.fromCenter(center: offset, width: 50, height: 50), paint );
  }

  drawRectLTRB(Canvas canvas, Obj obj, Color color){
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..isAntiAlias = true;

    canvas.drawRect(Rect.fromLTWH(obj.cx, obj.cy, 50, 50), paint);


  }

  @override
  void paint(Canvas canvas, Size size) {
    //canvas.translate(55.613472, 49.297441);
    canvas.scale(1,1);


    drawMap(canvas);
    //drawMapManual(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}
