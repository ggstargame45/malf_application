import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:malf_application/features/detail/data/data_parsing.dart';
import 'package:malf_application/features/detail/data/network.dart';
import 'package:malf_application/shared/theme/app_colors.dart';
import "package:sliding_up_panel/sliding_up_panel.dart";

import 'detail_panel_wiget/detail_panel.dart';
import 'detail_panel_wiget/footer_widget.dart';
import 'detail_panel_wiget/sliding_meeting_img.dart';

Future jsonString = Network(
        baseUrl: "http://3.36.185.179:8000/bulletin-board/posts/", userId: "0")
    .request();

final jsonData = jsonDataFromJson(jsonString.toString());

final jsonDataProvider = FutureProvider<Datum>((ref) => jsonData.data[0]);

@RoutePage()
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
      //footer
      footer: const FooterWigdget(),
      //미팅 정보
      panelBuilder: (sc) => DetailPanel(
        controller: sc,
      ),
    );
  }
}
