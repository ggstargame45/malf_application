import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/features/detail/constants/ui_const.dart';

void categorySelectSheet(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // ignore: prefer_const_constructors
      builder: (context) => CategorySelectContainer());
}

class CategorySelectContainer extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  CategorySelectContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width,
      height: 600,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: MalfColor().unselectedGrey,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("대표 카테고리 선택",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 50,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Container(
                      width: 165,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: MalfColor().unselectedGrey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  textStyle: const TextStyle()),
                              onPressed: () {},
                              child: const Text(
                                "여행",
                                style: TextStyle(color: Colors.black),
                              ))),
                    ),
                    Container(
                      width: 165,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: MalfColor().unselectedGrey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: const Center(child: Text("스포츠")),
                    ),
                    Container(
                      width: 165,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: MalfColor().unselectedGrey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: const Center(child: Text("영화")),
                    ),
                    Container(
                      width: 165,
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: MalfColor().unselectedGrey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: const Center(child: Text("독서")),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 343,
                  height: 60,
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                        foregroundColor: MalfColor().selectedBlue,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "다음",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
