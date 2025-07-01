import 'package:flutter/material.dart';
import 'package:yt_api_demo/model/yt_video.dart';
import 'package:yt_api_demo/services/yt_api_services.dart';

class YtVideoViewModel extends ChangeNotifier{

 //  List<YtVideo> _playListItems = [];
 //
 //  List<YtVideo> get playListItems => _playListItems;
 //
 // getAllVideos()async{
 //
 // // _playListItems = await YtApiServices().getAllVideosFromPlaylist();
 //  _playListItems = await YtApiServices().getAllVideosFromPlaylist();
 //  notifyListeners();
 // }

  List<YtVideo> _playListItems = [];

  List<YtVideo> get playListItems => _playListItems;

 getAllVideos(String playlistId, String apiKey)async{

 // _playListItems = await YtApiServices().getAllVideosFromPlaylist();
  _playListItems = await YtApiServices().fetchAllPlaylistItems(playlistId, apiKey);
  notifyListeners();
 }


  List youtubeThumbnailList = [];
 getAllYoutubeThumbnailList(String playlistId, String apiKey)async{
 // _playListItems = await YtApiServices().getAllVideosFromPlaylist();
   youtubeThumbnailList = await YtApiServices().fetchAllYoutubeThumbnail(playlistId, apiKey);
  notifyListeners();
 }


}