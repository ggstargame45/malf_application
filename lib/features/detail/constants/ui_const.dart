import 'package:flutter/widgets.dart';

class Size {
  /*앱바, 모임글 카드 패딩 */
  EdgeInsets padding16px = const EdgeInsets.fromLTRB(16, 16, 16, 16);

  EdgeInsets paddingHorizontal16px = const EdgeInsets.fromLTRB(0, 16, 0, 16);

  /* 텍스트 컨테이너 패딩 */
  EdgeInsets padding16px20px = const EdgeInsets.fromLTRB(16, 20, 16, 20);
  EdgeInsets paddingHorizontal20px = const EdgeInsets.fromLTRB(0, 20, 0, 20);

  /* 채팅 버블 패딩 */
  EdgeInsets padding12px10px = const EdgeInsets.fromLTRB(12, 10, 12, 10);
}

class RadiusCircular {
  /*토글 패널 radius */
  BorderRadius radiusCircular10 =
      const BorderRadius.vertical(top: Radius.circular(10));
  /*버튼 radius */
  BorderRadius radiusCircular12 = BorderRadius.circular(12);
  /*카테고리 버튼, 유저 타입 버튼 radius */
  BorderRadius radiusCircular16 = BorderRadius.circular(30);
}

class MalfColor {
  Color selectedBlue = const Color(0xff61C3FF);
  Color unselectedGrey = const Color(0xffBEBEBE);
  Color underLineGrey = const Color(0xffC8CAD0);

  Color selectedGreen = const Color(0xff28CE74);
  Color IconGrey = const Color(0xff444444);
  Color IconBlack = const Color(0xff1A1A1A);
  Color textGrey = const Color(0xff808080);
  Color errorRed = const Color(0xffFF6060);
}
