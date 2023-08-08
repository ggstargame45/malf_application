// To parse this JSON data, do
//
//     final jsonData = jsonDataFromJson(jsonString);

import 'dart:convert';

JsonData jsonDataFromJson(String str) => JsonData.fromJson(json.decode(str));

String jsonDataToJson(JsonData data) => json.encode(data.toJson());

class JsonData {
  String status;
  List<Datum> data;

  JsonData({
    required this.status,
    required this.data,
  });

  factory JsonData.fromJson(Map<String, dynamic> json) => JsonData(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int postId;
  String title;
  String content;
  String authorNickname;
  int authorNation;
  String authorPicture;
  int userType;
  int meetingCapacity;
  String meetingPic;
  String meetingLocation;
  DateTime meetingStartTime;
  int likeCount;
  int likeCheck;
  int participantionStatus;

  Datum({
    required this.postId,
    required this.title,
    required this.content,
    required this.authorNickname,
    required this.authorNation,
    required this.authorPicture,
    required this.userType,
    required this.meetingCapacity,
    required this.meetingPic,
    required this.meetingLocation,
    required this.meetingStartTime,
    required this.likeCount,
    required this.likeCheck,
    required this.participantionStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        postId: json["post_id"],
        title: json["title"],
        content: json["content"],
        authorNickname: json["author_nickname"],
        authorNation: json["author_nation"],
        authorPicture: json["author_picture"],
        userType: json["user_type"],
        meetingCapacity: json["meeting_capacity"],
        meetingPic: json["meeting_pic"],
        meetingLocation: json["meeting_location"],
        meetingStartTime: DateTime.parse(json["meeting_start_time"]),
        likeCount: json["like_count"],
        likeCheck: json["like_check"],
        participantionStatus: json["participantion_status"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "title": title,
        "content": content,
        "author_nickname": authorNickname,
        "author_nation": authorNation,
        "author_picture": authorPicture,
        "user_type": userType,
        "meeting_capacity": meetingCapacity,
        "meeting_pic": meetingPic,
        "meeting_location": meetingLocation,
        "meeting_start_time": meetingStartTime.toIso8601String(),
        "like_count": likeCount,
        "like_check": likeCheck,
        "participantion_status": participantionStatus,
      };
}
