import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  void play(String path) async {
    await _player.setUrl(path);
    _player.play();
    notifyListeners();
  }

  Stream<Duration> position() {
    return _player.createPositionStream();
  }

  void pause() async {
    await _player.pause();
    notifyListeners();
  }

  void resumePlaying() async {
    await _player.play();
  }

  void stopAndChangeSong(String path) async {
    await _player.stop();
    _player.setUrl(path);
    _player.play();
    notifyListeners();
  }
}
