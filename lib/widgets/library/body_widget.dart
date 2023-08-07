import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../provider/offline_query_provider.dart';
import '../../provider/audioplayer_provider.dart';
import '../song_tile.dart';
import '../../constants/hive.constants.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final player = Provider.of<AudioPlayerProvider>(context, listen: false);
    final q = Provider.of<Query>(context);
    final favSongBox = Hive.box(favouriteSongs);
    // player.setPlaylistAndAudioSource(plist);
    return FutureBuilder(
      future: q.getSongs(),
      builder: (context, data) {
        q.takePermission();
        final list = data.data;
        return list == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder(
                    valueListenable: favSongBox.listenable(),
                    builder: (context, value, _) {
                      return SongTile(
                        song: list[index],
                        onTap: () {},
                      );
                    },
                  );
                },
              );
      },
    );
  }
}
