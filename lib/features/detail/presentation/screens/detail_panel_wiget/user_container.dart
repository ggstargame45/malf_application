import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/detail/data/constants.dart';

import '../../../data/detail_data_provider.dart';

class UserContainer extends ConsumerWidget {
  const UserContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonData = ref.watch(jsonDataProvider).jsonData.data!.first;

    String extractFileName(String input) {
      // 정규표현식을 사용하여 ".jpeg"로 끝나는 문자열을 추출합니다.
      RegExp regExp = RegExp(r'\"(.+\.jpeg)\"');
      Match? match = regExp.firstMatch(input);

      if (match != null && match.groupCount > 0) {
        return match.group(1)!; // 첫 번째 캡처 그룹의 내용을 반환합니다.
      } else {
        return ''; // 일치하는 내용이 없으면 빈 문자열을 반환합니다.
      }
    }

    Logger().d(Url.baseUrl +
        Url.detailUrl +
        extractFileName(jsonData!.authorpicture!));
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "${Url.baseUrl}/${extractFileName(jsonData.authorpicture!)}"),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 68, 176, 253),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  jsonData.usertype == 0 ? "현지인" : "여행객",
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    "${jsonData.authornickname}",
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
          )
        ],
      ),
    );
  }
}
