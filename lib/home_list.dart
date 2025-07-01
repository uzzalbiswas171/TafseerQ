import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_api_demo/view/video_home.dart';
import 'package:yt_api_demo/viewmodel/yt_video_view_model.dart';

class YoutubeListHome extends StatefulWidget {
  const YoutubeListHome({super.key});

  @override
  State<YoutubeListHome> createState() => _YoutubeListHomeState();
}

class _YoutubeListHomeState extends State<YoutubeListHome> {
  @override
  void initState() {
    Provider.of<YtVideoViewModel>(context, listen: false)
        .getAllYoutubeThumbnailList('UC3kG-1vBavgcATRxs0XRFQw',
        'AIzaSyDP0p0SW6mILmMESW5TJlf-TMNCH-vT2TY');
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<YtVideoViewModel>(
        builder: (context, value, child) =>value.youtubeThumbnailList==null?Center(child: CircularProgressIndicator(),) : SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GridView.builder(
            itemCount: value.youtubeThumbnailList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 140,
            ), itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                //PLrIXHGCtjCattbLuf5zNVobkJEG7IGk-T
                // Provider.of<YtVideoViewModel>(context, listen: false)
                //     .getAllVideos('${youTubeVideId[index]}',
                //     'AIzaSyDP0p0SW6mILmMESW5TJlf-TMNCH-vT2TY');
                Navigator.push(context, MaterialPageRoute(builder: (context) =>YouTubeHomePage(videoId: "${value.youtubeThumbnailList[index]['id']}") ,));
              },
             child: Card(
               child: Column(
                 children: [
                   Expanded(
                     flex: 1,
                     //     child: Container(),
                  child: Image.network(value.youtubeThumbnailList[index]['snippet']['thumbnails']['maxres']['url'],fit: BoxFit.fill,),
                   ),
                   //   Text("data")
                 Text(value.youtubeThumbnailList[index]['snippet']['title'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),) ,
                 ],
               ),
             ),

            );
          },),
        ),
      ),
    );
  }

}
