import 'package:flutter/material.dart';
import 'package:standup_india_flutter/HomeScreen.dart';
import 'package:standup_india_flutter/LightHomeScreen.dart';

class RouteGenerator {
  static const _id = 'RouteGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    // log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case HomeScreen.id:
        return _route( LightHomeScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('ROUTE \n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
