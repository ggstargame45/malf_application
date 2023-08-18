import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/json_data_model.dart';
import 'meeting_detail_info.dart';
import 'user_container.dart';

//판넬위의 미팅 정보들
class DetailPanel extends ConsumerWidget {
  final ScrollController controller;
  Datum? jsonData;
  DetailPanel({super.key, required this.controller, required this.jsonData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        controller: controller,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 32),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(0xB0000000),
                  ),
                  child:
                      const Text("투어", style: TextStyle(color: Colors.white)),
                ),
                Text(
                  "${jsonData!.title}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: MeetingdetailInfo(jsonData: jsonData)),
              ],
            ),
          ),
          Container(
              height: 1,
              width: 343,
              color: const Color.fromARGB(255, 215, 213, 213)),
          //유저 정보
          UserContainer(
            jsonData: jsonData,
          ),
          //미팅 내용
          Text("${jsonData!.content}"),
          const SizedBox(
            height: 16,
          ),
          //googleMap
          const GoogleMapContainer(),
          const SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}

class GoogleMapContainer extends ConsumerWidget {
  const GoogleMapContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 400,
      width: 300,
      color: Colors.amber,
    );
  }
}
