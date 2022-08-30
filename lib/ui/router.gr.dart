// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../core/models/post/post.dart' as _i8;
import 'views/main/main_view.dart' as _i1;
import 'views/posts_list/posts_list_view.dart' as _i4;
import 'views/posts_view/posts_view.dart' as _i3;
import 'views/settings/settings_view.dart' as _i5;
import 'views/startup/start_up_view.dart' as _i2;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CustomerMainViewRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.CustomerMainView());
    },
    StartUpViewRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.StartUpView());
    },
    PostsViewRoute.name: (routeData) {
      final args = routeData.argsAs<PostsViewRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.PostsView(args.post));
    },
    PostsListViewRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.PostsListView());
    },
    SettingsViewRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.SettingsView());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(CustomerMainViewRoute.name,
            path: '/customer-main-view'),
        _i6.RouteConfig(StartUpViewRoute.name, path: '/'),
        _i6.RouteConfig(PostsViewRoute.name, path: '/posts-view'),
        _i6.RouteConfig(PostsListViewRoute.name, path: '/posts-list-view'),
        _i6.RouteConfig(SettingsViewRoute.name, path: '/settings-view')
      ];
}

/// generated route for
/// [_i1.CustomerMainView]
class CustomerMainViewRoute extends _i6.PageRouteInfo<void> {
  const CustomerMainViewRoute()
      : super(CustomerMainViewRoute.name, path: '/customer-main-view');

  static const String name = 'CustomerMainViewRoute';
}

/// generated route for
/// [_i2.StartUpView]
class StartUpViewRoute extends _i6.PageRouteInfo<void> {
  const StartUpViewRoute() : super(StartUpViewRoute.name, path: '/');

  static const String name = 'StartUpViewRoute';
}

/// generated route for
/// [_i3.PostsView]
class PostsViewRoute extends _i6.PageRouteInfo<PostsViewRouteArgs> {
  PostsViewRoute({required _i8.Post post})
      : super(PostsViewRoute.name,
            path: '/posts-view', args: PostsViewRouteArgs(post: post));

  static const String name = 'PostsViewRoute';
}

class PostsViewRouteArgs {
  const PostsViewRouteArgs({required this.post});

  final _i8.Post post;

  @override
  String toString() {
    return 'PostsViewRouteArgs{post: $post}';
  }
}

/// generated route for
/// [_i4.PostsListView]
class PostsListViewRoute extends _i6.PageRouteInfo<void> {
  const PostsListViewRoute()
      : super(PostsListViewRoute.name, path: '/posts-list-view');

  static const String name = 'PostsListViewRoute';
}

/// generated route for
/// [_i5.SettingsView]
class SettingsViewRoute extends _i6.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(SettingsViewRoute.name, path: '/settings-view');

  static const String name = 'SettingsViewRoute';
}
