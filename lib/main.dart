import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_api_demo/home_list.dart' show YoutubeListHome;
import 'package:yt_api_demo/view/video_home.dart';
import 'package:yt_api_demo/viewmodel/yt_video_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<YtVideoViewModel>(create: (_)=> YtVideoViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
         home:YoutubeListHome(),
        //  home: YouTubeHomePage(),
      ),
    );
  }
}

