import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/sharedpreferences/last_played.dart';
import '../models/playlist.dart';
import '../constants/hive_constants.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  int? _songIndex;
  SongModel? _song;
  bool _playerInitialised = false;
  PlayList? _playlist;

  void init() {
    _player.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        notifyListeners();
      }
    });
    _playerInitialised = true;
  }

  void setIndex(int i) {
    _songIndex = i;
    notifyListeners();
  }

  int get songIndex {
    return _songIndex ?? LastPlayed.index;
  }

  set setSong(SongModel s) {
    _song = s;
    notifyListeners();
  }

  int get songId {
    return _song == null ? LastPlayed.songId : _song!.id;
  }

  Duration get songDuration {
    return Duration(milliseconds: _song != null ? _song!.duration! : 1);
  }

  String get getArtist {
    return _song == null ? LastPlayed.artist : _song!.artist!;
  }

  String get getTitle {
    return _song == null ? LastPlayed.title : _song!.title;
  }

  String get getComposer {
    return _song == null ? "" : _song!.composer!;
  }

  String get getAlbum {
    return _song == null ? "" : _song!.album!;
  }

  void setPlaylistAndAudioSource(PlayList pl) async {
    if (_playlist == pl) {
      return;
    }
    _playlist = pl;
    final settingBox = await database.openBox(settings);
    await settingBox.put(lastPlayedList, pl);
    await _player.setAudioSource(
      _playlist!.songs!,
      initialIndex: 0,
    );
    await _player.setShuffleModeEnabled(false);
    await _player.setLoopMode(LoopMode.all);
    notifyListeners();
  }

  void seekToPosition(Duration pos) async {
    await _player.seek(pos);
    await _player.play();
    notifyListeners();
  }

  void seek(int index) async {
    setIndex(index);
    await _player.seek(Duration.zero, index: index);
    await _player.play();
    notifyListeners();
  }

  void seekToNext() async {
    setIndex(_songIndex! + 1);
    await _player.seekToNext();
    await _player.play();
    notifyListeners();
  }

  void seekToPrevious() async {
    setIndex(_songIndex! - 1);
    await _player.seekToPrevious();
    await _player.play();
    notifyListeners();
  }

  void play() async {
    if (!_playerInitialised) init();
    await _player.setUrl(_song == null ? LastPlayed.songPath : _song!.data);
    _player.play();
    LastPlayed.setSongPath(_song!.data);
    LastPlayed.setTitle(_song!.title);
    LastPlayed.setArtist(_song!.artist!);
    LastPlayed.setSongLength(_song!.duration!);
    LastPlayed.setSongId(_song!.id);
    notifyListeners();
  }

  bool get playing {
    return _player.playing;
  }

  Stream<Duration> position() {
    return _player.createPositionStream();
  }

  void togglePlayer() async {
    if (_song == null && !_player.playing) {
      play();
      return;
    }
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
