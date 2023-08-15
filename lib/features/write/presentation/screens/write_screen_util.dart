import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 공통

// 화면의 가로, 세로 길이에 맞춰 비율을 계산해주는 함수
double getWidthByPercentOfScreen(double percent, BuildContext context) {
  return MediaQuery.of(context).size.width * percent / 100;
}

double getHeightByPercentOfScreen(double percent, BuildContext context) {
  return MediaQuery.of(context).size.height * percent / 100;
}

// 큰 검정 글씨
class WritingPagesBlackText extends StatelessWidget {
  const WritingPagesBlackText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
        // 내용
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          WhiteBox(boxWidth: 5, boxHeight: 1),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF292524),
              fontSize: 24,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
          )
        ]);
  }
}

// 작은 회색 글씨
class WritingPagesGrayText extends StatelessWidget {
  const WritingPagesGrayText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
        // 내용
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          WhiteBox(boxWidth: 5, boxHeight: 1),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF808080),
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          )
        ]);
  }
}

// 공백 컨테이너
class WhiteBox extends StatelessWidget {
  WhiteBox({
    Key? key,
    required this.boxWidth,
    required this.boxHeight,
  }) : super(key: key);

  double boxWidth, boxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthByPercentOfScreen(boxWidth, context),
      height: getHeightByPercentOfScreen(boxHeight, context),
      color: Colors.white,
    );
  }
}

// 공백 상수
const double LARGEBLANK = 5.0;
const double MEDIUMBLANK = 3.0;
const double SMALLBLANK = 1.5;

// 닫기 버튼 누를 때 띄우는 창
void closeWritingPages(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, //바깥 영역 터치시 닫을지 여부 결정
    builder: ((context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          '모임을 나중에 여시겠습니까?',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 21,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 2),
        ),
        content: const Text(
          '나중에 다시 한번 좋은\n모임을 열어주세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF808080),
            fontSize: 15,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120, 40))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF61C3FF)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(120, 40))),
                  onPressed: () {
                    context.router.popUntilRouteWithName('HomeRoute'); //창 닫기
                  },
                  child: const Text(
                    '나가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }),
  );
}

// 글쓰기 화면의 '다음' 버튼
class WritingPagesNextbutton extends StatelessWidget {
  const WritingPagesNextbutton({
    Key? key,
    required this.pressNextButton,
  }) : super(key: key);

  final VoidCallback? pressNextButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFF61C3FF),
                  minimumSize: Size(
                    getWidthByPercentOfScreen(90, context),
                    getHeightByPercentOfScreen(7, context),
                  )),
              onPressed: pressNextButton,
              child: const Text(
                '다음',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ))
      ],
    );
  }
}

// write_screen1

// ScrollConfiguration에서 Behavior를 MyBehavior로 설정하면 스크롤이 가능해짐(키보드가 올라오는 경우 등)
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
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

// write_screen3

// 슬라이더로 SliderThemeData의 child를 Slider로 구성하면 여러가지 커스텀이 가능
final writeScreenLocalPeopleProvider = StateProvider<double>((ref) => 0);

class LocalPeopleSlider extends ConsumerWidget {
  const LocalPeopleSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(writeScreenLocalPeopleProvider);

    return SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.blue, // 슬라이더 버튼(Thumb)의 색상
          tickMarkShape: SliderTickMarkShape.noTickMark,
          // activeTickMarkColor: Colors.blue,
          // inactiveTickMarkColor: const Color(0xFFB2BDCF),
          valueIndicatorColor: const Color(0xFFB2BDCF),
        ), // 오버레이 색상 (터치 영역의 표시))
        child: Slider(
          value: ref.watch(writeScreenLocalPeopleProvider),
          min: 0,
          max: 20,
          divisions: 20,
          label: '${ref.watch(writeScreenLocalPeopleProvider).toInt()}',
          onChanged: (newValue) {
            ref.read(writeScreenLocalPeopleProvider.notifier).state =
                newValue; // 상태 업데이트
          },
        ));
  }
}

final writeScreenForeignPeopleProvider = StateProvider<double>((ref) => 0);

class ForeignPeopleSlider extends ConsumerWidget {
  const ForeignPeopleSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(writeScreenForeignPeopleProvider);

    return SliderTheme(
        data: SliderThemeData(
          thumbColor: Colors.blue, // 슬라이더 버튼(Thumb)의 색상
          tickMarkShape: SliderTickMarkShape.noTickMark,
          // activeTickMarkColor: Colors.blue,
          // inactiveTickMarkColor: const Color(0xFFB2BDCF),
          valueIndicatorColor: const Color(0xFFB2BDCF),
        ), // 오버레이 색상 (터치 영역의 표시))
        child: Slider(
          value: ref.watch(writeScreenForeignPeopleProvider),
          min: 0,
          max: 20,
          divisions: 20,
          label: '${ref.watch(writeScreenForeignPeopleProvider).toInt()}',
          onChanged: (newValue) {
            ref.read(writeScreenForeignPeopleProvider.notifier).state =
                newValue; // 상태 업데이트
          },
        ));
  }
}
