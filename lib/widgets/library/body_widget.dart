import 'package:antra/models/playlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/songlist_provider.dart';
import '../../provider/audioplayer_provider.dart';
import '../song_tile.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioPlayerProvider>(context, listen: false);
    final list = Provider.of<SongList>(context, listen: false);
    var plist = PlayList(
      title: "All Songs",
      oneArtist: false,
      songs: list.shuffleableList,
    );
    player.setPlaylistAndAudioSource(plist);
    return Consumer<SongList>(
      builder: (context, list, child) {
        list.takePermission();
        return !list.hasSongs
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.songs!.length,
                itemBuilder: (context, index) {
                  return SongTile(
                    player: player,
                    list: list,
                    index: index,
                    onTap: () {
                      player.setSong = list.songs![index];
                      player.seek(index);
                    },
                  );
                },
              );
      },
    );
  }
}
