import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../provider/offline_query_provider.dart';
import '../functions/helper/get_function_from_type.dart';
import '../widgets/song_tile.dart';

class ListDetailsScreen extends StatefulWidget {
  final int id;
  final String name;
  final ArtworkType type;

  const ListDetailsScreen({
    super.key,
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  State<ListDetailsScreen> createState() => _ListDetailsScreenState();
}

class _ListDetailsScreenState extends State<ListDetailsScreen> {
  Query? q;
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
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[700]!,
              Colors.grey[800]!,
              Colors.grey[900]!,
              Colors.black,
            ],
          ),
        ),
        child: FutureBuilder<List<SongModel>>(
            future: getFunction(q!, widget.type)(widget.id),
            builder: (context, snap) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      widget.name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    floating: true,
                    snap: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                    ),
                  ),

                  // CREATE THE SONGLISTS DETAIL SCREEN AND THAN THE REMAINING
                  // WORK WOULD BE OF AUDIO PLAYER AND THAN THE MAJOR PART
                  // FOR THE PROJECT COMPLETION WOULD BE QUEUE MANAGING OF THE
                  // CURRENT PLAYING LISTS......
                  // IT SEEMS TO BE A LONG WORK
                  // STEP 1: IMPLEMENT DETAIL SCREEN
                  // STEP 2: IMPLEMENT AUDIO HANDLER
                  // STEP 3: IMPLEMENT AUDIO NOTIFICATION
                  // STEP 4: IMPLEMENT CREATE PLAYLIST AND ADD SONG TO PLAYLIST
                  // STEP 5: IMPLEMENT SEARCH SCREEN
                  // STEP 6: IMPLEMENT SEARCH LOGIC AND SHOW RESULT AND PLAY
                  // STEP 7: IMPLEMENT STARTUP QUESTIONS WITH SPLASH SCREEN

                  SliverList(
                    delegate: SliverChildListDelegate(
                      snap.hasData
                          ? snap.data!
                              .map((song) => SongTile(
                                    song: song,
                                    onTap: () {},
                                  ))
                              .toList()
                          : [
                              Center(child: CircularProgressIndicator()),
                            ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
