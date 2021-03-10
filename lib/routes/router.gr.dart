// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/foundation.dart' as _i6;

import '../view/home/widgets/search_overlay.dart' as _i3;
import '../view/landing/widgets/landing_auth_wrapper.dart' as _i2;
import '../view/repository/code/file_viewer.dart' as _i5;
import '../view/repository/repository_screen.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LandingAuthWrapperScreenRoute.name: (entry) {
      var route = entry.routeData.as<LandingAuthWrapperScreenRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i2.LandingAuthWrapperScreen(key: route.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          durationInMilliseconds: 250);
    },
    SearchOverlayScreenRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i3.SearchOverlayScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn);
    },
    RepositoryScreenRoute.name: (entry) {
      var route = entry.routeData.as<RepositoryScreenRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i4.RepositoryScreen(route.repositoryURL,
              branch: route.branch,
              index: route.index ?? 0,
              key: route.key,
              initSHA: route.initSHA),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          durationInMilliseconds: 250);
    },
    FileViewerAPIRoute.name: (entry) {
      var route = entry.routeData.as<FileViewerAPIRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i5.FileViewerAPI(route.sha,
              repoURL: route.repoURL,
              fileName: route.fileName,
              branch: route.branch,
              repoName: route.repoName),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          durationInMilliseconds: 250);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<LandingAuthWrapperScreenRoute>(
            LandingAuthWrapperScreenRoute.name,
            path: '/',
            routeBuilder: (match) =>
                LandingAuthWrapperScreenRoute.fromMatch(match)),
        _i1.RouteConfig<SearchOverlayScreenRoute>(SearchOverlayScreenRoute.name,
            path: '/search-overlay-screen',
            routeBuilder: (match) => SearchOverlayScreenRoute.fromMatch(match)),
        _i1.RouteConfig<RepositoryScreenRoute>(RepositoryScreenRoute.name,
            path: '/repository-screen',
            routeBuilder: (match) => RepositoryScreenRoute.fromMatch(match)),
        _i1.RouteConfig<FileViewerAPIRoute>(FileViewerAPIRoute.name,
            path: '/file-viewer-ap-i',
            routeBuilder: (match) => FileViewerAPIRoute.fromMatch(match))
      ];
}

class LandingAuthWrapperScreenRoute extends _i1.PageRouteInfo {
  LandingAuthWrapperScreenRoute({this.key}) : super(name, path: '/');

  LandingAuthWrapperScreenRoute.fromMatch(_i1.RouteMatch match)
      : key = null,
        super.fromMatch(match);

  final _i6.Key key;

  static const String name = 'LandingAuthWrapperScreenRoute';
}

class SearchOverlayScreenRoute extends _i1.PageRouteInfo {
  const SearchOverlayScreenRoute()
      : super(name, path: '/search-overlay-screen');

  SearchOverlayScreenRoute.fromMatch(_i1.RouteMatch match)
      : super.fromMatch(match);

  static const String name = 'SearchOverlayScreenRoute';
}

class RepositoryScreenRoute extends _i1.PageRouteInfo {
  RepositoryScreenRoute(
      {this.repositoryURL, this.branch, this.index = 0, this.key, this.initSHA})
      : super(name, path: '/repository-screen');

  RepositoryScreenRoute.fromMatch(_i1.RouteMatch match)
      : repositoryURL = null,
        branch = null,
        index = 0,
        key = null,
        initSHA = null,
        super.fromMatch(match);

  final String repositoryURL;

  final String branch;

  final int index;

  final _i6.Key key;

  final String initSHA;

  static const String name = 'RepositoryScreenRoute';
}

class FileViewerAPIRoute extends _i1.PageRouteInfo {
  FileViewerAPIRoute(
      {this.sha, this.repoURL, this.fileName, this.branch, this.repoName})
      : super(name, path: '/file-viewer-ap-i');

  FileViewerAPIRoute.fromMatch(_i1.RouteMatch match)
      : sha = null,
        repoURL = null,
        fileName = null,
        branch = null,
        repoName = null,
        super.fromMatch(match);

  final String sha;

  final String repoURL;

  final String fileName;

  final String branch;

  final String repoName;

  static const String name = 'FileViewerAPIRoute';
}
