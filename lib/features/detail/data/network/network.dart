import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../constants/url_const.dart';

var logger = Logger();

class Network {
  final _dio = Dio(BaseOptions(
      baseUrl: Url.baseUrl,
      headers: {'Authorization': 'test_1'},
      responseType: ResponseType.json));

  int postId;
  static const String detailUrl = Url.detailUrl;
  Network({
    required this.postId,
  });

  Future<dynamic> request() async {
    try {
      final response = await _dio.get("$detailUrl$postId");
      Logger().d(response.data);
      return response.data;
    } catch (error) {
      logger.e('오류: $error,$detailUrl$postId');
    }
  }

  Future<dynamic> likePost(int userId, int like) async {
    try {
      final response = await _dio.post("$detailUrl$postId/like", data: {
        'id': userId,
        'like_check': like,
      });
      return response.statusCode;
    } catch (error) {
      logger.d('오류: $error');
    }
  }

  Future<dynamic> participationPost(
      int userId, int participantionStatus) async {
    try {
      final response = await _dio.post("$detailUrl$postId/like", data: {
        'id': userId,
        'participation_status': participantionStatus,
      });
      logger.d(response.data);
      return response.statusCode;
    } catch (error) {
      logger.d('오류: $error');
    }
  }

  Future<dynamic> delete() async {
    try {
      final response = await _dio.delete("$detailUrl$postId",
          options: Options(
            headers: {"user_id": 21},
          ),
          data: {
            'user_id': postId,
          });
      logger.d(response.data);
      return response.statusCode;
    } catch (error) {
      logger.d('오류: $error');
    }
  }
}
