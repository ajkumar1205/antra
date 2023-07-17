import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/sharedpreferences/last_played.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  SongModel? _song;
  bool _playerInitialised = false;

  void init() {
    _player.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        togglePlayer();
      }
    });
    _playerInitialised = true;
  }

  set setSong(SongModel s) {
    _song = s;
    notifyListeners();
  }

  int get songId {
    return _song == null ? 0 : _song!.id;
  }

  Duration get songDuration {
    return Duration(milliseconds: _song!.duration!);
  }

  String get getArtist {
    return _song == null ? LastPlayed.artist : _song!.artist!;
  }

  String get getTitle {
    return _song == null ? LastPlayed.title : _song!.title;
  }

  void play() async {
    if (!_playerInitialised) init();
    await _player.setUrl(_song == null ? LastPlayed.songPath : _song!.data);
    _player.play();
    notifyListeners();
  }

  bool get playing {
    return _player.playing;
  }

  Stream<Duration> position() {
    return _player.createPositionStream();
  }

  void togglePlayer() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      _player.play();
    }
    notifyListeners();
  }

  void resumePlaying() async {
    await _player.play();
  }
}
