import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/config/routes/app_route.dart';
import 'package:malf_application/features/detail/data/models/json_data_model.dart';
import 'package:malf_application/features/detail/data/network/network.dart';

import '../../../data/provider/detail_postdata.dart';

var logger = Logger();

final postDataNotifierProvider =
    StateNotifierProvider<PostDataNotifier, PostData>((ref) {
  return PostDataNotifier();
});

class FooterWigdget extends ConsumerWidget {
  Datum? jsonData;
  bool _isExecuted = false;
  FooterWigdget({required this.jsonData, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: invalid_use_of_protected_member

    final postDataValue = ref.watch(postDataNotifierProvider);
    final postDataState = ref.read(postDataNotifierProvider.notifier);
    if (!_isExecuted) {
      _isExecuted = true;
      Future(
        () {
          postDataState.setState(jsonData!.likecheck,
              jsonData!.participationstatus, jsonData!.likecount);
        },
      );
    }
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
              postDataState.toggleIsLiked();
              Network(postId: 20).participationPost(
                  20, postDataValue.isLikedCheck == 0 ? 0 : 1);
              postDataValue.isLikedCheck == 0
                  ? postDataState.increaseCount()
                  : postDataState.decreaseCount();
            },
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              postDataValue.isLikedCheck == 1
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                    )
                  : const Icon(Icons.favorite_border),
              Text("${postDataValue.isLikedCount}")
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
