import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/audioplayer_provider.dart';
import '../../design/color.dart';
import '../../functions/sharedpreferences/last_played.dart';
import '../../screens/audio_player_screen.dart';

class RoundedBottomBar extends StatefulWidget {
  const RoundedBottomBar({
    super.key,
  });

  @override
  State<RoundedBottomBar> createState() => _RoundedBottomBarState();
}

class _RoundedBottomBarState extends State<RoundedBottomBar> {
  @override
  void initState() {
    super.initState();
    initialisation();
  }

  void initialisation() async {
    await LastPlayed.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.black,
      ),
      height: 72,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          Consumer<AudioPlayerProvider>(builder: (context, player, child) {
            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PlayerScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 20, left: 25),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 201,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player.getTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                player.getArtist,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(maxWidth: 10),
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              constraints: const BoxConstraints(maxWidth: 10),
                              padding: const EdgeInsets.all(0),
                              icon: Icon(
                                player.playing ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                player.togglePlayer();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 36,
                  child: SizedBox(
                    height: 2,
                    width: MediaQuery.of(context).size.width - 60,
                    child: StreamBuilder<Duration>(
                      stream: player.position(),
                      builder: (context, snapshot) {
                        double val = snapshot.hasData
                            ? snapshot.data!.inMilliseconds /
                                player.songDuration.inMilliseconds
                            : 0.0;
                        return LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          value: val,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // AnimatedContainer(
              //   duration: const Duration(milliseconds: 400),
              Icon(
                Icons.home,
                size: 25,
                color: bgColor,
              ),
              // ),
              Icon(
                Icons.shuffle,
                size: 25,
                color: bgColor,
              ),
              Icon(
                Icons.list,
                size: 25,
                color: bgColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
