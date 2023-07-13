import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends ChangeNotifier {
  List<SongModel>? songs;
  var hasSongs = false;
  OnAudioQuery audioQuery = OnAudioQuery();

  Future<void> takePermission() async {
    var status = await audioQuery.permissionsStatus();
    while (!status) {
      status = await audioQuery.permissionsRequest();
    }
    if (!hasSongs) getSongs();
  }

  void getSongs() async {
    songs = await audioQuery.querySongs();
    hasSongs = true;
    notifyListeners();
  }
}
