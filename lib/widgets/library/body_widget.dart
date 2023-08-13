import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../provider/offline_query_provider.dart';
import '../song_tile.dart';
import '../../constants/hive.constants.dart';
import '../../provider/audioplayer_handler.dart';
import '../../utils/audioplayer_handler_helper.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final favSongBox = Hive.box(favouriteSongs);
    final Query q = Query();
    final AudioPlayerHandler audiohandler = AudioHandlerHelper.audioHandler;

    return FutureBuilder(
      future: q.getSongs(),
      builder: (context, data) {
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
                        onTap: () async {
                          await audiohandler.playMediaItem(
                            await q.getMediaItem(list[index]),
                          );
                        },
                      );
                    },
                  );
                },
              );
      },
    );
  }
}
