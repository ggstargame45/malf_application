import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'page_animation.dart';
import 'write_screen_util.dart';
import 'write_screen3.dart';

final writeScreenExpandedProvider = StateProvider<bool>((ref) => false);
final writeScreenDateProvider = StateProvider<String>((ref) => "");

class WriteScreen2 extends ConsumerWidget {
  const WriteScreen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool expanded = false;
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

            WhiteBox(boxWidth: 0, boxHeight: 2), // 앱바 <-> 일정과 시간을 입력해주세요 공백

            const Row(
              // 일정과 시간을 입력해주세요.
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '일정과 시간을 입력해주세요.',
                    style: TextStyle(
                      color: Color(0xFF292524),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),

            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
            Container(
                width: getWidthByPercentOfScreen(90, context),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0x00000000)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                clipBehavior: Clip.antiAlias, // 안티앨리어싱
                child: const DateCalander()),

            // const Spacer(),
            WritingPagesNextbutton(
              pressNextButton: true
                  ? () {
                      PageRouteWithAnimation pageRouteWithAnimation =
                          PageRouteWithAnimation(WriteScreen3());
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
}

// ExpansionPanelList - 'v'모양 버튼 클릭에 따라 화면 아래로 확장 및 축소 가능한 위젯
class DateCalander extends StatefulWidget {
  const DateCalander({Key? key}) : super(key: key);

  @override
  State<DateCalander> createState() => _DateCalanderState();
}

class _DateCalanderState extends State<DateCalander> {
  bool _expanded = false;
  final bool _expanded1 = false;
  final bool _expanded2 = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return const Row(
                children: [
                  SizedBox(width: 20, height: 70), // 위 SizedBox의 height로 높이 조절
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month_outlined, size: 35),
                      Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Test: ',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '2023.07.01 (월)',
                                style: TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              );
            },
            body: Column(
              children: [
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          alignment: Alignment.center,
                          child: Text("${i + 1}"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  )
              ],
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
            backgroundColor: const Color(0xF7F7F7F7)),
      ],
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {});
      },
    );
    // child: Row(
    //   // 제목을 입력해주세요.
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     Container(
    //       width: getWidthByPercentOfScreen(90, context),
    //       height: getHeightByPercentOfScreen(40, context),
    //       padding: const EdgeInsets.only(left: 16, right: 16),
    //       decoration: ShapeDecoration(
    //         color: const Color(0xF7F7F7F7),
    //         shape: RoundedRectangleBorder(
    //           side: const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //       ),
    //       child: ExpansionPanelList(
    //         children: [
    //           ExpansionPanel(
    //             headerBuilder: (context, isExpanded) {
    //               return const Text("확패널 장헤더");
    //             },
    //             body: const Text("확장패널 바디"),
    //             isExpanded: _expanded1,
    //           ),
    //         ],
    //         expansionCallback: (panelIndex, isExpanded) {
    //           setState(() {
    //             if (panelIndex == 0) {
    //               _expanded1 = !_expanded1;
    //             } else {
    //               _expanded2 = !_expanded2;
    //             }
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // ),
    // ExpansionPanelList(
    //   children: [
    //     ExpansionPanel(
    //       headerBuilder: (context, isExpanded) {
    //         return const Text("확패널 장헤더");
    //       },
    //       body: const Text("확장패널 바디"),
    //       isExpanded: _expanded1,
    //     ),
    //   ],
    //   expansionCallback: (panelIndex, isExpanded) {
    //     setState(() {
    //       if (panelIndex == 0) {
    //         _expanded1 = !_expanded1;
    //       } else {
    //         _expanded2 = !_expanded2;
    //       }
    //     });
    //   },
    // ),
  }
}
