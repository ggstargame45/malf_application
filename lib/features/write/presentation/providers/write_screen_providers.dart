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

// 날짜 및 시간
final writeScreenDateProvider =
    StateNotifierProvider<DateNotifier, String>((ref) {
  return DateNotifier();
});

class DateNotifier extends StateNotifier<String> {
  DateNotifier()
      : super("${DateFormat('yyyy-MM-dd ').format(DateTime.now())}18:00:00");

  void setText(String text) {
    state = text;
  }
}

// final writeScreenLocalPeopleProvider = StateProvider<double>((ref) => 0);