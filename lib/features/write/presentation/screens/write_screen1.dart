import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import './page_animation.dart';
import 'write_screen2.dart';
import 'write_screen_util.dart';

final writeScreenTitleProvider =
    StateNotifierProvider<TitleNotifier, String>((ref) {
  return TitleNotifier();
});

class TitleNotifier extends StateNotifier<String> {
  TitleNotifier() : super('');

  void setText(String text) {
    state = text;
  }
}

final writeScreenContentProvider =
    StateNotifierProvider<ContentNotifier, String>((ref) {
  return ContentNotifier();
});

class ContentNotifier extends StateNotifier<String> {
  ContentNotifier() : super('');

  void setText(String text) {
    state = text;
  }
}

final writeScreenCategoryProvider =
    StateNotifierProvider<CategoryNotifier, String>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<String> {
  CategoryNotifier() : super("카테고리를 선택해주세요.");

  void setText(String text) {
    state = text;
  }
}

final writeScreenImageProvider =
    StateNotifierProvider<ImageNotifier, List<File>>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<List<File>> {
  ImageNotifier() : super([]);

  void refresh(List<File> newList) {
    state = newList;
  }

  void clearImage() {
    state = [];
  }
}

@RoutePage()
class WriteScreen1 extends ConsumerWidget {
  WriteScreen1({Key? key}) : super(key: key);

  bool _isButtonEnabled = false;
  Color _titleOver40TextColor = Colors.white;
  final int TITLELIMIT = 40;

  final picker = ImagePicker();
  List<File> imageList = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double isKeyboardDetected() {
      if (MediaQuery.of(context).viewInsets.bottom != 0) {
        return 22;
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
            body: SafeArea(
              child: Column(
                children: <Widget>[
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
                  WhiteBox(
                      boxWidth: 0,
                      boxHeight: SMALLBLANK), // 앱바 <-> 모임을소개해주세요 공백

                  SizedBox(
                    height: getHeightByPercentOfScreen(
                        70 - isKeyboardDetected(), context),
                    child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            const WritingPagesBlackText(text: '모임을 소개해주세요.'),
                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: 3), // 모임을 소개해주세요 <-> 사진 공백
                            const WritingPagesGrayText(text: '사진'),

                            WhiteBox(
                                boxWidth: 0, boxHeight: 1), // 사진 <-> 사진첨부 공백

                            SizedBox(
                              // 사진을 추가할 수 있는 좌측 카메라 버튼
                              height: getHeightByPercentOfScreen(10, context),
                              width: getWidthByPercentOfScreen(90, context),
                              child: Row(children: [
                                SizedBox(
                                    width:
                                        getHeightByPercentOfScreen(10, context),
                                    height:
                                        getHeightByPercentOfScreen(10, context),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (imageList.length < 10) {
                                          final image = await picker.pickImage(
                                              source: ImageSource
                                                  .gallery); // 갤러리에서 이미지 뽑아옴
                                          imageList.add(File(image!.path));
                                          ref.refresh(writeScreenImageProvider);
                                          ref
                                              .read(writeScreenImageProvider
                                                  .notifier)
                                              .refresh(imageList);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        backgroundColor:
                                            const Color(0xFFF7F7F7),
                                        side: const BorderSide(
                                            width: 0.75,
                                            color: Color(0xFFD3D3D3)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.photo_camera_rounded,
                                            size: 38,
                                            color: Color(0xFFBEBEBE),
                                          ),
                                          Text(
                                              "${ref.watch(writeScreenImageProvider).length} / 10",
                                              style: const TextStyle(
                                                  color: Color(0xFF808080),
                                                  fontFamily: 'Pretendard',
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    )),
                                WhiteBox(boxWidth: 3, boxHeight: 0),
                                SizedBox(
                                  // 사진들을 미리 볼 수 있게 해주는 리스트뷰
                                  height:
                                      getHeightByPercentOfScreen(10, context),
                                  width: getWidthByPercentOfScreen(60, context),
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: ref
                                        .watch(writeScreenImageProvider)
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.75,
                                                  color: Color(0xFFD3D3D3)),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      16), // ClipRRect의 모서리 설정
                                              child: Stack(
                                                children: [
                                                  Image.file(
                                                    ref.watch(
                                                            writeScreenImageProvider)[
                                                        index],
                                                    height:
                                                        getHeightByPercentOfScreen(
                                                            10, context),
                                                    width:
                                                        getHeightByPercentOfScreen(
                                                            10, context),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                      top:
                                                          getWidthByPercentOfScreen(
                                                              -2, context),
                                                      right:
                                                          getWidthByPercentOfScreen(
                                                              2, context),
                                                      child: SizedBox(
                                                          width: 20,
                                                          child:
                                                              FloatingActionButton(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFD3D3D3),
                                                            onPressed: () {
                                                              imageList
                                                                  .removeAt(
                                                                      index);
                                                              ref.refresh(
                                                                  writeScreenImageProvider);
                                                              ref
                                                                  .read(writeScreenImageProvider
                                                                      .notifier)
                                                                  .refresh(
                                                                      imageList);
                                                            }, // 해당 이미지 삭제
                                                            child: const Icon(
                                                                Icons.close,
                                                                size: 15,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                                ],
                                              )));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            WhiteBox(
                                                boxWidth: MEDIUMBLANK,
                                                boxHeight: 0),
                                  ),
                                ),
                              ]),
                            ),

                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: MEDIUMBLANK), // 사진첨부 <-> 제목 공백

                            const WritingPagesGrayText(text: '제목'),
                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: 1), // 제목 <-> 제목을 입력해주세요 공백
                            Row(
                              // 제목을 입력해주세요.
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
                                              _checkBlankCondition(text);
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: 1.5), // 제목을 입력해주세요 <-> 40자이하 공백
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
                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: SMALLBLANK), // 40자이하 <-> 내용 공백

                            const WritingPagesGrayText(text: '내용'),

                            WhiteBox(
                                boxWidth: 0,
                                boxHeight: SMALLBLANK), // 내용 <-> 소개글을 입력해주세요 공백
                            Row(
                              // 소개글을 입력해주세요.(선택)
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

                            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
                            const WritingPagesGrayText(text: "카테고리"),
                            WhiteBox(boxWidth: 0, boxHeight: SMALLBLANK),
                            // 카테고리 설정하는 창
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: getHeightByPercentOfScreen(
                                            50, context),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            const WritingPagesBlackText(
                                                text: "카테고리를 입력해주세요"),
                                            WhiteBox(
                                                boxWidth: 0,
                                                boxHeight: MEDIUMBLANK),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                // CategoryButton() TODO: 토글버튼 구현
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.transparent);
                              },
                              child: Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            ref.watch(
                                                writeScreenCategoryProvider),
                                            style: const TextStyle(
                                              color: Color(0xFFBEBEBE),
                                              fontSize: 16,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ])),
                            ),

                            WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
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

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool isTravel = false;
  bool isSports = false;
  late List<bool> isSelected;
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(isSelected: isSelected, children: const [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text('여행', style: TextStyle(fontSize: 10))),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text('스포츠', style: TextStyle(fontSize: 10))),
    ]);
  }

  void categorySelect(value) {
    if (value == 0) {
      isTravel = true;
      isSports = false;
    } else {
      isTravel = false;
      isSports = true;
    }
    setState(() {
      isSelected = [isTravel, isSports];
    });
  }
}
