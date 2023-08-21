import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/detail/presentation/screens/detail_screen.dart';
import '../../features/detail/presentation/screens/participation_sreen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/write/presentation/screens/write_screen1.dart';
import '../../features/login/presentation/screens/login_screen.dart';

part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: DetailRoute.page),
        AutoRoute(page: WriteRoute1.page),
        AutoRoute(page: ParticipationRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
      ];
}
