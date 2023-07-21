import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SongList extends ChangeNotifier {
  List<SongModel>? songs;
  var hasSongs = false;
  OnAudioQuery audioQuery = OnAudioQuery();
  ConcatenatingAudioSource? list;

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

  ConcatenatingAudioSource? get shuffleableList {
    if (list == null && !hasSongs) return null;
    if (list == null) {
      songs!.forEach((song) {
        list!.add(
          AudioSource.uri(
            Uri.parse(song.data),
            tag: MediaItem(
              id: song.id.toString(),
              title: song.title,
              artist: song.artist,
              extras: {
                'artWork': QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                )
              },
            ),
          ),
        );
      });
    }
    return list;
  }
}
