import 'package:hive/hive.dart';

// DATABASE OBJECT WHICH WOULD WE USED THROUGHOUT THE PROJECT
// late BoxCollection database;
const antra = 'AntraDataBase';

// BOXES TO STORE DATA
const settings = 'settings';
const playlists = 'playlists';
const favouriteArtists = 'favouriteArtists';
const favouriteSongs = 'favouriteSongs';

// SPECIAL KEYS STORED IN BOXES
// <---------- SETTINGS BOX --------->
const lastPlayedList = 'lastPlayedList';
const lastPlayedSong = 'lastPlayedSong';
