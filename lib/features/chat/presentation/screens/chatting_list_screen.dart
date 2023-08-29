import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malf_application/config/routes/app_route.dart';

import '../../../../shared/theme/app_colors.dart';

@RoutePage()
class ChattingListScreen extends StatefulWidget {
  const ChattingListScreen({super.key});

  @override
  State<ChattingListScreen> createState() => _ChattingListScreenState();
}

class _ChattingListScreenState extends State<ChattingListScreen> {
  final bool isChattingExist = true;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Center(
                child: Text(
                  "메세지",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 16),
                ),
              ),
            )),
        body: isChattingExist
            ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  children: [
                    Card(
                      child: TextButton(
                          onPressed: () {
                            context.router.push(const ChattingRoute());
                          },
                          child: const Text("chatting")),
                    )
                  ],
                ),
              )
            : const Center(
                child: Text("모임에 참여하고, 다양한 사람들과 대화해보세요"),
              ));
  }
}
