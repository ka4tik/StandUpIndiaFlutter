
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(
              'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: const Text(
                'Text Message',
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              )),
        ],
      ),
    );
  }

}