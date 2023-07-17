import 'package:shared_preferences/shared_preferences.dart';

class LastPlayed {
  static SharedPreferences? _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<void> setSongPath(String path) async {
    await _instance!.setString('path', path);
  }

  static Future<void> setSongIndex(int index) async {
    await _instance!.setInt('index', index);
  }

  static Future<void> setSongLength(int millis) async {
    await _instance!.setInt('length', millis);
  }

  static Future<void> setPlayedDuration(int millis) async {
    await _instance!.setInt('duration', millis);
  }

  static Future<void> setArtist(String artist) async {
    await _instance!.setString('artist', artist);
  }

  static Future<void> setTitle(String title) async {
    await _instance!.setString('title', title);
  }

  static Duration get songLength {
    final millis = _instance!.getInt('length') ?? 0;
    return Duration(milliseconds: millis);
  }

  static Duration get playedDuration {
    final millis = _instance!.getInt('duration') ?? 0;
    return Duration(milliseconds: millis);
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
}
