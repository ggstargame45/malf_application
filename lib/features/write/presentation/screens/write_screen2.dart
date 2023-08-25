import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'page_animation.dart';
import '../widgets/write_screen_common.dart';
import 'write_screen3.dart';
import '../providers/write_screen_providers.dart';

DateTime date = DateTime.now();
String hour = '06';
String minute = '00';
String ampm = '오후';

bool calendarExpanded = false;
bool pickerExpanded = false;

class WriteScreen2 extends ConsumerWidget {
  const WriteScreen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting();
    date = DateTime.now();
    hour = '18';
    minute = '00';
    ampm = '오후';

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
                          child: const DatePicker()),
                    ],
                  ))),
            ),

            const Spacer(),
            WritingPagesNextbutton(
              pressNextButton: true
                  ? () {
                      ref.read(writeScreenDateProvider.notifier).setText(
                          "${DateFormat("yyyy-MM-dd ").format(date)}$hour:$minute:00");
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

// DateCalendar
class DateCalendar extends StatefulWidget {
  const DateCalendar({Key? key}) : super(key: key);

  @override
  State<DateCalendar> createState() => _DateCalendarState();
}

class _DateCalendarState extends State<DateCalendar> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Row(
                children: [
                  const SizedBox(
                      width: 20, height: 70), // 위 SizedBox의 height로 높이 조절
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 35),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '모임 날짜',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${DateFormat('yyyy.MM.dd ').format(date)}(${DateFormat.E('ko_KR').format(date)})',
                                style: const TextStyle(
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
                const Divider(),
                TableCalendar(
                    locale: 'ko_KR',
                    firstDay: DateTime.utc(2021, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: focusedDay,
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      headerPadding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        // 요일 글씨 수정(한글로 출력할 경우 글자가 짤려 원래보다 작게 설정해둠)
                        weekdayStyle: TextStyle(fontSize: 13),
                        weekendStyle: TextStyle(fontSize: 13)),
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      setState(() {
                        this.selectedDay = selectedDay;
                        this.focusedDay = focusedDay;
                        date = focusedDay;
                      });
                    },
                    selectedDayPredicate: (DateTime day) {
                      return isSameDay(selectedDay, day);
                    }),
              ],
            ),
            isExpanded: calendarExpanded,
            canTapOnHeader: true,
            backgroundColor: const Color(0xF7F7F7F7)),
      ],
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          calendarExpanded = !calendarExpanded;
          // pickerExpanded = false;
        });
      },
    );
  }
}

// DatePicker
class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime(2023, 8, 15, 18, 0);
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Row(
                children: [
                  const SizedBox(
                      width: 20, height: 70), // 위 SizedBox의 height로 높이 조절
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, size: 35),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '모임 시간',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '$ampm ${(int.parse(hour) % 12).toString()}:$minute',
                                style: const TextStyle(
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
                const Divider(height: 0.5),
                SizedBox(
                    height: getHeightByPercentOfScreen(25, context),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(2023, 08, 15, 18, 0),
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          time = newTime;
                          if (time.hour < 10) {
                            hour = '0${(time.hour).toString()}';
                          } else {
                            hour = (time.hour).toString();
                          }
                          if (time.minute < 10) {
                            minute = '0${minute = time.minute.toString()}';
                          } else {
                            minute = time.minute.toString();
                          }
                          if (time.hour >= 12) {
                            ampm = '오후';
                          } else {
                            ampm = '오전';
                          }
                        });
                      },
                    ))
              ],
            ),
            isExpanded: pickerExpanded,
            canTapOnHeader: true,
            backgroundColor: const Color(0xF7F7F7F7)),
      ],
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          pickerExpanded = !pickerExpanded;
          // calendarExpanded = false;
        });
      },
    );
  }
}
