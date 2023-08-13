import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../utils/audioplayer_handler_helper.dart';

class PlayerButtonStates extends StatefulWidget {
  final Function onTap;
  const PlayerButtonStates({
    super.key,
    required this.onTap,
  });

  @override
  State<PlayerButtonStates> createState() => _PlayerButtonStatesState();
}

class _PlayerButtonStatesState extends State<PlayerButtonStates> {
  LoopMode _mode = LoopMode.off;
  bool _shuffle = false;

  AudioHandler handler = AudioHandlerHelper.audioHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              if (_mode == LoopMode.off) {
                setState(() {
                  _mode = LoopMode.one;
                });
              } else if (_mode == LoopMode.one) {
                setState(() {
                  _mode = LoopMode.all;
                });
              } else {
                setState(() {
                  _mode = LoopMode.off;
                });
              }
            },
            icon: Icon(
              _mode == LoopMode.off
                  ? Icons.repeat_rounded
                  : _mode == LoopMode.one
                      ? Icons.repeat_one_on_rounded
                      : Icons.repeat_on_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _shuffle = !_shuffle;
              });
            },
            icon: Icon(
              _shuffle ? Icons.shuffle_on_rounded : Icons.shuffle_rounded,
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
            onPressed: () {
              // widget.onTap(context, player);
            },
            icon: const Icon(
              Icons.info,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
