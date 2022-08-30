import 'dart:async';

import '../../models/album/album.dart';
import '/core/constant/api_routes.dart';
import '/core/services/http/http_service.dart';
import '/locator.dart';

abstract class AlbumsRemoteDataSource {
  Future<Album> fetchAlbum([Map<String, dynamic>? parameters]);

  Future<List<Album>> fetchAlbumsList([Map<String, dynamic>? parameters]);
}

class AlbumsRemoteDataSourceImpl implements AlbumsRemoteDataSource {
  final HttpService? httpService = locator<HttpService>();

  @override
  Future<Album> fetchAlbum([Map<String, dynamic>? parameters]) async {
    Map<String, dynamic> restData = await (httpService!
        .getHttp(ApiRoutes.post(parameters!['id']), parameters));

    return Album.fromMap(restData['data']);
  }

  @override
  Future<List<Album>> fetchAlbumsList(
      [Map<String, dynamic>? parameters]) async {
    List<dynamic> jsonData =
        await httpService!.getHttp(ApiRoutes.posts, parameters);

    var items =
        jsonData.map<Album>((vendorMap) => Album.fromMap(vendorMap)).toList();

    //    var list = newsJsonData['data'] as List<dynamic>;

    return items;
  }
}
