import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_route.dart';

@RoutePage()
class DetailScreen extends ConsumerWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Detail Screen'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.router.push(const WriteRoute());
              },
              child: const Text('Go to Write Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
