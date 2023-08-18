import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/detail/constants/url_const.dart';

import '../../../data/models/json_data_model.dart';

class UserContainer extends ConsumerWidget {
  Datum? jsonData;
  UserContainer({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger().d(jsonDecode(jsonData!.authorpicture!)[0]);
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            minRadius: 25,
            backgroundImage: NetworkImage(
                "${Url.baseUrl}/${jsonDecode(jsonData!.authorpicture!)[0]}"),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 68, 176, 253),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    jsonData!.usertype == 0 ? "현지인" : "여행객",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "${jsonData!.authornickname}",
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Icon(
                      Icons.adobe_outlined,
                      size: 16,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
