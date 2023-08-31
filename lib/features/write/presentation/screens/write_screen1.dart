import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malf_application/features/write/presentation/widgets/write_screen1_widgets.dart';

import 'write_screen2.dart';
import '../widgets/write_screen_common.dart';
import '../providers/write_screen_providers.dart';

@RoutePage()
class WriteScreen1 extends ConsumerWidget {
  WriteScreen1({Key? key}) : super(key: key);

  bool _isButtonEnabled = false; // '다음'버튼이 활성화되는지 여부
  Color _titleOver40TextColor = Colors.white; // 제목 제한 안내 색상
  final int TITLELIMIT = 40; // 제목 제한 상수
  final picker = ImagePicker(); // 이미지피커
  List<File> imageList = []; // 이미지 리스트
  bool isFirstLoaded = true; // 화면을 불러올 때마다 riverpod 초기화하기 위함
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 화면이 처음 로딩될 때마다 riverpod 초기화, 카테고리 색상 초기화
    if (isFirstLoaded) {
      if (!(modifyProviderContainer
          .read(isModifyScreenProvider.notifier)
          .state)) {
        // 글쓰기 버튼을 눌러 새로 작성하는 경우
        ref.refresh(writeScreenImageProvider);
        ref.refresh(writeScreenTitleProvider);
        ref.refresh(writeScreenContentProvider);
        ref.refresh(writeScreenCategoryProvider);
        ref.refresh(selectedDayProvider);
        ref.refresh(timePickerProvider);
        ref.refresh(dateCalendarExpandedProvider);
        ref.refresh(datePickerExpandedProvider);
        categoryColor = const Color(0xFFBEBEBE);
      }

      // 상세글에서 수정하기를 통해 들어온 경우
      else {
        List<String> data =
            modifyProviderContainer.read(detailScreenProvider.notifier).state;
        // 제목 설정
        ref.read(writeScreenTitleProvider.notifier).setText(data[0]);
        _titleController.text = ref.watch(writeScreenTitleProvider);
        // 내용 설정
        ref.read(writeScreenContentProvider.notifier).setText(data[1]);
        _contentController.text = ref.watch(writeScreenContentProvider);
        // 카테고리 설정
        ref.read(writeScreenCategoryProvider.notifier).setText(data[2]);
        categoryColor = Colors.black;
        // 날짜, 시간 설정(확인 필요)
        ref.read(selectedDayProvider.notifier).setDate(DateTime.parse(data[3]));
        // 장소 설정
        ref.read(writeScreenPlaceProvider.notifier).setText(data[3]);
        // 인원 설정(수정 필요)
        ref.read(writeScreenLocalPeopleProvider.notifier).state = 1;
        ref.read(writeScreenForeignPeopleProvider.notifier).state = 1;

        modifyProviderContainer.read(isModifyScreenProvider.notifier).state =
            false;
      }
      isFirstLoaded = false;
    }

    // 키보드가 올라오면 화면 크기를 줄여서 스크롤 가능하게 함
    double isKeyboardDetected() {
      if (MediaQuery.of(context).viewInsets.bottom != 0) {
        return 26;
      } else {
        return 0;
      }
    }

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: WriteScreenAppBar(context),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    // height를 키보드가 발견되지 않으면 75, 발견되면 (75-키보드)로 설정
                    height: getHeightByPercentOfScreen(
                        75 - isKeyboardDetected(), context),
                    child: ScrollConfiguration(
                        // behavior를 common에 정의한 MyBehavior()로 설정하면 스크롤 가능
                        behavior: MyBehavior(),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            const WritingPagesBlackText(text: '모임을 소개해주세요.'),

                            // 모임을 소개해주세요 <-> 사진 공백
                            WhiteBox(boxWidth: 0, boxHeight: 3),

                            const WritingPagesGrayText(text: '사진'),

                            // 사진 <-> 사진첨부 공백
                            WhiteBox(boxWidth: 0, boxHeight: 1),

                            // 사진 추가 버튼, 사진 나오는 화면
                            SizedBox(
                              height: getHeightByPercentOfScreen(10, context),
                              width: getWidthByPercentOfScreen(90, context),
                              child: Row(children: [
                                // 사진을 고를 수 있는 카메라 버튼
                                ImageSelector(
                                    picker: picker, imageList: imageList),
                                WhiteBox(boxWidth: 3, boxHeight: 0),
                                // 사진을 보여주는 리스트뷰
                                ImageListView(imageList: imageList),
                              ]),
                            ),

                            // 사진첨부 <-> 제목 공백
                            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),

