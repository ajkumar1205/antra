import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';

import '../provider/audioplayer_handler.dart';

class AudioHandlerHelper {
  static AudioPlayerHandler? _audiohandler;
  static bool initialised = false;

  static Future<void> initHandler() async {
    if (!initialised) {
      _audiohandler = await AudioService.init(
        builder: () => AudioPlayerHandler(),
        config: AudioServiceConfig(
          androidNotificationChannelName: 'antra',
          androidNotificationChannelId: 'com.antra.app',
          androidNotificationIcon: 'mipmap/launcher_icon',
          notificationColor: Colors.brown,
          artDownscaleHeight: 40,
          artDownscaleWidth: 40,
        ),
      );
      initialised = true;
    } else {
      return;
    }
  }

  static AudioPlayerHandler get audioHandler => _audiohandler!;
}
