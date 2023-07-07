import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../design/color.dart';
import './audio_player_screen.dart';

class HomeTabsManagingScreen extends StatefulWidget {
  const HomeTabsManagingScreen({super.key});

  @override
  State<HomeTabsManagingScreen> createState() => _HomeTabsManagingScreenState();
}

class _HomeTabsManagingScreenState extends State<HomeTabsManagingScreen> {
  List<SongModel>? songs;
  var songLoaded = false;
  OnAudioQuery? audioQuery;

  @override
  void initState() {
    super.initState();
    audioQuery = OnAudioQuery();
    takePermission();
  }

  void takePermission() async {
    var status = await audioQuery!.permissionsStatus();
    while (!status) {
      status = await audioQuery!.permissionsRequest();
    }
    getSongs();
  }

  void getSongs() async {
    songs = await audioQuery!.querySongs();
    setState(() {
      songLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.only(top: 25, left: 30, right: 30),
          decoration: BoxDecoration(
            color: subColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: !songLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: songs!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
                  child: ListTile(
                    iconColor: textColor,
                    tileColor: subColor,
                    leading: CircleAvatar(
                      backgroundColor: textColor,
                      child: QueryArtworkWidget(
                        id: songs![index].id,
                        type: ArtworkType.AUDIO,
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.music_note);
                        },
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_sharp),
                    ),
                    title: Text(
                      songs![index].title,
                      style: const TextStyle(
                          color: color, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      songs![index].artist!,
                      style: const TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PlayerScreen(song: songs![index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
