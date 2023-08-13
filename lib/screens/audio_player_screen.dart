import 'package:antra/design/color.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/player/play_pause_button.dart';
import '../widgets/player/audio_duration_details.dart';
import '../widgets/player/audio_banner.dart';
import '../widgets/player/player_button_states.dart';
import '../utils/audioplayer_handler_helper.dart';
import '../utils/audio_stream_combined.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final handler = AudioHandlerHelper.audioHandler;

  void showSheet(BuildContext context, MediaItem? item) {
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
              "Title: ${item != null ? item.title : ""}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Artist: ${item != null ? item.artist : ""}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Composer: ${item != null ? item.extras!['composer'] : ""}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Album: ${item != null ? item.album : ""}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Album: ${item != null ? item.genre : ""}",
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
      body: StreamBuilder(
        stream: Rx.combineLatest3(
          AudioService.position,
          handler.mediaItem,
          handler.playbackState,
          (pos, item, state) => AudioHandlerState(
            item: item!,
            pos: pos,
            state: state,
          ),
        ),
        builder: (context, snapshot) {
          final state = snapshot.hasData ? snapshot.data!.state : null;
          final pos = snapshot.hasData ? snapshot.data!.pos : null;
          final item = snapshot.hasData ? snapshot.data!.item : null;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[700]!,
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                  Colors.black,
                ],
              ),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/background-dark.jpg'),
              //   fit: BoxFit.cover,
              // ),
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
                    child: AudioBanner(item: item),
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
                        // decoration: BoxDecoration(
                        //   color: const Color.fromARGB(190, 255, 255, 255),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Text(
                          item != null ? item.title : "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
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
                        // decoration: BoxDecoration(
                        //   color: const Color.fromARGB(190, 255, 255, 255),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Text(
                          item != null ? item.artist! : "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      PlayerButtonStates(onTap: showSheet),
                      AudioDurationDetail(pos: pos, item: item),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    icon:
                                        const Icon(Icons.fast_forward_rounded),
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
          );
        },
      ),
    );
  }
}
