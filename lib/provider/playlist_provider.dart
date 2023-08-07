import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/playlist.dart';

class PlayListProvider extends ChangeNotifier {
  List<Playlist>? _playlists;
}
