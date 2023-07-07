import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  List<SongModel>? songs;
  var hasSongs = false;
  OnAudioQuery audioQuery = OnAudioQuery();

  void takePermission() async {
    var status = await audioQuery.permissionsStatus();
    while (!status) {
      status = await audioQuery.permissionsRequest();
    }
    getSongs();
  }

  void getSongs() async {
    songs = await audioQuery.querySongs();
    hasSongs = true;
    notifyListeners();
  }
}
