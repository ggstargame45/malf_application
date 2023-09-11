import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malf_application/features/chat/screens/chatting_screen.dart';

@RoutePage()
class ChattingBuildScreen extends StatelessWidget {
  ChattingBuildScreen({required this.postId, super.key});
  String? postId;
  @override
  Widget build(BuildContext context) {
    return ChattingScreen(
      postId: postId,
    );
  }
}
