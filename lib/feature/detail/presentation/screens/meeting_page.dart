import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:sliding_up_panel/sliding_up_panel.dart";

import './detail_panel/sliding_meeting_img.dart';
import 'detail_panel/detail_panel.dart';

class MeetingDetailPage extends ConsumerWidget {
  const MeetingDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(Icons.arrow_back_ios_new_rounded),
          actions: const [
            Icon(Icons.more_horiz_outlined),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: const MeetingDetailPanel());
  }
}

class MeetingDetailPanel extends StatefulWidget {
  const MeetingDetailPanel({super.key});

  @override
  State<MeetingDetailPanel> createState() => _MeetingDetailPanelState();
}

class _MeetingDetailPanelState extends State<MeetingDetailPanel> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      body: const Center(
          child: Column(
        children: [SlidingMeetingImg()],
      )),
      parallaxEnabled: true,
      parallaxOffset: 0.3,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      minHeight: MediaQuery.of(context).size.height / 1.8,
      maxHeight: MediaQuery.of(context).size.height,
      panelBuilder: (sc) => DetailPanel(
        controller: sc,
      ),
      collapsed: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      footer: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            isLiked
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
            const Text("123")
          ]),
          Container(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.fromLTRB(20, 19, 20, 19)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: const Text(
                    "참여자 확인",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.fromLTRB(40, 19, 40, 19)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                  child: const Text(
                    "참여요청",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
