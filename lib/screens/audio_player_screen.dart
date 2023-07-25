import 'package:antra/design/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/player/play_pause_button.dart';
import '../widgets/player/audio_duration_details.dart';
import '../provider/audioplayer_provider.dart';
import '../widgets/player/audio_banner.dart';
import '../widgets/player/player_button_states.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  void showSheet(BuildContext context, AudioPlayerProvider player) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      builder: (context) => ListView(
        children: [
          ListTile(
            title: Text(
              "Title: ${player.getTitle}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Artist: ${player.getArtist}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Composer: ${player.getComposer}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Album: ${player.getAlbum}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context, listen: false);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: color,
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
          image: DecorationImage(
            image: AssetImage('assets/images/background-dark.jpg'),
            fit: BoxFit.cover,
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
                child: const AudioBanner(),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 38,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(190, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      player.getTitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  // ARTISTS NAMES
                  Container(
                    height: 35,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(190, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      player.getArtist,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PlayerButtonStates(onTap: showSheet),
                  const AudioDurationDetail(),
                  Stack(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Positioned(
                        top: 15,
                        left: MediaQuery.of(context).size.width / 2 - 105,
                        child: Container(
                          height: 50,
                          width: 210,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                iconSize: 35,
                                color: color,
                                highlightColor: Colors.transparent,
                                onPressed: () {},
                                icon: const Icon(Icons.fast_rewind_rounded),
                              ),
                              IconButton(
                                iconSize: 35,
                                color: color,
                                splashColor: Colors.transparent,
                                onPressed: () {},
                                icon: const Icon(Icons.fast_forward_rounded),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const PlayPauseButton()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