                            const WritingPagesGrayText(text: '제목'),

                            // 제목 <-> 제목을 입력해주세요 공백
                            WhiteBox(boxWidth: 0, boxHeight: 1),

                            // 제목을 입력해주세요.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: getWidthByPercentOfScreen(90, context),
                                  height:
                                      getHeightByPercentOfScreen(6.5, context),
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFD3D3D3)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            controller: _titleController,
                                            decoration: const InputDecoration(
                                              hintText: '제목을 입력해주세요.',
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
                                                  .read(writeScreenTitleProvider
                                                      .notifier)
                                                  .setText(text);
                                              _checkBlankCondition(ref.watch(
                                                  writeScreenTitleProvider));
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // 제목을 입력해주세요 <-> 제목 제한 문구 공백
                            WhiteBox(boxWidth: 0, boxHeight: 1.5),

                            // 제목 제한 문구(활성화 시 빨간색)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                WhiteBox(boxWidth: LARGEBLANK, boxHeight: 0),
                                Text(
                                  '40자 이하로 입력해주세요.',
                                  style: TextStyle(
                                    color: _titleOver40TextColor,
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),

                            // 제목 제한 문구 <-> 내용 공백
                            WhiteBox(boxWidth: 0, boxHeight: SMALLBLANK),

                            const WritingPagesGrayText(text: '내용'),

                            // 내용 <-> 소개글을 입력해주세요 공백
                            WhiteBox(boxWidth: 0, boxHeight: SMALLBLANK),

                            // 소개글을 입력해주세요.(선택)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                WhiteBox(boxWidth: 5, boxHeight: 0),
                                Container(
                                  width: getWidthByPercentOfScreen(90, context),
                                  height:
                                      getHeightByPercentOfScreen(15, context),
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFD3D3D3)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: TextField(
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: null,
                                          controller: _contentController,
                                          decoration: const InputDecoration(
                                            hintText: '소개글을 입력해주세요.(선택)',
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
                                                .read(writeScreenContentProvider
                                                    .notifier)
                                                .setText(text);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // 소개글 입력 <-> 카테고리 공백
                            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),

                            const WritingPagesGrayText(text: "카테고리"),

                            // 카테고리 <-> 카테고리 설정 창 공백
                            WhiteBox(boxWidth: 0, boxHeight: SMALLBLANK),

                            // 카테고리 설정하는 창
                            const SelectCategory(),
                          ]),
                        )),
                  ),
                  const Spacer(),
                  WritingPagesNextbutton(
                    pressNextButton: _isButtonEnabled
                        ? () {
                            PageRouteWithAnimation pageRouteWithAnimation =
                                PageRouteWithAnimation(const WriteScreen2());
                            Navigator.push(context,
                                pageRouteWithAnimation.slideRitghtToLeft());
                          }
                        : null,
                  ),
                  WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK)
                ],
              ),
            )));
  }

  void _checkBlankCondition(String s) {
    _isButtonEnabled = s.isNotEmpty && (s.length <= TITLELIMIT);
    if (s.length > TITLELIMIT) {
      _titleOver40TextColor =
          const Color(0xFFFF6060); // 40자 이상인 경우 글씨를 빨간색으로 변경
    } else {
      _titleOver40TextColor = Colors.white; // 이외의 경우 하얀색으로 변경 (안보이게끔)
    }
  }
}
