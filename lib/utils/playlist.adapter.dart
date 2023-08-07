import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import '../models/playlist.dart';

class PlayListAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 0;

  @override
  Playlist read(BinaryReader reader) {
    return Playlist(
      title: reader.readString(),
      description: reader.readString(),
      artist: reader.readString(),
      oneArtist: reader.readBool(),
      songs: reader.read() as ConcatenatingAudioSource?,
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description!);
    writer.writeString(obj.artist!);
    writer.writeBool(obj.oneArtist);
    writer.write(obj.songs);
  }
}
