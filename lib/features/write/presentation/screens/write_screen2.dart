import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../widgets/write_screen_common.dart';
import 'write_screen3.dart';
import '../providers/write_screen_providers.dart';
import '../widgets/write_screen2_widgets.dart';

class WriteScreen2 extends ConsumerWidget {
  const WriteScreen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting();

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: WriteScreenAppBar(context),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WritingPagesBlackText(text: "일정과 시간을 입력해주세요"),
            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
            SizedBox(
              height: getHeightByPercentOfScreen(60, context),
              child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                          width: getWidthByPercentOfScreen(90, context),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0x00000000)),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias, // 안티앨리어싱
                          child: const DateCalendar()),
                      WhiteBox(boxWidth: 0, boxHeight: SMALLBLANK),
                    ],
                  ))),
            ),
            const Spacer(),
            WritingPagesNextbutton(
              pressNextButton: true
                  ? () {
                      ref.read(writeScreenDateProvider.notifier).setDate(
                          "${DateFormat("yyyy-MM-dd ").format(ref.watch(selectedDayProvider))}$hour:$minute:00");
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
