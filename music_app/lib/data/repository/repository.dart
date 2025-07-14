import 'dart:convert';

import 'package:music_app/data/model/song.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/data/source/souce.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];

    final remoteSongs = await _remoteDataSource.loadData();
    if (remoteSongs == null) {
      final localSongs = await _localDataSource.loadData();
      if (localSongs != null) {
        songs.addAll(localSongs);
      }
    } else {
      songs.addAll(remoteSongs);
    }

    return songs;
  }
}
