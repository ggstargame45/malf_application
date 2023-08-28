import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// write_screen1 (사진, 제목, 내용, 카테고리)

// 사진 riverpod

final testProvier = StateProvider<List<File>>((ref) => []);

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

// 제목 riverpod
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

// 내용 riverpod
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

// 카테고리 riverpod
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

// write_screen2(날짜 및 시간)

// 모임 약속 시간을 해당 provider를 통해 전달함
final writeScreenDateProvider =
    StateNotifierProvider<DateNotifier, String>((ref) {
  return DateNotifier();
});

class DateNotifier extends StateNotifier<String> {
  DateNotifier()
      : super("${DateFormat('yyyy-MM-dd ').format(DateTime.now())}18:00:00");

  void setDate(String date) {
    state = date;
  }
}

// 캘린더에서 선택한 날짜를 반영하기 위해 필요
final selectedDayProvider =
    StateNotifierProvider<SelectedDayNotifier, DateTime>((ref) {
  return SelectedDayNotifier();
});

class SelectedDayNotifier extends StateNotifier<DateTime> {
  SelectedDayNotifier()
      : super(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ));

  void setDate(DateTime date) {
    state = date;
  }
}

final focusedDayProvider =
    StateNotifierProvider<FocusedDayNotifier, DateTime>((ref) {
  return FocusedDayNotifier();
});

class FocusedDayNotifier extends StateNotifier<DateTime> {
  FocusedDayNotifier() : super(DateTime.now());

  void setDate(DateTime date) {
    state = date;
  }
}

// 타임피커에서 선택한 시간을 반영하기 위해 필요
final timePickerProvider =
    StateNotifierProvider<TimePickerNotifier, String>((ref) {
  return TimePickerNotifier();
});

class TimePickerNotifier extends StateNotifier<String> {
  TimePickerNotifier() : super("오후 06:00");

  void setTime(String time) {
    state = time;
  }
}

// ExpandedPanel의 확장 여부를 반영하기 위해 필요
final dateCalendarExpandedProvider = StateProvider<bool>((ref) => false);
final datePickerExpandedProvider = StateProvider<bool>((ref) => false);

// write_screen3

// 장소
final writeScreenPlaceProvider =
    StateNotifierProvider<PlaceNotifier, String>((ref) {
  return PlaceNotifier();
});

class PlaceNotifier extends StateNotifier<String> {
  PlaceNotifier() : super('');

  void setText(String text) {
    state = text;
  }
}

// 슬라이더
final writeScreenLocalPeopleProvider = StateProvider<double>((ref) => 0);
final writeScreenForeignPeopleProvider = StateProvider<double>((ref) => 0);
