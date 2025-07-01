import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_api_demo/viewmodel/yt_video_view_model.dart';

class YouTubeHomePage extends StatefulWidget {
    YouTubeHomePage({super.key, required this.videoId});
  String videoId;
  @override
  State<YouTubeHomePage> createState() => _YouTubeHomePageState();
}

class _YouTubeHomePageState extends State<YouTubeHomePage> {
  late YoutubePlayerController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<YtVideoViewModel>(context, listen: false)
        .getAllVideos('${widget.videoId}',
        'AIzaSyDP0p0SW6mILmMESW5TJlf-TMNCH-vT2TY')
        .then((_) {
      final firstVideoId = Provider.of<YtVideoViewModel>(context, listen: false)
          .playListItems[0]
          .videoId;
      _controller = YoutubePlayerController(
        initialVideoId: firstVideoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up
    super.dispose();
  }
  int selectedIndex=1;
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Scaffold(
      body: Center(child: CircularProgressIndicator()),
        )
        : YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          title: const Text('YouTube'),
          backgroundColor: Colors.red,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Provider.of<YtVideoViewModel>(context, listen: false)
                    .getAllVideos('PLrIXHGCtjCattbLuf5zNVobkJEG7IGk-T',
                    'AIzaSyDP0p0SW6mILmMESW5TJlf-TMNCH-vT2TY');
              },
            ),
            const SizedBox(width: 20),
            const Icon(Icons.account_circle),
          ],
        ),
        body: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Consumer<YtVideoViewModel>(
          builder: (context, ytVideoViewModel, _) {
            if (ytVideoViewModel.playListItems.isEmpty) {
              return const Center(child: Text("No videos found"));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  player, // Display player at top
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ytVideoViewModel.playListItems[selectedIndex].videoTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ytVideoViewModel.playListItems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _controller.load(ytVideoViewModel.playListItems[index].videoId);
                            setState(() {
                              selectedIndex=index;
                            });
                          },
                          child: Card(
                            color: selectedIndex ==index? Color(0xff0b4144).withValues(alpha: 0.25) : Colors.white,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            elevation: selectedIndex ==index? 0 :0.0,
                            child: ListTile(
                              leading: Image.network(
                                ytVideoViewModel.playListItems[index].thumbnailUrl,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                ytVideoViewModel.playListItems[index].videoTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(ytVideoViewModel.playListItems[index].channelName),
                              trailing: Icon( selectedIndex ==index? Icons.pause_circle : Icons.play_circle_fill,
                                  color: Colors.redAccent),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
