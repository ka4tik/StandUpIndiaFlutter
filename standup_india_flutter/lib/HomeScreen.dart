import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:standup_india_flutter/card.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomePageScreen";

  const HomeScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("StandUp India"),
      ),
      body: FutureBuilder<Widget>(
        future: body(context),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[snapshot.data!];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              const CircularProgressIndicator(),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  Future<List<dynamic>> fetch() async {
    var result = await http
        .get(Uri.parse("https://boiling-badlands-67720.herokuapp.com"));
    return jsonDecode(result.body);
  }

  Future<Widget> body(BuildContext context) async {
    var data = await fetch();

    return Expanded(
        child: Column(children: [
      const SizedBox(
        height: 6,
      ), //some top content

      Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return MyCard(
                    image: data[index]['posterPath'],
                    title: data[index]['title']);
              })),

      const SizedBox(
        height: 6,
      ), //some top content// some bottom content
    ]));
  }
}
