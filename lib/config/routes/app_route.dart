import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/detail/presentation/screens/detail_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/write/presentation/screens/write_screen.dart';
import '../../features/write/presentation/screens/write_screen1.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
        AutoRoute(page: WriteRoute.page),
      ];
}
