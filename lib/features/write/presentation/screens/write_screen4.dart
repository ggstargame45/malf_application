// import 'package:flutter/cupertino.dart';
// import '/screens/writing_pages/writing_pages1.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/features/write/presentation/screens/write_screen_post.dart';

import 'write_screen1.dart';
import 'write_screen3.dart';
import 'write_screen_util.dart';

String title = '';
String content = '';
int category = 1;
String meeting_location = '';
String meeting_start_time = '2023-08-09 19:00:00';
int capacity_local = 0;
int capacity_travel = 0;
Future<bool>? isPosted;

class WriteScreen4 extends ConsumerWidget {
  const WriteScreen4({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Test: ${ref.watch(writeScreenTitleProvider)}',
                    style: const TextStyle(
                      color: Color(0xFF292524),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Content: ${ref.watch(writeScreenContentProvider)}',
                    style: const TextStyle(
                      color: Color(0xFF292524),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Place: ${ref.watch(writeScreenPlaceProvider)}',
                    style: const TextStyle(
                      color: Color(0xFF292524),
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            WritingPagesBlackText(
              text: 'LocalPeople: ${ref.watch(writeScreenLocalPeopleProvider)}',
            ),
            WritingPagesBlackText(
              text:
                  'ForeignPeople: ${ref.watch(writeScreenForeignPeopleProvider)}',
            ),

            const Spacer(),
            WritingPagesNextbutton(
              pressNextButton: true
                  ? () {
                      title = ref.watch(writeScreenTitleProvider);
                      content = ref.watch(writeScreenContentProvider);
                      category = 1;
                      meeting_location = ref.watch(writeScreenPlaceProvider);
                      meeting_start_time = '2023-08-09 19:00:00';
                      capacity_local =
                          ref.watch(writeScreenLocalPeopleProvider).toInt();
                      capacity_travel =
                          ref.watch(writeScreenForeignPeopleProvider).toInt();
                      PostingBody postingBody = PostingBody(
                          title: title,
                          content: content,
                          meeting_start_time: meeting_start_time,
                          category: category,
                          meeting_location: meeting_location,
                          capacity_local: capacity_local,
                          capacity_travel: capacity_travel);
                      print(title);
                      postPosting(postingBody);
                      // _registration();
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
