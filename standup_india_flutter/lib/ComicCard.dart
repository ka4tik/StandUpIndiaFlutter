import 'package:flutter/material.dart';
import 'package:standup_india_flutter/ComicVideosListScreen.dart';

class MyCard extends StatelessWidget {
  final String image;
  final String title;

  const MyCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print("Container was tapped");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComicVideosList(comic: title),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.network(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                )),
          ],
        ));
  }
}
