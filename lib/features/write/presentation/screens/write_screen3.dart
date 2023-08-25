// import 'package:flutter/cupertino.dart';
// import '/screens/writing_pages/writing_pages1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'page_animation.dart';
import '../widgets/write_screen_common.dart';
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
            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
            // const Divider(),
            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
            WritingPagesGrayText(
                text:
                    '현지인 인원: ${ref.watch(writeScreenLocalPeopleProvider).toInt()} 명'),
            const LocalPeopleSlider(),
            WhiteBox(boxWidth: 0, boxHeight: 3),
            WritingPagesGrayText(
                text:
                    '외국인 인원: ${ref.watch(writeScreenForeignPeopleProvider).toInt()} 명'),
            const ForeignPeopleSlider(),
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

// 슬라이더로 SliderThemeData의 child를 Slider로 구성하면 여러가지 커스텀이 가능
final writeScreenLocalPeopleProvider = StateProvider<double>((ref) => 0);

class LocalPeopleSlider extends ConsumerWidget {
  const LocalPeopleSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(writeScreenLocalPeopleProvider);

    return SliderTheme(
        // 슬라이더의 색상 등을 커스텀하려면 사용
        data: SliderThemeData(
          thumbColor: Colors.blue, // 슬라이더 버튼(Thumb)의 색상
          tickMarkShape: SliderTickMarkShape
              .noTickMark, // 슬라이더 내 범위마다 칸 설정(noTickMark는 해당 없음)
          // activeTickMarkColor: Colors.blue,
          // inactiveTickMarkColor: const Color(0xFFB2BDCF),
          valueIndicatorColor: const Color(0xFFB2BDCF), // 슬라이더 위에 나오는 현재 숫자 색상
        ),
        child: Slider(
          value: ref.watch(writeScreenLocalPeopleProvider),
          min: 0,
          max: 20,
          divisions: 20,
          label: '${ref.watch(writeScreenLocalPeopleProvider).toInt()}',
          onChanged: (newValue) {
            ref.read(writeScreenLocalPeopleProvider.notifier).state =
                newValue; // 상태 업데이트
          },
        ));
  }
}

final writeScreenForeignPeopleProvider = StateProvider<double>((ref) => 0);

class ForeignPeopleSlider extends ConsumerWidget {
  const ForeignPeopleSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(writeScreenForeignPeopleProvider);

    return SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.blue, // 슬라이더 버튼(Thumb)의 색상
          tickMarkShape: SliderTickMarkShape.noTickMark,
          // activeTickMarkColor: Colors.blue,
          // inactiveTickMarkColor: const Color(0xFFB2BDCF),
          valueIndicatorColor: const Color(0xFFB2BDCF),
        ), // 오버레이 색상 (터치 영역의 표시))
        child: Slider(
          value: ref.watch(writeScreenForeignPeopleProvider),
          min: 0,
          max: 20,
          divisions: 20,
          label: '${ref.watch(writeScreenForeignPeopleProvider).toInt()}',
          onChanged: (newValue) {
            ref.read(writeScreenForeignPeopleProvider.notifier).state =
                newValue; // 상태 업데이트
          },
        ));
  }
}
