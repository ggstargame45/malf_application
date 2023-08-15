import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/detail/constants/url_const.dart';

import '../../../data/provider/detail_data_provider.dart';

class SlidingMeetingImg extends ConsumerWidget {
  const SlidingMeetingImg({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonData = ref.watch(jsonDataProvider).jsonData.data!.first;
    List<dynamic> meetingImgArray = jsonDecode(jsonData!.meetingpic!);
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: meetingImgArray.map((i) {
        return Builder(
          builder: (BuildContext context) {
            Logger().d(i);
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
