import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final dio = Dio();
var logger = Logger();
Future<void> request() async {
  try {
    final response =
        await dio.get('http://3.36.185.179:8000/bulletin-board/post/0');
    return response.data["data"][0];
  } catch (error) {
    logger.d('오류: $error');
  }
}

Future<void> post(int userId, int like, int participantionStatus) async {
  if (like == 0) {
    like = 1;
  } else if (like == 1) {
    like = 0;
  }

  try {
    final response = await dio
        .post('http://3.36.185.179:8000/bulletin-board/post/$userId', data: [
      {
        'id': userId,
        'like_check': like,
        'participantion_status': participantionStatus
      }
    ]);
    return response.data["data"][0];
  } catch (error) {
    logger.d('오류: $error');
  }
}
