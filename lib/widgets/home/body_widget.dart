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
                return Card(
                  color: subColor,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: ListTile(
                    horizontalTitleGap: 10,
                    iconColor: textColor,
                    // tileColor: subColor,
                    leading: CircleAvatar(
                      backgroundColor: textColor,
                      child: Hero(
                        tag: "audiobanner",
                        child: QueryArtworkWidget(
                          id: list.songs![index].id,
                          type: ArtworkType.AUDIO,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.music_note);
                          },
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_rounded),
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
                      player.setSong = list.songs![index];
                      player.play();
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
