import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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
              logger.d("tap");
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isLiked == 1 ? Icons.favorite : Icons.favorite_border),
                  const Text("123")
                ]),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                logger.d("tap");
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
              onPressed: () {
                logger.d("tap");
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.fromLTRB(40, 19, 40, 19)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
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
