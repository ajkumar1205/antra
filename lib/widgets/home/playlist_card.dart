import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../functions/helper/get_card_color.dart';
import '../../screens/list_details_screen.dart';

class PlaylistCard extends StatelessWidget {
  final int id;
  final String name;
  final ArtworkType type;

  const PlaylistCard({
    super.key,
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColor();
    return InkWell(
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
                child: QueryArtworkWidget(
                  id: id,
                  type: type,
                  artworkFit: BoxFit.fill,
                  artworkBorder: BorderRadius.circular(0),
                  nullArtworkWidget: Icon(
                    CupertinoIcons.music_albums,
                    color: Colors.white,
                    size: 50,
                  ),
                  errorBuilder: (_, __, ___) => Icon(
                    CupertinoIcons.music_albums,
                    color: Colors.white,
                    size: 50,
                  ),
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
