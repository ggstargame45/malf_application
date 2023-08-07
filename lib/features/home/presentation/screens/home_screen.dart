import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_route.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.router.push(const DetailRoute()),
              child: const Text('Detail Screen'),
            ),
            ElevatedButton(
              onPressed: () => context.router.push(WriteRoute1()),
              child: const Text('Write Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
