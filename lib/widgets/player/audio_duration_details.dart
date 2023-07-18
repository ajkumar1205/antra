import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/audioplayer_provider.dart';
import '../../design/color.dart';

class AudioDurationDetail extends StatelessWidget {
  const AudioDurationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context);
    return StreamBuilder<Duration>(
      stream: player.position(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Slider(
              value: snapshot.hasData
                  ? snapshot.data!.inSeconds.toDouble()
                  : 0.toDouble(),
              onChanged: (val) {},
              min: 0,
              max: (player.songDuration.inMilliseconds / 1000),
              divisions: player.songDuration.inMilliseconds ~/ 1000,
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
                    snapshot.hasData
                        ? "${snapshot.data!.inMinutes}:${(snapshot.data!.inSeconds) % 60}"
                        : "00:00",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  // LENGTH OF THE SONG
                  Text(
                    "${player.songDuration.inMinutes}:${(player.songDuration.inSeconds) % 60}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
