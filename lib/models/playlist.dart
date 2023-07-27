import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

@HiveType(typeId: 0)
class PlayList extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? artist;

  @HiveField(3, defaultValue: false)
  bool oneArtist;

  @HiveField(4)
  ConcatenatingAudioSource? songs = ConcatenatingAudioSource(
    children: [],
    shuffleOrder: DefaultShuffleOrder(
      random: Random(DateTime.now().millisecond),
    ),
  );

  PlayList({
    required this.title,
    required this.songs,
    this.description,
    required this.oneArtist,
    this.artist,
  });

  PlayList.fromList({
    required this.title,
    required this.description,
    required this.oneArtist,
    this.artist,
    required List<SongModel> list,
  }) {
    list.forEach(
      (song) {
        songs!.children.add(
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
      },
    );
  }
}

class PlayListAdapter extends TypeAdapter<PlayList> {
  @override
  final int typeId = 0;

  @override
  PlayList read(BinaryReader reader) {
    return PlayList(
      title: reader.readString(),
      description: reader.readString(),
      artist: reader.readString(),
      oneArtist: reader.readBool(),
      songs: reader.read() as ConcatenatingAudioSource?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayList obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description!);
    writer.writeString(obj.artist!);
    writer.writeBool(obj.oneArtist);
    writer.write(obj.songs);
  }
}
