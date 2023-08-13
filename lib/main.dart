import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import './design/color.dart';
import './constants/hive.constants.dart';
import './screens/audio_player_screen.dart';
import './screens/favourites_screen.dart';
import './screens/songs_library_screen.dart';
import './screens/home_screen.dart';
import './widgets/animated_app_bar.dart';
import './constants/bottom_bar.constants.dart';
import './utils/playlist.adapter.dart';
import './functions/helper/get_drawer.dart';
import './utils/audioplayer_handler_helper.dart';
import './utils/audio_stream_combined.dart';
import './provider/playlists_provider.dart';
import './provider/offline_query_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayListAdapter());

  await AudioHandlerHelper.initHandler();

  // final app = await getApplicationDocumentsDirectory();
  // final dbDirectory = app.path;
  // database = await BoxCollection.open(
  //   antra,
  //   {settings, playlists, favouriteArtists},
  //   path: dbDirectory,
  // );
  await Hive.openBox(favouriteSongs);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Playlists()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(seedColor: color),
          useMaterial3: true,
        ),
        home: const TabsManagingScreen(),
      ),
    );
  }
}

class TabsManagingScreen extends StatefulWidget {
  const TabsManagingScreen({
    super.key,
  });

  @override
  State<TabsManagingScreen> createState() => _TabsManagingScreenState();
}

class _TabsManagingScreenState extends State<TabsManagingScreen> {
  int index = 0;

  final handler = AudioHandlerHelper.audioHandler;
  final q = Query();

  var permitted = false;

  final _screens = const [
    HomeScreen(),
    LibraryScreen(),
    FavouritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    askPermission();
    setState(() {});
  }

  void askPermission() async {
    await q.takePermission();
    setState(() {
      permitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: const AnimatedAppBar(),
        preferredSize: Size.fromHeight(79),
      ),
      backgroundColor: Colors.grey[900],
      drawer: getDrawer(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onHorizontalDragEnd: (drag) {
          if (drag.primaryVelocity! > 0.0) {
            if (index == 0) return;
            setState(() {
              index = index - 1;
            });
          } else {
            if (index == 2) return;
            setState(() {
              index = index + 1;
            });
          }
        },
        child: permitted ? _screens[index] : null,
      ),
      bottomNavigationBar: StreamBuilder(
        stream: Rx.combineLatest3(
          AudioService.position,
          handler.mediaItem,
          handler.playbackState,
          (pos, item, state) =>
              AudioHandlerState(item: item!, pos: pos, state: state),
        ),
        builder: (context, snapshot) {
          final item = snapshot.hasData ? snapshot.data!.item : null;
          final pos = snapshot.hasData ? snapshot.data!.pos : null;
          final state = snapshot.hasData ? snapshot.data!.state : null;
          final double val = snapshot.hasData
              ? (pos != null ? pos.inMilliseconds : 0) /
                  (item != null ? item.duration!.inMilliseconds : 1)
              : 0;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.black,
            ),
            height: 74,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                state != null
                    ? Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const PlayerScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 25),
                              height: 45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 201,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SONG TITLE
                                        Text(
                                          item != null ? item.title : '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        // ARTIST NAME
                                        Text(
                                          item != null ? item.artist! : '',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        constraints:
                                            const BoxConstraints(maxWidth: 10),
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        constraints:
                                            const BoxConstraints(maxWidth: 10),
                                        padding: const EdgeInsets.all(0),
                                        icon: Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 36,
                            child: SizedBox(
                              height: 2,
                              width: MediaQuery.of(context).size.width - 60,
                              child: LinearProgressIndicator(
                                color: color.withOpacity(0.95),
                                backgroundColor: Colors.white,
                                value: val,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 26),
                // HERES THE NAVIGATION BAR STARTS
                Stack(
                  children: [
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: list.map(
                        (item) {
                          final i = list.indexOf(item);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                index = i;
                              });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    index == i ? color.withOpacity(0.7) : null,
                              ),
                              child: Row(
                                children: [
                                  item['icon']!,
                                  if (index == i)
                                    FutureBuilder(
                                      future: Future.delayed(
                                        const Duration(milliseconds: 500),
                                      ),
                                      builder: (context, snapshot) {
                                        return item['text']!;
                                      },
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
