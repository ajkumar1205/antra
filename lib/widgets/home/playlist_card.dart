import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../functions/helper/get_card_color.dart';
import '../../screens/list_details_screen.dart';
import '../../provider/offline_query_provider.dart';

class PlaylistCard extends StatelessWidget {
  final int id;
  final String name;
  final ArtworkType type;
  final Function? onLongPress;

  const PlaylistCard({
    super.key,
    required this.id,
    required this.name,
    required this.type,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColor();
    return InkWell(
      onLongPress: () {
        if (onLongPress != null) onLongPress!();
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListDetailsScreen(
              id: id,
              name: name,
              type: type,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                // child: QueryArtworkWidget(
                //   id: id,
                //   type: type,
                //   artworkFit: BoxFit.fill,
                //   artworkBorder: BorderRadius.circular(0),
                //   nullArtworkWidget: Icon(
                //     CupertinoIcons.music_albums,
                //     color: Colors.white,
                //     size: 50,
                //   ),
                //   errorBuilder: (_, __, ___) => Icon(
                //     CupertinoIcons.music_albums,
                //     color: Colors.white,
                //     size: 50,
                //   ),
                // ),
                child: FutureBuilder<String>(
                  future: Query().artworkPath(id, type: type),
                  builder: (context, snap) {
                    return snap.hasData
                        ? Image.file(
                            File(snap.data!),
                            fit: BoxFit.fill,
                          )
                        : Icon(
                            CupertinoIcons.music_albums,
                            size: 50,
                            color: Colors.white,
                          );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.5),
                        color.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
