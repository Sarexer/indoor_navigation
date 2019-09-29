import 'package:flutter/material.dart';
import 'package:indoor_navigation/deikstra/deikstra.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<Widget> maps = new List();

  generateData(){
    for(int i =0;i<1;i++){
      var tile = ListTile(title: Text('Example Name'),onTap: (){Navigator.of(context).pushNamed('/map');},);
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
    //deikstra();
    return Scaffold(
      appBar: AppBar(title: Text('Карты помещений'),),
      body: ListView(
        children: maps
      ),
    );
  }

  deikstra(){
    Node nodeA = new Node("A");
    Node nodeB = new Node("B");
    Node nodeC = new Node("C");
    Node nodeD = new Node("D");
    Node nodeE = new Node("E");
    Node nodeF = new Node("F");

    nodeA.addDestination(nodeB, 10);
    nodeA.addDestination(nodeC, 15);

    nodeB.addDestination(nodeD, 12);
    nodeB.addDestination(nodeF, 15);

    nodeC.addDestination(nodeE, 10);

    nodeD.addDestination(nodeE, 2);
    nodeD.addDestination(nodeF, 1);

    nodeF.addDestination(nodeE, 5);

    Graph graph = new Graph();

    graph.addNode(nodeA);
    graph.addNode(nodeB);
    graph.addNode(nodeC);
    graph.addNode(nodeD);
    graph.addNode(nodeE);
    graph.addNode(nodeF);

    graph = Graph.calculateShortestPathFromSource(graph, nodeA);

    print('dfd');
  }
}
