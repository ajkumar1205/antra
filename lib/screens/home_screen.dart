import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../design/color.dart';
import '../widgets/home/musicplayer_tag_card.dart';
import '../widgets/home/playlist_card.dart';
import '../widgets/home/playlist_container.dart';
import '../widgets/home/add_playlist_button.dart';
import '../provider/offline_query_provider.dart';
import '../functions/helper/create_playlist_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final q = Provider.of<Query>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: bgColor,
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            const MusicPlayerTagCard(),
            const SizedBox(height: 20),
            FutureBuilder(
              future: q.getPlaylists(),
              builder: (context, snap) {
                return PlaylistContainer(
                  tag: "Playlists",
                  children: [
                    if (snap.hasData)
                      for (PlaylistModel list in snap.data!)
                        PlaylistCard(
                          id: list.id,
                          name: list.playlist,
                          type: ArtworkType.PLAYLIST,
                        ),
                    AddPlaylistButton(onTap: () {}),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: q.getArtists(),
              builder: (context, snap) {
                return PlaylistContainer(
                  tag: "Artists",
                  children: [
                    if (snap.hasData)
                      for (ArtistModel artist in snap.data!)
                        PlaylistCard(
                          id: artist.id,
                          name: artist.artist,
                          type: ArtworkType.ARTIST,
                        ),
                    // AddPlaylistButton(onTap: () {}),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: q.getAlbums(),
              builder: (context, snap) {
                return PlaylistContainer(
                  tag: "Albums",
                  children: [
                    if (snap.hasData)
                      for (AlbumModel album in snap.data!)
                        PlaylistCard(
                          id: album.id,
                          name: album.album,
                          type: ArtworkType.ALBUM,
                        ),
                    // AddPlaylistButton(onTap: () {}),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: q.getGenres(),
              builder: (context, snap) {
                return PlaylistContainer(
                  tag: "Genres",
                  children: [
                    if (snap.hasData)
                      for (GenreModel genre in snap.data!)
                        PlaylistCard(
                          id: genre.id,
                          name: genre.genre,
                          type: ArtworkType.GENRE,
                        ),
                    // AddPlaylistButton(onTap: () {}),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreatePlaylistDialog(context, q);
        },
        backgroundColor: color,
        child: Icon(Icons.add, color: Colors.white, size: 30),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FabPosition(80, 150),
    );
  }
}

class FabPosition extends FloatingActionButtonLocation {
  final double? x;
  final double? y;

  FabPosition(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width - x!,
      scaffoldGeometry.scaffoldSize.height - y!,
    );
  }
}
