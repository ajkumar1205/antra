import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/player/play_pause_button.dart';
import '../widgets/player/audio_duration_details.dart';
import '../provider/audioplayer_provider.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
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
            colors: [
              Colors.white,
              Colors.grey,
              Colors.black87,
              Colors.black,
            ],
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
                    id: player.songId,
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
            Expanded(
              child: Column(
                children: [
                  // TITLE OF THE SONG
                  FutureBuilder(
                    future: player.getTitle,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      );
                    },
                  ),
                  // ARTISTS NAMES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: FutureBuilder(
                      future: player.getArtist,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        );
                      },
                    ),
                  ),
                  // AUDIO TIME SLIDER
                  const SizedBox(height: 50),
                  const AudioDurationDetail(),
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
            ),
          ],
        ),
      ),
    );
  }
}
