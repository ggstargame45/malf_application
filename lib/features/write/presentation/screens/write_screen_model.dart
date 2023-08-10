import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:riverpod/riverpod.dart';
import 'write_screen1.dart';
import 'write_screen2.dart';
import 'write_screen3.dart';
import 'write_screen4.dart';

String title = '';
String content = '';
DateTime? meeting_start_time;
String category = '';
String meeting_location = '';
int capacity_local = 0;
int capacity_travel = 0;

final writeScreenProvider = Provider((ref) {
  title = ref.watch(writeScreenTitleProvider);
  content = ref.watch(writeScreenContentProvider);
});
