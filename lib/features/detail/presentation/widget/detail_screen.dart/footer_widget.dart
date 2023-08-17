import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/config/routes/app_route.dart';
import 'package:malf_application/features/detail/data/network/network.dart';

import '../../../data/provider/detail_data_provider.dart';

var logger = Logger();

class IsLikedState extends StateNotifier<int> {
  IsLikedState() : super(1);

  void toggleIsLiked() {
    if (state == 0) {
      state = 1;
    } else if (state == 1) {
      state = 0;
    }
  }
}

final islikedStateNotifierProvider =
    StateNotifierProvider<IsLikedState, int>((ref) {
  return IsLikedState();
});

class FooterWigdget extends ConsumerWidget {
  const FooterWigdget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: invalid_use_of_protected_member
    final jsonData = ref.read(jsonDataProvider).jsonData.data!.first;
    Logger().d(jsonData!.likecount);
    final isLiked = ref.watch(islikedStateNotifierProvider);
    final isLikedRead = ref.read(islikedStateNotifierProvider.notifier);
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          width: 30,
          height: 60,
          child: GestureDetector(
            onTap: () {
              isLikedRead.toggleIsLiked();
              Network(postId: 20)
                  .participationPost(20, jsonData.likecheck == 0 ? 0 : 1);

              isLiked == 0
                  ? jsonData.likecount = jsonData.likecount! + 1
                  : jsonData.likecount = jsonData.likecount! - 1;
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              isLiked == 1
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                    )
                  : const Icon(Icons.favorite_border),
              Text("${jsonData.likecount}")
            ]),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                context.router.push(const ParticipationRoute());
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(40, 19, 40, 19)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: const Text(
                "참여자 확인",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(40, 19, 40, 19)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF61C3FF))),
              child: const Text(
                "참여요청",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
