import 'package:antra/provider/songlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './design/color.dart';
import './screens/home_screen.dart';
import './provider/audioplayer_provider.dart';
// import './functions/sharedpreferences/last_played.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (context) => SongList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(seedColor: color),
          useMaterial3: true,
        ),
        home: const HomeTabsManagingScreen(),
      ),
    );
  }
}
