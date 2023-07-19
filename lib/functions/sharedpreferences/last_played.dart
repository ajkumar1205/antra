import 'package:shared_preferences/shared_preferences.dart';

class LastPlayed {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static void setSongId(int id) {
    _instance!.setInt('id', id);
  }

  static void setSongPath(String path) {
    _instance!.setString('path', path);
  }

  static void setSongIndex(int index) {
    _instance!.setInt('index', index);
  }

  static void setSongLength(int millis) {
    _instance!.setInt('length', millis);
  }

  // static void setPlayedDuration(int millis) {
  //   _instance!.setInt('duration', millis);
  // }

  static void setArtist(String artist) {
    _instance!.setString('artist', artist);
  }

  static void setTitle(String title) {
    _instance!.setString('title', title);
  }

  static Duration get songLength {
    final millis = _instance!.getInt('length') ?? 0;
    return Duration(milliseconds: millis);
  }

  // static Duration get playedDuration {
  //   final millis = _instance!.getInt('duration') ?? 0;
  //   return Duration(milliseconds: millis);
  // }
  static int get songId {
    return _instance!.getInt('id') ?? 0;
  }

  static String get songPath {
    return _instance!.getString('path') ?? '';
  }

  static String get title {
    return _instance!.getString('title') ?? '';
  }

  static String get artist {
    return _instance!.getString('artist') ?? '';
  }

  static int get index {
    return _instance!.getInt('index') ?? 0;
  }
}
