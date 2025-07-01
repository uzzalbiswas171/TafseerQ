import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as Console;

import 'package:http/http.dart' as http;
import 'package:yt_api_demo/const/app_const.dart';
import 'package:yt_api_demo/model/yt_video.dart';



import 'dart:convert';
import 'package:http/http.dart' as http;


















class YtApiServices {
 // Future<List<Map<String, dynamic>>>

   fetchAllPlaylistItems(String playlistId, String apiKey) async {
    String baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems";
    String nextPageToken = '';
     List<YtVideo> allVideos = [];

    do {
      final response = await http.get(Uri.parse(
          "$baseUrl?part=snippet&maxResults=50&playlistId=$playlistId&pageToken=$nextPageToken&key=$apiKey"
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Console.log("---------------------------------------------- ${data}");
        final items = data['items'] as List;

        for (var videoData in items) {
          YtVideo video = YtVideo(videoId: videoData['snippet']['resourceId']['videoId'], videoTitle: videoData['snippet']['title'], thumbnailUrl: videoData['snippet']['thumbnails']['maxres']['url'], viewsCount: "100k", channelName: videoData['snippet']['channelTitle']);

          allVideos.add(video);
          // allVideos.add({
          //   'title': item['snippet']['title'],
          //   'videoId': item['snippet']['resourceId']['videoId'],
          //   'thumbnail': item['snippet']['thumbnails']['high']['url'],
          // });
        }
        nextPageToken = data['nextPageToken'] ?? '';
      } else {
        throw Exception("Failed to fetch playlist videos: ${response.body}");
      }

    } while (nextPageToken.isNotEmpty);

    return allVideos;
  }






   String nextPageToken = '';
   List  youtubeThumbnailList = [];
   fetchAllYoutubeThumbnail(String playlistId, String apiKey) async {
     String baseUrl = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=${playlistId}&maxResults=100&key=${apiKey}";
     try{
       final response = await http.get(Uri.parse(
           "$baseUrl"));

       if (response.statusCode == 200) {
         final data = json.decode(response.body);
         final items = data['items'];
         Console.log("---------------------------------------------- ${items[0]['id']}");
         // for (var videoData in items) {
         //   YoutubeThumbnail video = YoutubeThumbnail(thumbnailsId: videoData['items']['id'], thumbnailsTitle: videoData['items']['snippet']['title'], thumbnailUrl: videoData['items']['snippet']['thumbnails']['maxres']['url']);
         //   youtubeThumbnailList.add(video);
         // }
         youtubeThumbnailList=items;
       } else {
         throw Exception("Failed to fetch playlist videos: ${response.body}");
       }
     }catch(e){
       Console.log("---------------------------------------------- ${e}");
     }

     return youtubeThumbnailList;
   }


}

