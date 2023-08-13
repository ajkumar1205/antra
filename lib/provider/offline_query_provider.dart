import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class Query {
  static final OnAudioQuery _audioQuery = OnAudioQuery();

  OnAudioQuery get audioQuery {
    return _audioQuery;
  }

  Future<void> takePermission() async {
    var status = await _audioQuery.permissionsStatus();
    while (!status) {
      status = await _audioQuery.permissionsRequest();
    }
  }

  Future<List<SongModel>> getSongs({
    SongSortType? sortBy,
    OrderType? orderBy,
  }) async {
    final list = await _audioQuery.querySongs(
      sortType: sortBy ?? SongSortType.TITLE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
    return list;
  }

  Future<bool> createPlaylist(String name) async {
    if (name.length < 3) return false;
    return await _audioQuery.createPlaylist(name);
  }

  Future<bool> addItemToPlaylist(int playlistId, int songId) async {
    return _audioQuery.addToPlaylist(playlistId, songId);
  }

  Future<List<PlaylistModel>> getPlaylists({
    PlaylistSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryPlaylists(
      sortType: sortBy ?? PlaylistSortType.DATE_ADDED,
      orderType: orderBy ?? OrderType.DESC_OR_GREATER,
    );
  }

  Future<List<ArtistModel>> getArtists({
    ArtistSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryArtists(
      sortType: sortBy ?? ArtistSortType.ARTIST,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<AlbumModel>> getAlbums({
    AlbumSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryAlbums(
      sortType: sortBy ?? AlbumSortType.ALBUM,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<GenreModel>> getGenres({
    GenreSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryGenres(
      sortType: sortBy ?? GenreSortType.GENRE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<SongModel>> getSongsFromPlaylist(
    int playlistId, {
    SongSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      playlistId,
      sortType: sortBy ?? SongSortType.TITLE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<SongModel>> getSongsFromArtist(
    int artistId, {
    SongSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artistId,
      sortType: sortBy ?? SongSortType.TITLE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<SongModel>> getSongsFromAlbum(
    int albumId, {
    SongSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      sortType: sortBy ?? SongSortType.TITLE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<List<SongModel>> getSongsFromGenre(
    int genreId, {
    SongSortType? sortBy,
    OrderType? orderBy,
  }) async {
    return await _audioQuery.queryAudiosFrom(
      AudiosFromType.GENRE_ID,
      genreId,
      sortType: sortBy ?? SongSortType.TITLE,
      orderType: orderBy ?? OrderType.ASC_OR_SMALLER,
    );
  }

  Future<bool> removePlaylist(int playlistId) async {
    return await _audioQuery.removePlaylist(playlistId);
  }

  Future<bool> renamePlaylist(int playlistId, String name) async {
    return await _audioQuery.renamePlaylist(playlistId, name);
  }

  Future<bool> removeItemFromPlaylist(int playlistId, int songId) async {
    return await _audioQuery.removeFromPlaylist(playlistId, songId);
  }

  Future<String> artworkPath(int songId, {ArtworkType? type}) async {
    final tempDir = await getTemporaryDirectory();
    File file = File("${tempDir.path}/$songId.png");
    if (!await file.exists()) {
      final artwork =
          await _audioQuery.queryArtwork(songId, type ?? ArtworkType.AUDIO);
      file.writeAsBytesSync(artwork!);
    }
    return file.path;
  }

  Future<MediaItem> getMediaItem(SongModel song) async {
    MediaItem s = MediaItem(
      id: song.id.toString(),
      title: song.title,
      album: song.album,
      artist: song.artist,
      artUri: Uri.parse(await artworkPath(song.id)),
      genre: song.genre,
      duration: Duration(milliseconds: song.duration!),
      extras: {
        'path': song.data,
        'composer': song.composer,
      },
    );
    return s;
  }
}
