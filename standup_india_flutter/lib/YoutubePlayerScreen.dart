import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatelessWidget {
  static const id = 'YoutubePlayerScreen';
  final String url;

  const YoutubePlayerScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = url.split("watch?v=")[1];
    print(id);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return YoutubePlayerBuilder(
        player: YoutubePlayer(
        controller: _controller,
    ),
    builder: (context, player) {
      return Column(
        children: [
          // some widgets
          player,
          //some other widgets
        ],
      );
    });

    throw UnimplementedError();
  }

}