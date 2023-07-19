import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../provider/audioplayer_provider.dart';

class AudioBanner extends StatelessWidget {
  const AudioBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AudioPlayerProvider>(context, listen: false);
    return Hero(
      tag: value.songId,
      child: QueryArtworkWidget(
        id: value.songId,
        type: ArtworkType.AUDIO,
        artworkFit: BoxFit.fill,
        artworkBorder: BorderRadius.circular(20),
        nullArtworkWidget: const Icon(
          Icons.music_note,
          color: Colors.white,
          size: 150,
        ),
      ),
    );
  }
}
