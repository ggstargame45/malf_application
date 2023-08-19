import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/features/detail/constants/url_const.dart';

class SlidingMeetingImg extends ConsumerWidget {
  String? meetingPic;
  SlidingMeetingImg({required this.meetingPic, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<dynamic> meetingImgArray = jsonDecode(meetingPic!);
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: meetingImgArray.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${Url.baseUrl}/$i"),
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
