import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<Widget> maps = new List();

  generateData(){
    for(int i =0;i<10;i++){
      var tile = ListTile(title: Text('Map Name'),onTap: (){Navigator.of(context).pushNamed('/map');},);
      var divider = Container(width: 1000,height: 1,color: Colors.grey,);
      maps.add(tile);
      maps.add(divider);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateData();
  }

  @override
  Widget build(BuildContext context) {
    generateData();
    return Scaffold(
      appBar: AppBar(title: Text('Карты помещений'),),
      body: ListView(
        children: maps
      ),
    );
  }
}
