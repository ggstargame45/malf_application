import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malf_application/features/write/presentation/providers/write_screen_providers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/write_screen_common.dart';

String hour = '18';
String minute = '00';
String ampm = '오후';

bool calendarExpanded = false;
bool pickerExpanded = false;

class DateCalendar extends ConsumerWidget {
  const DateCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                                '${DateFormat('yyyy.MM.dd ').format(ref.watch(selectedDayProvider))}(${DateFormat.E('ko_KR').format(ref.watch(selectedDayProvider))})',
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
                    focusedDay: ref.watch(focusedDayProvider),
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
                      // provider로 상태 관리
                      ref
                          .read(selectedDayProvider.notifier)
                          .setDate(selectedDay);
                      ref.read(focusedDayProvider.notifier).setDate(focusedDay);
                    },
                    selectedDayPredicate: (DateTime day) {
                      return isSameDay(ref.watch(selectedDayProvider), day);
                    }),
              ],
            ),
            isExpanded: ref.watch(dateCalendarExpandedProvider),
            canTapOnHeader: true,
            backgroundColor: const Color(0xF7F7F7F7)),
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
                                ref.watch(timePickerProvider),
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
                        if (newTime.hour < 10) {
                          hour = '0${(newTime.hour).toString()}';
                        } else {
                          hour = (newTime.hour).toString();
                        }
                        if (newTime.minute < 10) {
                          minute = '0${minute = newTime.minute.toString()}';
                        } else {
                          minute = newTime.minute.toString();
                        }
                        if (newTime.hour >= 12) {
                          ampm = '오후';
                        } else {
                          ampm = '오전';
                        }
                        ref.read(timePickerProvider.notifier).setTime(
                            "$ampm ${(int.parse(hour) % 12).toString()}:$minute");
                      },
                    ))
              ],
            ),
            isExpanded: ref.watch(datePickerExpandedProvider),
            canTapOnHeader: true,
            backgroundColor: const Color(0xF7F7F7F7)),
      ],
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        // 한 번에 한 개의 ExpandedPanel만 활성화되도록 설정
        if (panelIndex == 0) {
          ref.read(dateCalendarExpandedProvider.notifier).state =
              !ref.watch(dateCalendarExpandedProvider);
          ref.read(datePickerExpandedProvider.notifier).state = false;
        } else if (panelIndex == 1) {
          ref.read(datePickerExpandedProvider.notifier).state =
              !ref.watch(datePickerExpandedProvider);
          ref.read(dateCalendarExpandedProvider.notifier).state = false;
        }
      },
    );
  }
}
