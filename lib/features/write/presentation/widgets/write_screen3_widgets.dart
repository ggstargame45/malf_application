import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/write_screen_providers.dart';

// 슬라이더로 SliderThemeData의 child를 Slider로 구성하면 여러가지 커스텀이 가능

class LocalPeopleSlider extends ConsumerWidget {
  const LocalPeopleSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(writeScreenLocalPeopleProvider);

    return SliderTheme(
        // 슬라이더의 색상 등을 커스텀하려면 사용
        data: SliderThemeData(
          thumbColor: Colors.blue, // 슬라이더 버튼(Thumb)의 색상
          tickMarkShape: SliderTickMarkShape
              .noTickMark, // 슬라이더 내 범위마다 칸 설정(noTickMark는 해당 없음)
          // activeTickMarkColor: Colors.blue,
          // inactiveTickMarkColor: const Color(0xFFB2BDCF),
          valueIndicatorColor: const Color(0xFFB2BDCF), // 슬라이더 위에 나오는 현재 숫자 색상
        ),
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
