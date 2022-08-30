import 'package:stacked/stacked.dart';

import '../../../../core/models/album/album.dart';

class AlbumTileViewModel extends BaseViewModel {
  Album? _album;

  Album? get album => _album;

  void init(Album? album) {
    _album = album;
  }
}
