import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/write_screen_providers.dart';
import 'write_screen_common.dart';
import 'dart:io';

// 이미지를 갤러리에서 선택하는 카메라 버튼
class ImageSelector extends ConsumerWidget {
  const ImageSelector(
      {super.key, required this.picker, required this.imageList});

  final picker;
  final List<File> imageList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: getHeightByPercentOfScreen(10, context),
        height: getHeightByPercentOfScreen(10, context),
        child: ElevatedButton(
          onPressed: () async {
            if (imageList.length < 10) {
              final image = await picker.pickImage(
                  source: ImageSource.gallery); // 갤러리에서 이미지 뽑아옴
              imageList.add(File(image!.path));
              ref.refresh(writeScreenImageProvider.notifier);
              ref.read(writeScreenImageProvider.notifier).refresh(imageList);
            }
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: const Color(0xFFF7F7F7),
            side: const BorderSide(width: 0.75, color: Color(0xFFD3D3D3)),
            elevation: 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.photo_camera_rounded,
                size: 38,
                color: Color(0xFFBEBEBE),
              ),
              Text("${ref.watch(writeScreenImageProvider).length} / 10",
                  style: const TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'Pretendard',
                      fontSize: 12)),
            ],
          ),
        ));
  }
}

// 선택한 이미지들을 보여주고 제거할 수 있는 화면
class ImageListView extends ConsumerWidget {
  const ImageListView({super.key, required this.imageList});
  final imageList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: getHeightByPercentOfScreen(10, context),
      width: getWidthByPercentOfScreen(66, context),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ref.watch(writeScreenImageProvider).length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.75, color: Color(0xFFD3D3D3)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), // ClipRRect의 모서리 설정
                  child: Stack(
                    children: [
                      Image.file(
                        ref.watch(writeScreenImageProvider)[index],
                        height: getHeightByPercentOfScreen(10, context),
                        width: getHeightByPercentOfScreen(10, context),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: getWidthByPercentOfScreen(-2, context),
                          right: getWidthByPercentOfScreen(2, context),
                          child: SizedBox(
                              width: 20,
                              child: FloatingActionButton(
                                backgroundColor: const Color(0xFFD3D3D3),
                                onPressed: () {
                                  imageList.removeAt(index);
                                  ref.refresh(writeScreenImageProvider);
                                  ref
                                      .read(writeScreenImageProvider.notifier)
                                      .refresh(imageList);
                                }, // 해당 이미지 삭제
                                child: const Icon(Icons.close,
                                    size: 15, color: Colors.white),
                              )))
                    ],
                  )));
        },
        separatorBuilder: (BuildContext context, int index) =>
            WhiteBox(boxWidth: MEDIUMBLANK, boxHeight: 0),
      ),
    );
  }
}

// 카테고리 버튼
Color categoryColor = const Color(0xFFBEBEBE);

class CategoryButton extends ConsumerWidget {
  String category;
  CategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(writeScreenCategoryProvider).length > 5) {
      categoryColor = const Color(0xFFBEBEBE);
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            minimumSize: Size(
              getWidthByPercentOfScreen(42, context),
              getHeightByPercentOfScreen(7, context),
            )),
        onPressed: () {
          ref.read(writeScreenCategoryProvider.notifier).setText(category);
          categoryColor = Colors.black;
          Navigator.pop(context);
        },
        child: Text(category, style: const TextStyle(color: Colors.black)));
  }
}

// 카테고리 설정 창
class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: getHeightByPercentOfScreen(50, context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
                    const WritingPagesBlackText(text: "대표 카테고리 선택"),
                    WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CategoryButton(category: "여행"),
                        CategoryButton(category: "맛집"),
                      ],
                    ),
                    WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CategoryButton(category: "독서"),
                        CategoryButton(
                          category: "스포츠",
                        )
                      ],
                    ),
                    WhiteBox(boxWidth: 0, boxHeight: MEDIUMBLANK),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [CategoryButton(category: "영화")],
                    )
                  ],
                ),
              );
            },
            backgroundColor: Colors.transparent);
      },
      child: Container(
          width: getWidthByPercentOfScreen(90, context),
          height: getHeightByPercentOfScreen(6.5, context),
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: Color(0xFFD3D3D3)),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(ref.watch(writeScreenCategoryProvider),
                style: TextStyle(
                  color: categoryColor,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ))
          ])),
    );
  }
}
