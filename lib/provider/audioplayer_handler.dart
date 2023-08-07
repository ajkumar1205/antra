import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with SeekHandler, QueueHandler {
  static AudioPlayerHandler _instance = AudioPlayerHandler._internal();

  AudioPlayerHandler._internal();

  factory AudioPlayerHandler() {
    return _instance;
  }

  Future<void> play() async {}
}
