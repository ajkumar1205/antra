import 'package:shared_preferences/shared_preferences.dart';

class LastPlayed {
  static Future<void> setSongPath(String path) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('path', path));
  }

  static Future<void> setSongIndex(int index) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setInt('index', index));
  }

  static Future<void> setSongLength(int millis) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setInt('length', millis));
  }

  static Future<void> setPlayedDuration(int millis) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setInt('duration', millis));
  }

  static Future<void> setArtist(String artist) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('artist', artist));
  }

  static Future<void> setTitle(String title) async {
    await SharedPreferences.getInstance()
        .then((value) => value.setString('title', title));
  }

  static Future<Duration> get songLength async {
    final instance = await SharedPreferences.getInstance();
    final millis = instance.getInt('length') ?? 0;
    return Duration(milliseconds: millis);
  }

  static Future<Duration> get playedDuration async {
    final instance = await SharedPreferences.getInstance();
    final millis = instance.getInt('duration') ?? 0;
    return Duration(milliseconds: millis);
  }

  static Future<String> get songPath async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('path') ?? '';
  }

  static Future<String> get title async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('title') ?? '';
  }

  static Future<String> get artist async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('artist') ?? '';
  }

  static Future<int> get index async {
    final instance = await SharedPreferences.getInstance();
    return instance.getInt('index') ?? 0;
  }
}
