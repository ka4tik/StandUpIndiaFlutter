import 'package:flutter/material.dart';
import 'package:standup_india_flutter/ComicVideosListScreen.dart';
import 'package:standup_india_flutter/YoutubePlayerScreen.dart';

class VideoThumbnail extends StatelessWidget {
  final String image;
  final String title;
  final String url;

  const VideoThumbnail({
    Key? key,
    required this.image,
    required this.title,
    required this.url
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
              builder: (context) => YoutubePlayerScreen(url: url),
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
