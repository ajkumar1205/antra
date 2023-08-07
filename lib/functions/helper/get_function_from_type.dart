import 'package:on_audio_query/on_audio_query.dart';

import '../../provider/offline_query_provider.dart';

Function getFunction(Query q, ArtworkType type) {
  switch (type) {
    case ArtworkType.ALBUM:
      return q.getSongsFromAlbum;
    case ArtworkType.PLAYLIST:
      return q.getSongsFromPlaylist;
    case ArtworkType.ARTIST:
      return q.getSongsFromArtist;
    case ArtworkType.GENRE:
      return q.getSongsFromGenre;
    default:
      return q.getSongs;
  }
}
