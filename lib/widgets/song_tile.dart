import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive/hive.dart';

import '../provider/offline_query_provider.dart';
// import '../provider/audioplayer_provider.dart';
import '../design/color.dart';
import '../constants/hive.constants.dart';

class SongTile extends StatelessWidget {
  final SongModel song;

  final Function onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final value = Hive.box(favouriteSongs);
    return Card(
      color: subColor.withOpacity(0.95),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        horizontalTitleGap: 10,
        iconColor: textColor,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Hero(
            transitionOnUserGestures: true,
            tag: song.id,
            // child: QueryArtworkWidget(
            //   quality: 50,
            //   id: song.id,
            //   type: ArtworkType.AUDIO,
            //   nullArtworkWidget: const Icon(Icons.music_note),
            //   errorBuilder: (_, __, ___) {
            //     return const Icon(Icons.music_note);
            //   },
            // ),
            child: FutureBuilder<String>(
              future: Query().artworkPath(song.id),
              builder: (context, snap) {
                return snap.hasData
                    ? Image.file(
                        File(snap.data!),
                        fit: BoxFit.fill,
                      )
                    : Container(
                        width: 55,
                        height: 55,
                        color: Colors.black,
                        child: Icon(
                          CupertinoIcons.music_albums,
                          color: Colors.white,
                        ),
                      );
              },
            ),
          ),
        ),
        trailing: SizedOverflowBox(
          alignment: Alignment.centerLeft,
          size: Size.fromWidth(75),
          child: Row(
            children: [
              IconButton(
                iconSize: 25,
                onPressed: () {
                  var val = value.get(song.id, defaultValue: false);
                  if (val)
                    value.delete(song.id);
                  else
                    value.put(song.id, true);
                },
                icon: value.get(song.id, defaultValue: false)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border_outlined),
              ),
              IconButton(
                iconSize: 25,
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
        title: Text(
          song.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          song.artist!,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
