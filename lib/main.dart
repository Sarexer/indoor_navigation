import 'package:flutter/material.dart';
import 'package:indoor_navigation/pages/map_page.dart';
import 'package:indoor_navigation/pages/maps_page.dart';

void main() => runApp(MyApp());


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/maps':
        return MaterialPageRoute(builder: (_) => MapsPage());
      case '/map':
      // Validation of correct data type
        return MaterialPageRoute(builder: (_) => MapPage());

      default:
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapsPage(),
      //initialRoute: '/maps',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
