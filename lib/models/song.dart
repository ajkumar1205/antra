import 'package:on_audio_query/on_audio_query.dart';

class Song {
  final String title;
  final int id;
  final String artist;
  final int artistId;
  final String album;
  final int albumId;
  final String composer;
  final String genre;
  final String data;
  final int size;
  final Duration length;
  late final String artworkPath;
  bool favourite = false;

  Song({
    required this.title,
    required this.id,
    required this.data,
    required this.size,
    required this.length,
    this.artist = 'NIL',
    this.artistId = -1,
    this.album = 'NIL',
    this.albumId = -1,
    this.composer = 'NIL',
    this.genre = 'NIL',
    this.favourite = false,
  });
}
