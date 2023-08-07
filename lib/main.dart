import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_background/just_audio_background.dart';

import './design/color.dart';
import './provider/audioplayer_provider.dart';
import 'provider/offline_query_provider.dart';
import './constants/hive.constants.dart';
import './screens/audio_player_screen.dart';
import './screens/favourites_screen.dart';
import './screens/songs_library_screen.dart';
import './screens/home_screen.dart';
import './functions/sharedpreferences/last_played.dart';
import './widgets/animated_app_bar.dart';
import './constants/bottom_bar.constants.dart';
import './utils/playlist.adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlayListAdapter());

  await JustAudioBackground.init(
    androidNotificationChannelId: 'app.antra.notification.background',
    androidNotificationChannelName: 'Antra',
    androidNotificationOngoing: true,
  );

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
        ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (context) => Query())
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

  final _screens = const [
    HomeScreen(),
    LibraryScreen(),
    FavouritesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    initialisation();
  }

  void initialisation() async {
    await LastPlayed.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: const AnimatedAppBar(),
        preferredSize: Size.fromHeight(79),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        elevation: 20,
        width: 250,
        child: ListView(
          children: [
            DrawerHeader(
              child: CircleAvatar(
                backgroundColor: subColor,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              color: subColor,
              child: ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              color: subColor,
              child: ListTile(
                title: Text(
                  "DarkTheme",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
            ),
          ],
        ),
      ),
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
        child: _screens[index],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.black,
        ),
        height: 74,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Consumer<AudioPlayerProvider>(builder: (context, player, child) {
              return Stack(
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
                      padding: const EdgeInsets.only(right: 20, left: 25),
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 201,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.getTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  player.getArtist,
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
                                constraints: const BoxConstraints(maxWidth: 10),
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                constraints: const BoxConstraints(maxWidth: 10),
                                padding: const EdgeInsets.all(0),
                                icon: Icon(
                                  player.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  player.togglePlayer();
                                },
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
                      child: StreamBuilder<Duration>(
                        stream: player.position(),
                        builder: (context, snapshot) {
                          double val = snapshot.hasData
                              ? snapshot.data!.inMilliseconds /
                                  player.songDuration.inMilliseconds
                              : 0.0;
                          return LinearProgressIndicator(
                            color: color.withOpacity(0.95),
                            backgroundColor: Colors.white,
                            value: val,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
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
                        child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == i ? color.withOpacity(0.7) : null,
                          ),
                          duration: const Duration(milliseconds: 500),
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
      ),
    );
  }
}
