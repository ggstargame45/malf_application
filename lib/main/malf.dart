import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/shared/theme/app_theme.dart';

import 'package:malf_application/config/routes/app_route.dart';

class MalfApp extends ConsumerWidget {
  MalfApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'Malf Application',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
