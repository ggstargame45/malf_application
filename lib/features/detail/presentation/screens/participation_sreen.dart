import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';

@RoutePage()
class ParticipationScreen extends ConsumerWidget {
  const ParticipationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
        actions: const [
          Icon(
            Icons.more_horiz_outlined,
            color: AppColors.black,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: const Center(child: Text("participation")),
    );
  }
}
