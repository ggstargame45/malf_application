import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:malf_application/config/routes/app_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen.freezed.dart';
part 'home_screen.g.dart';

const baseUrl = "http://13.125.43.68:8000/";
const baseId = "";
const koreaE = "🇰🇷";
const usaE = "🇺🇲";
const japanE = "🇯🇵";
const chinaE = "🇨🇳";
const germanyE = "🇩🇪";

@riverpod
class PageNumberNotifier extends _$PageNumberNotifier {
  @override
  int build() {
    return 1;
  }

  void increment() {
    state++;
  }
}

@riverpod
class DataListNotifier extends _$DataListNotifier {
  @override
  List<ListItemData> build() {
    return [];
  }

  void addData(List<ListItemData> newData) {
    state = state + newData;
  }
}

@riverpod
class IsEndOfList extends _$IsEndOfList {
  @override
  bool build() {
    return false;
  }

  void setEndOfList(bool value) {
    state = value;
  }
}

@riverpod
FutureOr<List<ListItemData>> fetchData(Ref ref, int a) async {
  final dio = Dio(BaseOptions(
    baseUrl: '${baseUrl}bulletin-board/posts',
    headers: {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX3VuaXFfaWQiOiJ0ZXN0XzEiLCJpYXQiOjE2OTI2Mjg2MTcsImV4cCI6MTcyNDE2NDYxN30.-X3GnzUEMfmpIRXznFtdJdDr5x5aWa-D_kU_w9mU6hk'
    },
  ));
  final pageNumber = ref.read(pageNumberNotifierProvider);

  try {
    final response = await dio.get("/?page=$pageNumber&limit=10");
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      List<ListItemData> result =
          data.map((e) => ListItemData.fromJson(e)).toList();
      return result;
    } else {
      return [];
    }
  } catch (error) {
    logger.e(error);
    return [];
  }
}

// @riverpod
// class FetchData extends _$FetchData {
//   @override
//   Future<List<ListItemData>> build() async {
//     return [];
//   }
// }

// class FetchData extends StateNotifier<AsyncValue<List<ListItemData>>> {
//   FetchData() : super(const AsyncValue.loading()) {
//     logger.d("FetchData");
//     started();
//   }
//   final dio = Dio(BaseOptions(
//     baseUrl: '${baseUrl}bulletin-board/posts',
//     headers: {'Authorization': 'test_1'},
//   ));

//   List<ListItemData> fetchList = [];
//   int currentPageNo = 1;
//   bool isAdd = false;
//   Future<void> started() async {
//     logger.d("started");
//     await _getPhotos();
//   }

//   Future<List<ListItemData>> _fetchPost({
//     required int pageNo,
//   }) async {
//     logger.d("fetchPost");
//     try {
//       final response = await dio.get("/?page=$pageNo&limit=10");
//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data['data'];
//         List<ListItemData> result =
//             data.map((e) => ListItemData.fromJson(e)).toList();
//         return result;
//       } else {
//         return [];
//       }
//     } catch (error) {
//       logger.e(error);
//       return [];
//     }
//   }

//   Future<void> _getPhotos() async {
//     logger.d("_getPhotos");
//     List<ListItemData>? data = await _fetchPost(pageNo: currentPageNo);
//     state = AsyncValue.data(data);
//     currentPageNo = 2;
//     logger.e(currentPageNo);
//   }

//   void scrollListerner(ScrollUpdateNotification notification) {
//     logger.d("scrollListerner");
//     if (notification.metrics.maxScrollExtent * 0.85 <
//         notification.metrics.pixels) {
//       _morePhotos();
//     }
//   }

//   Future<void> _morePhotos() async {
//     logger.d("_morePhotos");
//     if (!isAdd) {
//       isAdd = true;
//       List<ListItemData>? newData = await _fetchPost(pageNo: currentPageNo);
//       if (state is AsyncData<List<ListItemData>>) {
//         List<ListItemData> currentData =
//             (state as AsyncData<List<ListItemData>>).value;
//         currentData.addAll(newData);
//         state = AsyncValue.data(currentData);
//       }
//       currentPageNo = currentPageNo + 1;
//       isAdd = false;
//     }
//   }
// }

final logger = Logger();

@freezed
class ListItemData with _$ListItemData {
  const factory ListItemData({
    @JsonKey(name: 'post_id') required int postId,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'author_nickname') required String authorNickname,
    @JsonKey(name: 'author_nation') required int authorNation,
    @JsonKey(name: 'user_type') required int userType,
    @JsonKey(name: 'meeting_capacity') required int meetingCapacity,
    @JsonKey(name: 'meeting_pic')
    @PicListConverter()
    required List<String> meetingPic,
    //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞쪽에서 한번 더 파싱 해야함
    @JsonKey(name: 'meeting_location') required String meetingLocation,
    //@TODO : meetingPic과 meetingStartTime은 String으로 받아서 앞에서 한번 더 파싱 해야함
    @JsonKey(name: 'meeting_start_time')
    @DateTimeConverter()
    required DateTime meetingStartTime,
  }) = _ListItemData;

  factory ListItemData.fromJson(Map<String, dynamic> json) =>
      _$ListItemDataFromJson(json);
}

