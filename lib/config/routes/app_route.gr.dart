// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DetailScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomeScreen(key: args.key),
      );
    },
    ParticipationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ParticipationScreen(),
      );
    },
    WriteRoute1.name: (routeData) {
      final args = routeData.argsAs<WriteRoute1Args>(
          orElse: () => const WriteRoute1Args());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WriteScreen1(key: args.key),
      );
    },
  };
}

/// generated route for
/// [DetailScreen]
class DetailRoute extends PageRouteInfo<void> {
  const DetailRoute({List<PageRouteInfo>? children})
      : super(
          DetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ParticipationScreen]
class ParticipationRoute extends PageRouteInfo<void> {
  const ParticipationRoute({List<PageRouteInfo>? children})
      : super(
          ParticipationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ParticipationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WriteScreen1]
class WriteRoute1 extends PageRouteInfo<WriteRoute1Args> {
  WriteRoute1({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          WriteRoute1.name,
          args: WriteRoute1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'WriteRoute1';

  static const PageInfo<WriteRoute1Args> page = PageInfo<WriteRoute1Args>(name);
}

class WriteRoute1Args {
  const WriteRoute1Args({this.key});

  final Key? key;

  @override
  String toString() {
    return 'WriteRoute1Args{key: $key}';
  }
}
