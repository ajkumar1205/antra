import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../constants/hive.constants.dart';
import '../../models/playlist.dart';

Box data = Hive.box(settings);

Future<void> setSong(SongModel s) async {
  await data.put(lastPlayedSong, s);
}

Future<void> setPlaylist(Playlist pl) async {
  await data.put(lastPlayedList, pl);
}

SongModel get lastSong {
  return data.get(lastPlayedSong) as SongModel;
}

Playlist get lastPlaylist {
  return data.get(lastPlayedList) as Playlist;
}
