import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/audioplayer_provider.dart';
import '../../design/color.dart';

class AudioDurationDetail extends StatefulWidget {
  const AudioDurationDetail({super.key});

  @override
  State<AudioDurationDetail> createState() => _AudioDurationDetailState();
}

class _AudioDurationDetailState extends State<AudioDurationDetail> {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context);
    return StreamBuilder<Duration>(
      stream: player.position(),
      builder: (context, snapshot) {
        double value = snapshot.hasData
            ? snapshot.data!.inSeconds.toDouble()
            : 0.toDouble();
        return Column(
          children: [
            SongDurationSlider(value: value, player: player),
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
                      backgroundColor: Colors.black,
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  // LENGTH OF THE SONG
                  Text(
                    "${player.songDuration.inMinutes}:${(player.songDuration.inSeconds) % 60}",
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
      },
    );
  }
}

class SongDurationSlider extends StatefulWidget {
  const SongDurationSlider({
    super.key,
    required this.value,
    required this.player,
  });

  final double value;
  final AudioPlayerProvider player;

  @override
  State<SongDurationSlider> createState() => _SongDurationSliderState();
}

class _SongDurationSliderState extends State<SongDurationSlider> {
  double val = 0;
  @override
  Widget build(BuildContext context) {
    val = widget.value;
    return Slider(
      value: val,
      onChanged: (v) {
        setState(() {
          val = v;
        });
      },
      onChangeEnd: (val) {
        print("Position Should be $val");
        widget.player.seekToPosition(Duration(milliseconds: val.toInt()));
      },
      min: 0,
      max: (widget.player.songDuration.inMilliseconds / 1000),
      divisions: widget.player.songDuration.inMilliseconds ~/ 1000,
      thumbColor: color,
      activeColor: color,
    );
  }
}
