import 'dart:collection';

class Graph{
  var nodes = HashSet<Node>();

  addNode(Node nodeA){
    nodes.add(nodeA);
  }

  static Graph calculateShortestPathFromSource(Graph graph, Node source){
    source.distance = 0;

    Set<Node> settledNodes = new HashSet<Node>();
    Set<Node> unsettledNodes = new HashSet<Node>();

    unsettledNodes.add(source);

    while(unsettledNodes.length != 0){
      Node currentNode = getLowestDistanceNode(unsettledNodes);
      unsettledNodes.remove(currentNode);
      for(var pair in currentNode.adjacentNodes.entries){
        Node adjacentNode = pair.key;
        int edgeWeight = pair.value;
        if(!settledNodes.contains(adjacentNode)){
          calculateMinimumDistance(adjacentNode, edgeWeight, currentNode);
          unsettledNodes.add(adjacentNode);
        }
      }
      settledNodes.add(currentNode);
    }
    return graph;
  }

  static Node getLowestDistanceNode(Set<Node> unsettledNodes){
    Node lowestDistanceNode = null;
    int lowestDistance = 10000000000;
    for (var node in unsettledNodes) {
      int nodeDistance = node.distance;
      if(nodeDistance < lowestDistance){
        lowestDistance = nodeDistance;
        lowestDistanceNode = node;
      }
    }

    return lowestDistanceNode;
  }

  static calculateMinimumDistance(Node evaluationNode, int edgeWeight, Node sourceNode){
    int sourceDistance = sourceNode.distance;
    if(sourceDistance+edgeWeight < evaluationNode.distance){
      evaluationNode.distance = sourceDistance+edgeWeight;
      var shortestPath = List();

      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;
    }
  }

}

class Node{
  String name;
  var shortestPath = List();
  int distance = 10000000000;
  HashMap<Node, int> adjacentNodes = HashMap();

  addDestination(Node destination, int distance){
    adjacentNodes.putIfAbsent(destination, ()=>distance);
  }

  Node(this.name);
}