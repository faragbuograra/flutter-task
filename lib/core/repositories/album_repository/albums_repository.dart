import 'dart:async';

import 'package:logging/logging.dart';

import '../../data_sources/album/album_remote_data_source.dart';
import '../../models/album/album.dart';
import '/core/exceptions/cache_exception.dart';
import '/core/exceptions/network_exception.dart';
import '/core/exceptions/repository_exception.dart';
import '/core/services/connectivity/connectivity_service.dart';
import '/locator.dart';

abstract class AlbumsRepository {
  Future<Album> fetchAlbum([Map<String, dynamic>? parameters]);

  Future<List<Album>> fetchAlbumsList([Map<String, dynamic>? parameters]);
}

class AlbumsRepositoryImpl implements AlbumsRepository {
  final AlbumsRemoteDataSource? remoteDataSource =
      locator<AlbumsRemoteDataSource>();
  final ConnectivityService? connectivityService =
      locator<ConnectivityService>();

  final _log = Logger('AlbumsRepositoryImpl');

  @override
  Future<Album> fetchAlbum([Map<String, dynamic>? parameters]) async {
    try {
      if (await connectivityService!.isConnected) {
        final data = await remoteDataSource!.fetchAlbum(parameters);

        return data;
      }
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch locally');
      throw RepositoryException(e.message);
    }

    throw RepositoryException('null');
  }

  @override
  Future<List<Album>> fetchAlbumsList(
      [Map<String, dynamic>? parameters]) async {
    try {
      final items = await remoteDataSource!.fetchAlbumsList(parameters);

      return items;
    } on NetworkException catch (e) {
      _log.severe('Failed to fetch Albums remotely');
      throw RepositoryException(e.message);
    } on CacheException catch (e) {
      _log.severe('Failed to fetch Albums locally');
      throw RepositoryException(e.message);
    }
  }
}
