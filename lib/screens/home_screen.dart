import 'package:flutter/material.dart';

import '../design/color.dart';
import '../widgets/home/musicplayer_tag_card.dart';
import '../widgets/home/playlist_card.dart';
import '../widgets/home/playlist_container.dart';
import '../widgets/home/add_playlist_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            PlaylistContainer(
              tag: "Collections",
              children: [
                PlaylistCard(
                  name: "Love",
                  color: Colors.green,
                ),
                PlaylistCard(
                  name: "Hip Hop",
                  color: Colors.yellow,
                ),
                PlaylistCard(
                  name: "Punjabi",
                  color: Colors.deepOrange,
                ),
                AddPlaylistButton(onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            PlaylistContainer(
              tag: "By Artist",
              children: [
                PlaylistCard(
                  name: "Atif Aslam",
                  color: Colors.amber,
                ),
                PlaylistCard(
                  name: "Arijit Singh",
                  color: Colors.green,
                ),
                PlaylistCard(
                  name: "KK",
                  color: Colors.blue,
                ),
                PlaylistCard(
                  name: "Rahat Fateh Ali Khan",
                  color: Colors.indigo,
                ),
                AddPlaylistButton(onTap: () {}),
              ],
            ),
            const SizedBox(height: 20),
            PlaylistContainer(
              tag: "By Album",
              children: [
                PlaylistCard(
                  name: "Qismat",
                  color: Colors.orange,
                ),
                PlaylistCard(
                  name: "RockStar",
                  color: Colors.brown,
                ),
                PlaylistCard(
                  name: "Ashiqui 2",
                  color: Colors.red,
                ),
                AddPlaylistButton(onTap: () {}),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
