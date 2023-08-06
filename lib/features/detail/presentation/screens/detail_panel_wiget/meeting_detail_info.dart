import 'package:flutter/material.dart';

class MeetingdetailInfo extends StatelessWidget {
  const MeetingdetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "장소",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 6,
            ),
            Text("종로3가 2번출구 앞"),
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
            const Text("2023.07.20"),
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
            const Text("오후 6시 30분")
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        const Row(
          children: [
            Icon(
              Icons.people_alt_rounded,
              color: Colors.grey,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "인원",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 6,
            ),
            Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                text: "4/",
              ),
              TextSpan(text: "10", style: TextStyle(color: Colors.grey))
            ])),
            SizedBox(
              width: 2,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 9,
            )
          ],
        )
      ],
    );
  }
}
