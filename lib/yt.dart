import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class video extends StatefulWidget {

  String url;

   video(this.url);

  @override
  _videoState createState() => _videoState(this.url);
}

class _videoState extends State<video> {
  String videoURL = "https://www.youtube.com/watch?v=oxsBSCf5-B8&list=RDoxsBSCf5-B8&start_radio=1";

  String url;
  _videoState(this.url);
  YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: 'oxsBSCf5-B8');

  @override
  void initState() {

    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)
    );

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.stretch,
              children: <Widget>[
                YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                    aspectRatio:16/9,

                    showVideoProgressIndicator: true,
                  ),
                  builder:(context,player){
                    return Column(
                      children: <Widget>[
                        player
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}
