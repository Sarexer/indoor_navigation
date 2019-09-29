import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:indoor_navigation/model/custom_painter.dart';
import 'package:indoor_navigation/model/pair.dart';
import 'package:location/location.dart';
import 'package:rubber/rubber.dart';
import 'package:http/http.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;
  static double scale = 1;
  var terr = [
    Dot(55.612260, 49.296620),
    Dot(55.611760, 49.296589),
    Dot(55.612486, 49.298052)
  ];

  var location = new Location();

  Map<String, double> userLocation;

  Dot translatedLocation;

  get currentLatitude => userLocation['latitude'].toDouble();

  get currentLongitude => userLocation['longitude'].toDouble();

  get appbartext =>
      '${translatedLocation.dx.toStringAsFixed(2)}   ${translatedLocation.dy.toStringAsFixed(2)}';

  get appbartext1 => '${currentLatitude}   ${currentLongitude}';

  translateLocation() {
    var fullWidth = calcWidth(terr[0], terr[2]);
    var fullHeight = calcWidth(terr[0], terr[1]);

    var capWidth = calcWidth(terr[0], Dot(terr[0].dx, currentLongitude));
    var capHeight = calcWidth(terr[0], Dot(currentLatitude, terr[0].dy));

    var dx = capWidth / fullWidth;
    var dy = capHeight / fullHeight;

    translatedLocation = Dot(dx, dy);
    print('${translatedLocation.dx}   ${translatedLocation.dy}');
  }

  calcWidth(Dot start, Dot end) {
    return sqrt(pow(start.dx - end.dx, 2) + pow(start.dy - end.dy, 2));
  }

  loadMap() async{
    String url = "sdfsdfdf";
    Response response = await get(url);
    setState(() {
      var map = json.decode(response.body);
    });
  }



  @override
  void initState() {
    loadMap();
    // TODO: implement initState
    _controller = RubberAnimationController(
      vsync: this, // Thanks to the mixin
    );
    super.initState();
    getLocation();
    location.onLocationChanged().listen((value) {
      setState(() {
        userLocation = value;
        translateLocation();
        print(
            '${userLocation['latitude'].toDouble()}  ${userLocation['longitude'].toDouble()}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map Name'),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: CustomPaint(
              size: Size(screenSize.width, screenSize.height),
              painter: MyPainter(screenSize, translatedLocation),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(onPressed: (){_showModalSheet();},icon: Icon(Icons.keyboard_arrow_up),),
          ),

        ],
      )
    );
  }

  generateOrders(){
    List<Widget> orders = List<Widget>();

    orders.add(ListTile(title: Text('Построить маршрут'),leading: Icon(Icons.navigation),
      onTap: (){
        Navigator.pop(context);
      },));

    for(int i =0;i<1;i++){
      var order = ListTile(title: Text('Забрать детали с цеха А'), subtitle: Text('Нужно взять 10 шестерней и отвезти их в цех Е'),);
      var order1 = ListTile(title: Text('Забрать детали с цеха С'), subtitle: Text('Взять в цехе С 5 труб 5 профиля и отвезти в цех В'),);
      var order2 = ListTile(title: Text('Забрать детали с цеха С'), subtitle: Text('Взять в цехе С 10 труб 3 профиля и отвезти в цех D'),);
      var order3 = ListTile(title: Text('Заказ'), subtitle: Text('Отвези вот это вот туда'),);
      var order4 = ListTile(title: Text('Заказ'), subtitle: Text('Отвези вот это вот туда'),);
      var order5 = ListTile(title: Text('Заказ'), subtitle: Text('Отвези вот это вот туда'),);
      var order6 = ListTile(title: Text('Заказ'), subtitle: Text('Отвези вот это вот туда'),);
      var divider = Container(height: 1, width: 1000,color: Colors.grey,);

      orders.add(order);
      orders.add(divider);
      orders.add(order1);
      orders.add(divider);
      orders.add(order2);
      orders.add(divider);
    }

    return orders;
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: ListView(
              children: generateOrders(),
            ),
          );
        });
  }

  getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    setState(() {
      userLocation = currentLocation;
      translateLocation();

      print(
          '${userLocation['latitude'].toDouble()}  ${userLocation['longitude'].toDouble()}');
    });
  }
}
