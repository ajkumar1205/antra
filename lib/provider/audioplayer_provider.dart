import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  void play(String path) async {
    await _player.setUrl(path);
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
