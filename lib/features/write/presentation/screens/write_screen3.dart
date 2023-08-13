// import 'package:flutter/cupertino.dart';
// import '/screens/writing_pages/writing_pages1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'page_animation.dart';
import 'write_screen_util.dart';
import 'write_screen1.dart';
import 'write_screen4.dart';

final writeScreenPlaceProvider =
    StateNotifierProvider<PlaceNotifier, String>((ref) {
  return PlaceNotifier();
});

class PlaceNotifier extends StateNotifier<String> {
  PlaceNotifier() : super('');

  void setText(String text) {
    state = text;
  }
}

class WriteScreen3 extends ConsumerWidget {
  WriteScreen3({super.key});

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WhiteBox(boxWidth: 0, boxHeight: 5), // 맨 위 상단 공백

            Row(
              // 글쓰기 화면 상단의 앱바
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  iconSize: getWidthByPercentOfScreen(6, context),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: getWidthByPercentOfScreen(8, context),
                  onPressed: () {
                    closeWritingPages(context);
                  },
                )
              ],
            ),

            WhiteBox(boxWidth: 0, boxHeight: 2), // 앱바 <-> 모임장소와 인원을 입력해주세요 공백

            const WritingPagesBlackText(text: '모임장소와 인원을 입력해주세요.'),
            WhiteBox(boxWidth: 0, boxHeight: 3),

            const WritingPagesGrayText(text: '장소'),
            WhiteBox(boxWidth: 0, boxHeight: 1),
            Row(
              // 모임장소와 인원을 입력해주세요.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: getWidthByPercentOfScreen(90, context),
                  height: getHeightByPercentOfScreen(6.5, context),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD3D3D3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                            decoration: const InputDecoration(
                              hintText: '모임장소에서 가장 가까운 역을 선택해주세요.',
                              hintStyle: TextStyle(
                                color: Color(0xFFBEBEBE),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              ref
                                  .read(writeScreenPlaceProvider.notifier)
                                  .setText(text);
                              _checkBlankCondition(text);
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
            WhiteBox(boxWidth: 0, boxHeight: 10),
            WritingPagesGrayText(
                text:
                    '현지인 인원: ${ref.watch(writeScreenLocalPeopleProvider).toInt()} 명'),
            LocalPeopleSlider(),
            WhiteBox(boxWidth: 0, boxHeight: 3),
            WritingPagesGrayText(
                text:
                    '외국인 인원: ${ref.watch(writeScreenForeignPeopleProvider).toInt()} 명'),
            ForeignPeopleSlider(),
            const Spacer(),
            WritingPagesNextbutton(
              pressNextButton: true
                  ? () {
                      PageRouteWithAnimation pageRouteWithAnimation =
                          PageRouteWithAnimation(const WriteScreen4());
                      Navigator.push(
                          context, pageRouteWithAnimation.slideRitghtToLeft());
                    }
                  : null,
            ),
            WhiteBox(boxWidth: 0, boxHeight: 3)
          ],
        )),
      ),
    );
  }

  void _checkBlankCondition(String s) {
    _isButtonEnabled = s.isNotEmpty && (s.length <= 40);
  }
}
