import 'package:audio_service/audio_service.dart';

class AudioHandlerState {
  final Duration pos;
  final PlaybackState state;
  final MediaItem item;

  const AudioHandlerState({
    required this.item,
    required this.pos,
    required this.state,
  });
}
