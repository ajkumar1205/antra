import 'package:antra/provider/songlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../widgets/player/play_pause_button.dart';
import '../widgets/player/audio_duration_details.dart';

class PlayerScreen extends StatelessWidget {
  final int songIndex;
  const PlayerScreen({super.key, required this.songIndex});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SongList>(context, listen: false);
    final length = Duration(milliseconds: list.songs![songIndex].duration!);
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
            Expanded(
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
                  AudioDurationDetail(songIndex: songIndex, length: length),
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