class PicListConverter implements JsonConverter<List<String>, String> {
  const PicListConverter();

  @override
  List<String> fromJson(String json) {
    return List<String>.from(jsonDecode(json));
  }

  @override
  String toJson(List<String> object) {
    return jsonEncode(json);
  }
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}

@RoutePage()
class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  int selectedBottomIndex = 0;
  // final fetchDataProvider =
  //     StateNotifierProvider<FetchData, AsyncValue<List<ListItemData>>>(
  //         (ref) => FetchData());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchDatas = ref.watch(fetchDataProvider(10));
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logos/malf_logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon:
                const Icon(Icons.search_rounded, color: Colors.black, size: 30),
          ),
          IconButton(
            onPressed: () => {
              //logger.e(fetchDatas)
            },
            icon: const Icon(Icons.calendar_month_rounded,
                color: Colors.black, size: 30),
          ),
        ],
      ),
      /*


      */
      body: fetchDatas.when(
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenWidth / 2,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          5, // Assume banners is a list of your banner data.
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: screenWidth,
                            height: screenWidth / 2,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "http://3.36.185.179:8000/ad/1.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: screenWidth,
                      height: screenWidth / 3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenWidth / 6,
                              child: Image.asset(
                                "assets/images/category/bar.png",
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenWidth / 6,
                              child: Image.asset(
                                "assets/images/category/culture.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenWidth / 6,
                              child: Image.asset(
                                "assets/images/category/food.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenWidth / 6,
                              child: Image.asset(
                                "assets/images/category/sports.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 6,
                              height: screenWidth / 6,
                              child: Image.asset(
                                "assets/images/category/study.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (index == data.length - 1) {
                        // Handle loading next page if required.
                      }

                      return GestureDetector(
                        onTap: () {
                          context.router
                              .push(DetailRoute(postId: data[index].postId));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '$baseUrl${data[index].meetingPic[0]}',
                                          headers: const {
                                            'Authorization': 'test_1'
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return const Text('😢');
                                          },
                                          fit: BoxFit.cover,
                                          frameBuilder: (BuildContext context,
                                              Widget child,
                                              int? frame,
                                              bool wasSynchronouslyLoaded) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: const Color.fromRGBO(
                                                    91, 91, 91, 1),
                                              ),
                                              child: child,
                                            );
                                          },
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: const Color.fromRGBO(
                                                    91, 91, 91, 1),
                                              ),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${data[index].authorNickname} ${data[index].userType == 0 ? "관광객" : "현지인"} ${data[index].meetingCapacity}"),
                                        Text(data[index].title,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${data[index].meetingLocation} ${data[index].meetingStartTime.year}-${data[index].meetingStartTime.month}-${data[index].meetingStartTime.day}"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const CircularProgressIndicator()),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(WriteRoute1()),
        child: const Icon(Icons.add),
      ),
      //
      //
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: '메시지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
        currentIndex: selectedBottomIndex,
        selectedItemColor: const Color.fromARGB(255, 97, 194, 255),
        unselectedItemColor: const Color.fromARGB(255, 68, 68, 68),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              Logger().d("tap");
              context.router.push(const ChattingListRoute());
              break;
            case 3:
              break;
            case 4:
              break;
          }
        },
      ),
    );
  }

  GestureDetector _content({
    required String title,
    required String content,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {},
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
                fontSize: 14, color: Color.fromRGBO(215, 215, 215, 1)),
          ),
        ],
      ),
    );
  }
}

// AboutDialog(
//   applicationName: 'Malf',
//   applicationVersion: '0.0.1',
//   applicationIcon: const Image(
//     image: AssetImage('assets/logos/malf_logo.png'),
//     width: 50,
//     height: 50,
//   ),
//   children: [
//     const
//         // ignore: avoid_annotating_with_dynamic
//         Text('Malf는 외국인과 관광객을 위한 플랫폼.'),

//   ],
// );
// Autocomplete(
//   optionsBuilder: (TextEditingValue textEditingValue) {
//     if (textEditingValue.text == '') {
//       return const Iterable<String>.empty();
//     }
//     return ['abb', 'bcc', 'cdd'];
//   },
//   onSelected: (String selection) {
//     TextEditingController().text = selection;
//   },
// );
//showDialog(context: context, builder: (context) => const AlertDialog());

/*
    밑에서 떠오르는거, 지도 검색이나 설정을 눌렀을 때
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: Text('This is a ModalBottomSheet'),
        );
      },
    );




      */ /*
    




      */  
/*
    





*/    
/*
    





*/
