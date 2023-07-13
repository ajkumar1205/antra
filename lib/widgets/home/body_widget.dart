import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../provider/songlist_provider.dart';
import '../../design/color.dart';
import '../../screens/audio_player_screen.dart';
import '../../provider/audioplayer_provider.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context, listen: false);
    return Consumer<SongList>(builder: (context, list, child) {
      list.takePermission();
      return !list.hasSongs
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: list.songs!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
                  child: ListTile(
                    iconColor: textColor,
                    tileColor: subColor,
                    leading: CircleAvatar(
                      backgroundColor: textColor,
                      child: QueryArtworkWidget(
                        id: list.songs![index].id,
                        type: ArtworkType.AUDIO,
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.music_note);
                        },
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_sharp),
                    ),
                    title: Text(
                      list.songs![index].title,
                      style: const TextStyle(
                          color: color, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      list.songs![index].artist!,
                      style: const TextStyle(color: textColor),
                    ),
                    onTap: () {
                      player.play(list.songs![index].data);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PlayerScreen(songIndex: index),
                        ),
                      );
                    },
                  ),
                );
              },
            );
    });
  }
}
