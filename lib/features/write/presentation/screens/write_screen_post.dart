import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'write_screen1.dart';
import 'write_screen2.dart';
import 'write_screen3.dart';
import 'write_screen4.dart';

class PostingBody {
  String title;
  String content;
  String meeting_start_time;
  int category;
  String meeting_location;
  int capacity_local;
  int capacity_travel;
  PostingBody(
      {required this.title,
      required this.content,
      required this.meeting_start_time,
      required this.category,
      required this.meeting_location,
      required this.capacity_local,
      required this.capacity_travel});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['meeting_start_time'] = meeting_start_time;
    data['category'] = category;
    data['meeting_location'] = meeting_location;
    data['capacity_local'] = capacity_local;
    data['capacity_travel'] = capacity_travel;
    return data;
  }
}

//

Future<void> postPosting(PostingBody data) async {
  final url = Uri.parse('http://3.36.185.179:8000/bulletin-board/posts/');
  final response = await http.post(url,
      headers: <String, String>{
        'authorization': 'test_1',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'title': data.title,
        'content': data.content,
        'meeting_start_time': data.meeting_start_time,
        'category': data.category,
        'meeting_location': data.meeting_location,
        'capacity_local': data.capacity_local,
        'capacity_travel': data.capacity_travel
      }));

  if (response.statusCode == 200) {
    print('success');
    // return true;
  } else if (response.statusCode == 400) {
    print('failed');
    // return false;
  } else {
    print(response.statusCode);
    // return false;
  }
}
