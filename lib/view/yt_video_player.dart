import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YtVideoPlayer extends StatefulWidget {
  final String videoId;
  const YtVideoPlayer({super.key, required this.videoId});

  @override
  State<YtVideoPlayer> createState() => _YtVideoPlayerState();
}

class _YtVideoPlayerState extends State<YtVideoPlayer> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
_controller = YoutubePlayerController(
    initialVideoId: widget.videoId,
    flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
    ),
);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
    player: YoutubePlayer(
        controller: _controller,
    ),
    builder: (context, player){
        return Column(
            children: [
                // some widgets
                player,
                //some other widgets
            ],
        );}
    ),

    );
  }
}