import 'dart:ffi';

import 'package:antra/design/color.dart';
import 'package:antra/provider/songlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../provider/audioplayer_provider.dart';

// import '../model/songs.dart';

class PlayerScreen extends StatelessWidget {
  final int songIndex;
  const PlayerScreen({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SongList>(context, listen: false);
    final player = Provider.of<AudioPlayerProvider>(context);
    final length = Duration(milliseconds: list.songs![songIndex].duration!);
    print(
        "??????????????????????????????????????????????????????\n??????????????????????????????????????????????????????\n??????????????????????????????????????????????????????");
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
                child: Hero(
                  tag: "audiobanner",
                  child: QueryArtworkWidget(
                    id: list.songs![songIndex].id,
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
            ),
            StreamBuilder<Duration>(
              stream: player.position(),
              builder: (context, snapshot) {
                return Expanded(
                  child: Column(
                    children: [
                      // TITLE OF THE SONG
                      Text(
                        list.songs![songIndex].title,
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
                          list.songs![songIndex].artist!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // AUDIO TIME SLIDER
                      const SizedBox(height: 50),
                      Slider(
                        value: snapshot.hasData
                            ? snapshot.data!.inSeconds.toDouble()
                            : 0.toDouble(),
                        onChanged: (val) {},
                        min: 0,
                        max: (list.songs![songIndex].duration! / 1000),
                        divisions: list.songs![songIndex].duration! ~/ 1000,
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
                              // "${current!.inMinutes}:${current!.inSeconds % 60}",
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
                              // "${length!.inMinutes}:${length!.inSeconds % 60}",
                              "${length.inMinutes}:${(length.inSeconds) % 60}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_left),
                          ),
                          const PlayPauseButton(),
                          IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_right),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    // required this.player,
  });

  // final AudioPlayerProvider player;

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context);
    return CircleAvatar(
      // radius: 40,
      minRadius: 0,
      backgroundColor: color,
      child: IconButton(
        iconSize: 60,
        color: Colors.black,
        onPressed: () {
          player.togglePlayer();
        },
        icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
