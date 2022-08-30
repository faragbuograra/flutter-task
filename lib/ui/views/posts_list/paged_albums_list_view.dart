import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clean_architecture_starter/core/models/post/post.dart';
import 'package:flutter_clean_architecture_starter/generated/l10n.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/album/album.dart';
import '../../../core/repositories/album_repository/albums_repository.dart';
import '../../widgets/stateless/album_tile/album_tile.dart';
import '../../widgets/stateless/indicators/error_indicator.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import '/core/constant/end_point_parameters.dart';
import '../../widgets/stateless/indicators/empty_list_indicator.dart';
import '../../../../locator.dart';

import '../../../core/services/navigation/navigation_service.dart';
import '../../router.gr.dart';
import 'albums_list_view_model.dart';

// ignore: must_be_immutable
class PagedAlbumsListView extends StatefulWidget {
  final ValueChanged<Album> onAlbumsClicked;
  Map<String, dynamic> parameters;

  PagedAlbumsListView(this.parameters, {required this.onAlbumsClicked});

  @override
  _PagedAlbumsItemsListViewViewState createState() =>
      _PagedAlbumsItemsListViewViewState();
}

class _PagedAlbumsItemsListViewViewState extends State<PagedAlbumsListView> {
  _PagedAlbumsItemsListViewViewState();

  final ScrollController? controller = ScrollController();

  final _pagingController = PagingController<int, Album>(
    firstPageKey: 1,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  @override
  void didUpdateWidget(PagedAlbumsListView oldWidget) {
    // if (oldWidget.listPreferences != widget.listPreferences) {
    //   widget.pagingController.refresh();
    // }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var parameters = widget.parameters;

      parameters.putIfAbsent(EndPointParameter.PAGE, () => pageKey.toString());
      parameters[EndPointParameter.PAGE] = pageKey.toString();

      var items = await locator<AlbumsRepository>().fetchAlbumsList(parameters);

      _pagingController.appendLastPage(items);

      // the following code is used when you want to paginate the result. Don't forget to delete "_pagingController.appendLastPage(items)"

      /* if (items.isEmpty) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(items, nextPageKey);
      }*/

    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AlbumsListViewModel>.reactive(
        viewModelBuilder: () => AlbumsListViewModel(),
        builder: (context, model, child) => PagedListView.separated(
              physics: BouncingScrollPhysics(),
              scrollController: controller,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Album>(
                itemBuilder: (context, album, index) => AlbumTile(
                    album: album,
                    onChanged: (value) async {
                      //  return widget.onAlbumsClicked(value);
                    }),
                firstPageProgressIndicatorBuilder: (context) =>
                    LoadingCircularProgressIndicator(),
                newPageProgressIndicatorBuilder: (context) =>
                    LoadingCircularProgressIndicator(),
                firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
                  error: _pagingController.error,
                  onTryAgain: () => _pagingController.refresh(),
                ),
                noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(
                  title: '${AppLocalizations.of(context).empty_list}', //
                  message: '${AppLocalizations.of(context).empty_list}', //
                ),
              ),
              padding: const EdgeInsets.all(4),
              separatorBuilder: (context, index) => const SizedBox(
                height: 0,
              ),
            ));
  }
}
