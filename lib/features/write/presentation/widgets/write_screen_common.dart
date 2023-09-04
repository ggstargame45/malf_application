import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// 페이지 애니메이션
class PageRouteWithAnimation {
  final Widget page;

  PageRouteWithAnimation(this.page);

  Route slideRitghtToLeft() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route slideLeftToRight() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

// 화면의 가로, 세로 길이에 맞춰 비율을 계산해주는 함수
double getWidthByPercentOfScreen(double percent, BuildContext context) {
  return MediaQuery.of(context).size.width * percent / 100;
}

double getHeightByPercentOfScreen(double percent, BuildContext context) {
  return MediaQuery.of(context).size.height * percent / 100;
}

// 공통 앱바
PreferredSizeWidget WriteScreenAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        iconSize: 24,
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        }),
    actions: [
      IconButton(
        icon: const Icon(Icons.close),
        iconSize: 33,
        color: Colors.black,
        onPressed: () {
          closeWritingPages(context);
        },
      )
    ],
  );
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

  // pressNextButton은 버튼 활성화 여부
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

// ScrollConfiguration에서 Behavior를 MyBehavior로 설정하면 스크롤이 가능해짐(키보드가 올라오는 경우 등)
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
