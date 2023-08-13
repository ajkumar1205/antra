import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../../design/color.dart';
import '../../utils/audioplayer_handler_helper.dart';

class AudioDurationDetail extends StatelessWidget {
  final Duration? pos;
  final MediaItem? item;
  const AudioDurationDetail({
    super.key,
    required this.pos,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: pos != null ? pos!.inSeconds.toDouble() : 0,
          onChanged: (v) {
            AudioHandlerHelper.audioHandler.seek(Duration(seconds: v.toInt()));
          },
          min: 0,
          max: item != null ? item!.duration!.inSeconds.toDouble() : 1.0,
          divisions: item != null ? item!.duration!.inSeconds : 1,
          thumbColor: color,
          activeColor: color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CURRENT TIME OF AUDIO
              Text(
                pos != null
                    ? "${pos!.inMinutes}:${(pos!.inSeconds) % 60}"
                    : "00:00",
                style: const TextStyle(
                  backgroundColor: Colors.black,
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              // LENGTH OF THE SONG
              Text(
                item != null
                    ? "${item!.duration!.inMinutes}:${(item!.duration!.inSeconds) % 60}"
                    : "00:00",
                style: const TextStyle(
                  backgroundColor: Colors.black,
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
