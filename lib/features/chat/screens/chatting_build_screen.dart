import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malf_application/features/chat/providers/chat_image_provider.dart';
import 'package:malf_application/features/chat/providers/home_provider.dart';
import 'package:malf_application/features/chat/screens/chatting_screen.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChattingBuildScreen extends StatefulWidget {
  ChattingBuildScreen({required this.postId, super.key});
  String? postId;

  @override
  State<ChattingBuildScreen> createState() => _ChattingBuildScreenState();
}

class _ChattingBuildScreenState extends State<ChattingBuildScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ChatImageProvider()),
      ],
      child: ChattingScreen(postId: widget.postId),
    );
  }
}
