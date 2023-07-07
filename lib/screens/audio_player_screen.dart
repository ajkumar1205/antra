import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';

// import '../model/songs.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel song;
  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var value = 0.0;

  Duration? length;
  Duration? current;

  AudioPlayer? player;

  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
    play();
  }

  void play() async {
    await player!.play(DeviceFileSource(widget.song.data));
    length = await player!.getDuration();
    current = await player!.getCurrentPosition();
    print("The song to be played ${widget.song.data}");
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  void stop() async {
    await player!.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black87,
                ),
                child: QueryArtworkWidget(
                  id: widget.song.id,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.fill,
                  artworkBorder: BorderRadius.circular(20),
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 150,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // TITLE OF THE SONG
                  Text(
                    widget.song.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  // ARTISTS NAMES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      widget.song.artist!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // AUIDO TIME SLIDER
                  const SizedBox(height: 50),
                  Slider(
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        value = val;
                      });
                    },
                    min: 0,
                    max: (widget.song.duration! / 1000),
                    divisions: widget.song.duration! ~/ 1000,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // CURRENT TIME OF AUDIO

                        Text(
                          "${current!.inMinutes}:${current!.inSeconds % 60}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        // LENGTH OF THE SONG
                        Text(
                          "${length!.inMinutes}:${length!.inSeconds % 60}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
