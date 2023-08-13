import 'package:antra/widgets/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../design/color.dart';
import '../constants/hive.constants.dart';
import '../provider/offline_query_provider.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
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
    final favSongBox = Hive.box(favouriteSongs);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: favSongBox.listenable(),
          builder: (context, value, _) {
            return FutureBuilder(
              future: q!.getSongs(),
              builder: (context, snap) {
                return !snap.hasData
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, index) {
                          if (value.get(snap.data![index].id) ?? false)
                            return SongTile(
                              song: snap.data![index],
                              onTap: () {},
                            );
                          return const SizedBox();
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
