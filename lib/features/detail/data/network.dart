import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final dio = Dio();
var logger = Logger();

class Network {
  String userId;
  String baseUrl;

  Network({required this.baseUrl, required this.userId});

  Future<void> request() async {
    try {
      final response = await dio.get("$baseUrl/$userId");
      return response.data;
    } catch (error) {
      logger.d('오류: $error');
    }
  }

  Future<void> post(int like, int participantionStatus) async {
    try {
      final response = await dio.post("$baseUrl/$userId", data: [
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
}
