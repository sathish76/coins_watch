import 'package:coin_watch/blocs/asset_list/asset_list_bloc.dart';
import 'package:coin_watch/blocs/asset_price_history/asset_price_history_bloc.dart';
import 'package:coin_watch/data/repository/asset_list_repo.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/screens/asset_detail_screen.dart';
import 'package:coin_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di/di.dart';

class Routes {
  static const String HOME_SCREEN = '/';
  static const String ASSET_DETAIL_SCREEN = '/asset_detail';

  Route<dynamic>? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case HOME_SCREEN:
        return _getRoute(
          BlocProvider<AssetListBloc>(
            create: (context) => AssetListBloc(
              getIt<AssetRepository>(),
            )..add(
                AssetListLoaded(),
              ),
            child: HomeScreen(),
          ),
          settings,
        );
      case ASSET_DETAIL_SCREEN:
        final Asset selectedAsset =
            (settings.arguments as Map<String, dynamic>)['asset'];
        return _getRoute(
            BlocProvider(
              create: (context) => AssetPriceHistoryBloc(
                getIt<AssetRepository>(),
              )..add(
                  AssetPriceHistoryLoaded(selectedAsset),
                ),
              child: AssetDetailScreen(),
            ),
            settings);
      default:
        return _getRoute(
          Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
          settings,
        );
    }
  }

  Route<dynamic>? _getRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }
}
