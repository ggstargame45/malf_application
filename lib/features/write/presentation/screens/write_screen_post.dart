import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class PostingBody {
  String title;
  String content;
  String meeting_start_time;
  String category;
  String meeting_location;
  String capacity_local;
  String capacity_travel;
  PostingBody({
    required this.title,
    required this.content,
    required this.meeting_start_time,
    required this.category,
    required this.meeting_location,
    required this.capacity_local,
    required this.capacity_travel,
  });

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title;
    data['content'] = content;
    data['meeting_start_time'] = meeting_start_time;
    data['category'] = category;
    data['meeting_location'] = meeting_location;
    data['capacity_local'] = capacity_local;
    data['capacity_travel'] = capacity_travel;
    return data;
  }
}

// 사진이 있을 때 post 하는 방식
String baseUri = 'http://3.36.185.179:8000/';
String subUri = 'bulletin-board/posts/';
Future<bool> postPosting(PostingBody data, List<File> imageList) async {
  // MultiPartRequest로 request 정의
  var request = http.MultipartRequest('POST', Uri.parse(baseUri + subUri));

  // request에 사진 업로드
  for (int i = 0; i < imageList.length; i++) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageList[i].path));
  }

  // request 헤더 설정
  request.headers['Authorization'] = 'test_1';
  request.headers['Content-Type'] = 'multipart/form-data;';

  // request 바디 설정
  var body = data.toJson();
  request.fields.addAll(body);

  // request.send()를 통해 post
  var response = await request.send();

  if (response.statusCode == 200) {
    print('요청이 성공적으로 처리되었습니다.');
    return true;
  } else {
    print('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
    return false;
  }
}

// 사진이 없을 때 post하는 방식

// Future<bool> postPosting(PostingBody data) async {
//   final url = Uri.parse('http://3.36.185.179:8000/bulletin-board/posts/');
//   print("aaaa");
//   try {
//     print("bbbb");
//     final response = await http.post(url,
//         headers: <String, String>{
//           'authorization': 'test_1',
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(data.toJson()));

//     print("cccc");
//     if (response.statusCode == 200) {
//       print('success');
//       return true;
//     } else if (response.statusCode == 400) {
//       print('failed');
//       return false;
//     } else {
//       print(response.statusCode);
//       print("failllll");
//       return false;
//     }
//   } catch (e) {
//     print("error");
//     return false;
//   }
// }


