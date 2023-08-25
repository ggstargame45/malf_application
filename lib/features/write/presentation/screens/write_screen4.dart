// import 'package:flutter/cupertino.dart';
// import '/screens/writing_pages/writing_pages1.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/features/write/presentation/screens/write_screen_post.dart';
import 'package:auto_route/auto_route.dart';

import 'write_screen3.dart';
import '../widgets/write_screen_common.dart';
import '../providers/write_screen_providers.dart';

String title = '';
String content = '';
String category = '1';
String meeting_location = '';
String meeting_start_time = '2023-08-09 19:00:00';
String capacity_local = '0';
String capacity_travel = '0';
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
            WritingPagesBlackText(
                text: "Category: ${ref.watch(writeScreenCategoryProvider)}"),
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
            WritingPagesBlackText(
                text: "Date: ${ref.watch(writeScreenDateProvider)}"),
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
              // 전송
              pressNextButton: true
                  ? () async {
                      title = ref.watch(writeScreenTitleProvider);
                      content = ref.watch(writeScreenContentProvider);
                      category = MappingCategory(
                          ref.watch(writeScreenCategoryProvider));
                      meeting_location = ref.watch(writeScreenPlaceProvider);
                      meeting_start_time = ref.watch(writeScreenDateProvider);
                      capacity_local = ref
                          .watch(writeScreenLocalPeopleProvider)
                          .toInt()
                          .toString();
                      capacity_travel = ref
                          .watch(writeScreenForeignPeopleProvider)
                          .toInt()
                          .toString();
                      List<File> imageFile =
                          ref.watch(writeScreenImageProvider);

                      PostingBody postingBody = PostingBody(
                        title: title,
                        content: content,
                        meeting_start_time: meeting_start_time,
                        category: category,
                        meeting_location: meeting_location,
                        capacity_local: capacity_local,
                        capacity_travel: capacity_travel,
                      );
                      bool isPosted = await postPosting(postingBody, imageFile);
                      if (isPosted) {
                        context.router
                            .popUntilRouteWithName('HomeRoute'); //창 닫기
                        print("글쓰기 성공");
                      } else {
                        print("글쓰기 실패");
                      }
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

// 카테고리를 int로 바꾸기 위한 함수
String MappingCategory(String category) {
  if (category == "여행") {
    return '1';
  } else if (category == "맛집") {
    return '2';
  } else if (category == "독서") {
    return '3';
  } else if (category == "스포츠") {
    return '4';
  } else {
    return '5';
  }
}
