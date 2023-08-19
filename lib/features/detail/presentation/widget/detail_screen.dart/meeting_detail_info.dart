import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/json_data_model.dart';

class MeetingdetailInfo extends ConsumerWidget {
  Datum? jsonData;
  MeetingdetailInfo({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime dateTime = DateTime.parse(jsonData!.meetingstarttime!);
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 3,
            ),
            const Text(
              "장소",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(jsonData!.meetinglocation!),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 3,
            ),
            const Text(
              "날짜",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(formattedDate),
            const SizedBox(
              width: 6,
            ),
            Container(
              width: 1,
              height: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(formattedTime)
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            const Icon(
              Icons.people_alt_rounded,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 3,
            ),
            const Text(
              "인원",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              width: 6,
            ),
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                text: "${jsonData!.participationstatus}/",
              ),
              TextSpan(
                  text: "${jsonData!.meetingcapacity}",
                  style: const TextStyle(color: Colors.grey))
            ])),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        )
      ],
    );
  }
}
