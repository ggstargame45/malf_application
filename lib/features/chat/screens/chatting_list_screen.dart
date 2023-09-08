import 'package:flutter/material.dart';

class ChattingListScreen extends StatefulWidget {
  const ChattingListScreen({super.key});

  @override
  State<ChattingListScreen> createState() => _ChattingListScreenState();
}

class _ChattingListScreenState extends State<ChattingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        title: const Center(
            child: Text(
          "경복궁 같이가요!",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        )),
        actions: const [
          Icon(Icons.menu_rounded, color: Colors.black),
          SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
