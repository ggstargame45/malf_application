import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malf_application/features/chat/providers/home.dart';
import 'package:malf_application/features/chat/screens/chatting_screen.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChattingBuildScreen extends StatelessWidget {
  const ChattingBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: ChattingScreen(),
    );
  }
}
