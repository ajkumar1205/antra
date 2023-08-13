import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../design/color.dart';
import '../widgets/home/musicplayer_tag_card.dart';
import '../widgets/home/playlist_card.dart';
import '../widgets/home/playlist_container.dart';
import '../widgets/home/add_playlist_button.dart';
import '../provider/offline_query_provider.dart';
import '../provider/playlists_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Query? q;
  final key = GlobalKey();
  @override
  void initState() {
    super.initState();
    q = Query();
    takePermissions();
    setState(() {});
  }

  void takePermissions() async {
    await q!.takePermission();
  }

  @override
  Widget build(BuildContext context) {
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
            Consumer<Playlists>(builder: (context, instance, _) {
              return FutureBuilder(
                future: q!.getPlaylists(),
                builder: (context, snap) {
                  return PlaylistContainer(
                    key: key,
                    tag: "Playlists",
                    children: [
                      if (snap.hasData)
                        for (PlaylistModel list in snap.data!)
                          PlaylistCard(
                            id: list.id,
                            name: list.playlist,
                            type: ArtworkType.PLAYLIST,
                            onLongPress: () {
                              final RenderBox box = key.currentContext!
                                  .findRenderObject() as RenderBox;
                              final offset = box.localToGlobal(Offset.zero);

                              showMenu(
                                context: context,
                                position: RelativeRect.fromSize(
                                  Rect.fromCircle(
                                    center: offset,
                                    radius: 20,
                                  ),
                                  Size.fromRadius(25),
                                ),
                                items: [
                                  PopupMenuItem(
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                      AddPlaylistButton(onTap: () {
                        instance.showCreatePlaylistDialog(context, q!);
                      }),
                    ],
                  );
                },
              );
            }),
            const SizedBox(height: 20),
            FutureBuilder(
              future: q!.getArtists(),
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
              future: q!.getAlbums(),
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
              future: q!.getGenres(),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<Playlists>(context, listen: false)
      //         .showCreatePlaylistDialog(context, q!);
      //   },
      //   backgroundColor: color,
      //   child: Icon(Icons.add, color: Colors.white, size: 30),
      //   shape: CircleBorder(),
      // ),
      // floatingActionButtonLocation: FabPosition(80, 150),
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
