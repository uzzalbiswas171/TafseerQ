import 'package:flutter/material.dart';
import 'package:yt_api_demo/model/yt_video.dart';
import 'package:yt_api_demo/view/yt_video_player.dart';

class YouTubeVideoCard extends StatelessWidget {
 final YtVideo ytVideo;

  const YouTubeVideoCard({super.key,
    required this.ytVideo
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Card(
          margin: EdgeInsets.only(left: 10,right: 10,top: 10),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(ytVideo.thumbnailUrl),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 5),
                child: Text(
                  maxLines: 2,
                  ytVideo.videoTitle,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 10),
                child: Text(
                  ytVideo.channelName,
                ),
              ),
            ],
          ),
        ),

        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> YtVideoPlayer(videoId: ytVideo.videoId)));
        }, icon: Icon(Icons.play_circle, color: Colors.white, size: 30,))
      ],
    );
  }
}