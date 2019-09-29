

import 'dart:collection';

class Kamnevoyager{
  main(){
    Graph graph = Graph(10);

    Queue<State> states = Queue();

    State state;


  }
}
class State{
  int cityNum;
  int nextIndex;
  bool isStartPoint;
  State prev;

  State(this.prev, this.cityNum, {this.isStartPoint = false});

  int calculateLength(Graph graph){
    State current = this;
    int sum = 0;

    while(current.prev != null){
      sum+=graph.getEdge(current.prev.cityNum, current.cityNum);
      current = current.prev;
    }

    return sum;
  }

  @override
  String toString() {
    // TODO: implement toString
    if(prev == null){
      return cityNum.toString();
    }else{
      return '${prev.toString()} ${cityNum.toString()}';
    }
  }

}

class Graph{
  int count;
  List<List<int>> matrix;
  List<bool> marks;

  Graph(this.count){
    matrix = List();
    marks = List();
  }

  setEdge(int a, int b, int weight){
    matrix[a][b] = weight;
    matrix[b][a] = weight;
  }

  int getEdge(int a, int b){
    return matrix[a][b];
  }

  bool hasEdge(int a, int b){
    return matrix[a][b] != 0;
  }

  static Graph load(){

  }

  bool enter(int pos){
    if(marks[pos]){
      return false;
    }else{
      marks[pos] = true;
      return true;
    }
  }

  void leave(int pos){
    marks[pos] = false;
  }

  bool allVisited(){
    for(int i =0;i<marks.length;i++){
      if(!marks[i]){
        return false;
      }
    }
    return true;
  }
}