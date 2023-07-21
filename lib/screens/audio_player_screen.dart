import 'package:antra/design/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/player/play_pause_button.dart';
import '../widgets/player/audio_duration_details.dart';
import '../provider/audioplayer_provider.dart';
import '../widgets/player/audio_banner.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // late final AnimationController _controller = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 3),
  // )..repeat();

  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: const Offset(-1.5, 0),
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.linear,
  // ));

  // @override
  // void initState() {
  //   super.initState();
  // }

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
          image: DecorationImage(
            image: AssetImage('assets/images/background-dark.jpeg'),
            fit: BoxFit.cover,
          ),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      player.getTitle,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w900,
                        color: color,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      player.getArtist,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  // AUDIO TIME SLIDER
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.repeat,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shuffle,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.sync_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
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

class Check extends StatelessWidget {
  const Check({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 40,
                    color: color,
                    onPressed: () {},
                    icon: const Icon(Icons.fast_rewind_rounded),
                  ),
                  IconButton(
                    iconSize: 40,
                    color: color,
                    onPressed: () {},
                    icon: const Icon(Icons.fast_forward_rounded),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: -10,
              child: PlayPauseButton(),
            ),
          ],
        ),
      ),
    );
  }
}
