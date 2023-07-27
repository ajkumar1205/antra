import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:hive/hive.dart';

import '../provider/songlist_provider.dart';
import '../provider/audioplayer_provider.dart';
import '../design/color.dart';
import '../constants/hive_constants.dart';

class SongTile extends StatelessWidget {
  final int index;
  final SongList list;
  final AudioPlayerProvider player;

  final Function onTap;

  const SongTile({
    super.key,
    required this.player,
    required this.list,
    required this.index,
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
        leading: CircleAvatar(
          backgroundColor: textColor,
          child: Hero(
            tag: list.songs![index].id,
            child: QueryArtworkWidget(
              quality: 50,
              id: list.songs![index].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(Icons.music_note),
              errorBuilder: (_, __, ___) {
                return const Icon(Icons.music_note);
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
                  var val = value.get(list.songs![index].id) ?? false;
                  if (val)
                    value.delete(list.songs![index].id);
                  else
                    value.put(list.songs![index].id, true);
                },
                icon: value.get(list.songs![index].id) ?? false
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
          list.songs![index].title,
          style: const TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          list.songs![index].artist!,
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
