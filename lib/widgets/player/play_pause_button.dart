import 'package:flutter/material.dart';

import '../../design/color.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // radius: 40,
      minRadius: 0,
      backgroundColor: color,
      child: IconButton(
        iconSize: 60,
        color: Colors.white,
        splashColor: Colors.transparent,
        onPressed: () {
          // player.togglePlayer();
        },
        icon: Icon(true ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
