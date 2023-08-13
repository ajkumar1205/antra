import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:flutter/material.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with SeekHandler, QueueHandler {
  static AudioPlayer _player = AudioPlayer();

  List<MediaItem> list = [];

  AudioPlayerHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player.setLoopMode(LoopMode.one);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> playMediaItem(MediaItem m) async {
    mediaItem.add(m);
    await _player.setAudioSource(AudioSource.file(m.extras!['path']));
    return await play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> seekBackward(bool begin) => _player.seekToPrevious();

  @override
  Future<void> seekForward(bool begin) => _player.seekToNext();

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.skipToPrevious,
        MediaAction.seek,
        MediaAction.skipToNext,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
