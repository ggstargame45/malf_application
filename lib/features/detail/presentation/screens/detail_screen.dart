import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:malf_application/shared/theme/app_colors.dart';
import "package:sliding_up_panel/sliding_up_panel.dart";

import 'detail_panel/detail_panel.dart';
import 'detail_panel/sliding_meeting_img.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.black,
            ),
            onPressed: () {
              context.router.pop();
            },
          ),
          actions: const [
            Icon(
              Icons.more_horiz_outlined,
              color: AppColors.black,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: const MeetingDetailPanel());
  }
}

//판넬 미팅 장소 사진,미팅 정보, footer
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
      //장소사진
      body: const Center(
          child: Column(
        children: [SlidingMeetingImg()],
      )),
      parallaxEnabled: true,
      parallaxOffset: 0.3,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      minHeight: MediaQuery.of(context).size.height / 1.8,
      maxHeight: MediaQuery.of(context).size.height,
      //미팅 정보
      panelBuilder: (sc) => DetailPanel(
        controller: sc,
      ),
      collapsed: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      //footer
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
