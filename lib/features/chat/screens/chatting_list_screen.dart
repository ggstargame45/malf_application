import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/features/chat/models/chatting_list_data_model.dart';
import 'package:malf_application/features/detail/constants/url_const.dart';

@RoutePage()
class ChattingListScreen extends StatefulWidget {
  const ChattingListScreen({super.key});

  @override
  State<ChattingListScreen> createState() => _ChattingListScreenState();
}

class _ChattingListScreenState extends State<ChattingListScreen> {
  final _dio = Dio(BaseOptions(
      baseUrl: Url.baseUrl,
      headers: {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX3VuaXFfaWQiOiJ0ZXN0XzEiLCJpYXQiOjE2OTI2Mjg2MTcsImV4cCI6MTcyNDE2NDYxN30.-X3GnzUEMfmpIRXznFtdJdDr5x5aWa-D_kU_w9mU6hk'
      },
      responseType: ResponseType.json));
  List<ChattingListModel> chattingListData = [];

  Future<dynamic> request() async {
    try {
      final response = await _dio.get("/chatroom/chatrooms");
      Logger().d(response.data);
      chattingListData = (json.decode(response.data) as List)
          .map((data) =>
              ChattingListModel.fromJson(data as Map<String, dynamic>))
          .toList();
      return response.data;
    } catch (error) {
      Logger().e(error);
    }
  }

  @override
  void initState() {
    request();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 0,
            centerTitle: false,
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "메세지",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
        body: Column(
          children: [
            Container(
              height: 60,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8),
                      filled: true,
                      fillColor: Color.fromARGB(97, 158, 158, 158),
                      hintText: "채팅방을 검색하세요",
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  maxLines: null,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 22, 12, 22),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              minRadius: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: Text("왕십리역에서 같이 치킨 맛잇겟지",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Icon(
                                        Icons.people_alt,
                                        size: 16,
                                        color: Colors.indigo,
                                      ),
                                      Text("8",
                                          style: TextStyle(
                                              color: Colors.indigoAccent)),
                                      SizedBox(
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      "안녕하세요 친구랑 여행오셨나바요?ㅋㅋㅋㅋㅋㅋ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "40분 전",
                              style: TextStyle(color: Colors.grey),
                            )
                          ]),
                    ),
                  );
                  return null;
                },
              ),
            ))
          ],
        ));
  }
}
