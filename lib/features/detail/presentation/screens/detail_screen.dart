import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:malf_application/features/detail/data/provider/detail_data_provider.dart';
import 'package:malf_application/shared/theme/app_colors.dart';
import "package:sliding_up_panel/sliding_up_panel.dart";

import '../../data/models/json_data_model.dart';
import '../widget/detail_screen.dart/detail_more_sheet.dart';
import '../widget/detail_screen.dart/detail_panel.dart';
import '../widget/detail_screen.dart/footer_widget.dart';
import '../widget/detail_screen.dart/sliding_meeting_img.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class DetailScreen extends ConsumerWidget {
  final int postId;
  const DetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonDataState = ref.watch(jsonDataProvider(postId));
    return jsonDataState.when(error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const CircularProgressIndicator();
    }, data: (data) {
      final jsonDataState = data.jsonData.status;
      final jsonData = data.jsonData.data!.first;
      logger.d("$jsonDataState");

      return Scaffold(
          key: scaffoldKey,
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
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.more_horiz_outlined,
                    color: AppColors.black,
                  ),
                  onPressed: () {
                    detailMoreSheet(context);
                  }),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          body: data.isLoading
              ? const Center(child: CircularProgressIndicator())
              : MeetingDetailPanel(jsonData: jsonData!));
    });
  }
}

//판넬 미팅 장소 사진,미팅 정보, footer
class MeetingDetailPanel extends StatelessWidget {
  final Datum jsonData;

  const MeetingDetailPanel({required this.jsonData, super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      //장소사진
      body: Center(
          child: Column(
        children: [
          SlidingMeetingImg(
            meetingPic: jsonData.meetingpic,
          )
        ],
      )),
      parallaxEnabled: true,
      parallaxOffset: 0.3,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      minHeight: MediaQuery.of(context).size.height / 1.8,
      maxHeight: MediaQuery.of(context).size.height,
      //footer
      footer: FooterWigdget(
        jsonData: jsonData,
      ),
      //미팅 정보
      panelBuilder: (sc) => DetailPanel(
        controller: sc,
        jsonData: jsonData,
      ),
    );
  }
}

// @RoutePage()
// class DetailScreen extends ConsumerWidget {
//   final int postId;
//   const DetailScreen({super.key, required this.postId});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final jsonDataProviderData = ref.watch(jsonDataNotifierProvider(postId));
//     return jsonDataProviderData.when(
//         data: (data) {
//           return Scaffold(
//               key: scaffoldKey,
//               appBar: AppBar(
//                 backgroundColor: AppColors.white,
//                 leading: IconButton(
//                   icon: const Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                     color: AppColors.black,
//                   ),
//                   onPressed: () {
//                     context.router.pop();
//                   },
//                 ),
//                 actions: [
//                   IconButton(
//                       icon: const Icon(
//                         Icons.more_horiz_outlined,
//                         color: AppColors.black,
//                       ),
//                       onPressed: () {
//                         detailMoreSheet(context);
//                       }),
//                   const SizedBox(
//                     width: 10,
//                   )
//                 ],
//               ),
//               body: const MeetingDetailPanel());
//         },
//         error: (error, stackTrace) => Center(child: Text(error.toString())),
//         loading: () => const CircularProgressIndicator());
//   }
// }

// //판넬 미팅 장소 사진,미팅 정보, footer
// class MeetingDetailPanel extends StatefulWidget {
//   const MeetingDetailPanel({
//     super.key,
//   });

//   @override
//   State<MeetingDetailPanel> createState() => _MeetingDetailPanelState();
// }

// class _MeetingDetailPanelState extends State<MeetingDetailPanel> {
//   @override
//   Widget build(BuildContext context) {
//     return SlidingUpPanel(
//       //장소사진
//       body: Center(
//           child: Column(
//         children: [
//           SlidingMeetingImg(
//             postId: postIdd,
//           )
//         ],
//       )),
//       parallaxEnabled: true,
//       parallaxOffset: 0.3,
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//       minHeight: MediaQuery.of(context).size.height / 1.8,
//       maxHeight: MediaQuery.of(context).size.height,
//       //footer
//       footer: const FooterWigdget(),
//       //미팅 정보
//       panelBuilder: (sc) => DetailPanel(
//         controller: sc,
//         postId: postIdd,
//       ),
//     );
//   }
// }