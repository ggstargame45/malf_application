import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/write_screen_common.dart';
import 'write_screen4.dart';
import '../providers/write_screen_providers.dart';
import '../widgets/write_screen3_widgets.dart';

class WriteScreen3 extends ConsumerWidget {
  WriteScreen3({super.key});

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: WriteScreenAppBar(context),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                              _checkBlankCondition(
                                  ref.watch(writeScreenPlaceProvider));
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
              pressNextButton: _isButtonEnabled
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
    _isButtonEnabled = s.isNotEmpty;
  }
}
