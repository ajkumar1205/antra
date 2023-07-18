import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/sharedpreferences/last_played.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  int? _songIndex;
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

  void setIndex(int i) {
    _songIndex = i;
    notifyListeners();
  }

  Future<int> get songIndex async {
    return _songIndex ?? await LastPlayed.index;
  }

  set setSong(SongModel s) {
    _song = s;
    notifyListeners();
  }

  int get songId {
    return _song == null ? 0 : _song!.id;
  }

  Duration get songDuration {
    return Duration(milliseconds: _song != null ? _song!.duration! : 1);
  }

  Future<String> get getArtist async {
    return _song == null ? await LastPlayed.artist : _song!.artist!;
  }

  Future<String> get getTitle async {
    return _song == null ? await LastPlayed.title : _song!.title;
  }

  void play() async {
    if (!_playerInitialised) init();
    await _player
        .setUrl(_song == null ? await LastPlayed.songPath : _song!.data);
    _player.play();
    LastPlayed.setSongPath(_song!.data);
    LastPlayed.setTitle(_song!.title);
    LastPlayed.setArtist(_song!.artist!);
    LastPlayed.setSongLength(_song!.duration!);
    notifyListeners();
  }

  bool get playing {
    return _player.playing;
  }

  Stream<Duration> position() {
    return _player.createPositionStream()
      ..listen((event) {
        LastPlayed.setPlayedDuration(event.inMilliseconds);
      });
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
