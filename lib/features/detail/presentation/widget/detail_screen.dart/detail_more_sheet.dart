import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malf_application/config/routes/app_route.dart';

import '../../../data/network/network.dart';
import './modify_screen.dart';

void detailMoreSheet(context, postId) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 260,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    context.router.popUntilRouteWithName(HomeRoute.name);
                    Network(postId: postId).delete();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.sizeOf(context).width,
                      height: 60,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                            size: 30,
                          ),
                          Text(
                            "게시물 삭제",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                ),
                Container(
                  width: 380,
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(49, 158, 158, 158),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    settingWriteScreenProvider(postId);
                    context.router.push(WriteRoute1());
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.sizeOf(context).width,
                      height: 60,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.mode_edit_outlined,
                            color: Color.fromARGB(138, 158, 158, 158),
                            size: 30,
                          ),
                          Text(
                            "게시물 수정",
                            style: TextStyle(
                                color: Color.fromARGB(138, 158, 158, 158),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // SizedBox 대신 Container를 사용 가능
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                )
              ],
            ),
          ));
}
