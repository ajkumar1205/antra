import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class AudioBanner extends StatelessWidget {
  final MediaItem? item;
  const AudioBanner({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: item != null ? item!.id : 0,
      child: item != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                File.fromUri(item!.artUri!),
                fit: BoxFit.fill,
              ),
            )
          : Icon(
              Icons.music_note,
              color: Colors.white,
              size: 150,
            ),
    );
  }
}
