// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ListItemData _$$_ListItemDataFromJson(Map<String, dynamic> json) =>
    _$_ListItemData(
      postId: json['post_id'] as int,
      title: json['title'] as String,
      authorNickname: json['author_nickname'] as String,
      authorNation: json['author_nation'] as int,
      userType: json['user_type'] as int,
      meetingCapacity: json['meeting_capacity'] as int,
      meetingPic:
          const PicListConverter().fromJson(json['meeting_pic'] as String),
      meetingLocation: json['meeting_location'] as String,
      meetingStartTime: const DateTimeConverter()
          .fromJson(json['meeting_start_time'] as String),
    );

Map<String, dynamic> _$$_ListItemDataToJson(_$_ListItemData instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'title': instance.title,
      'author_nickname': instance.authorNickname,
      'author_nation': instance.authorNation,
      'user_type': instance.userType,
      'meeting_capacity': instance.meetingCapacity,
      'meeting_pic': const PicListConverter().toJson(instance.meetingPic),
      'meeting_location': instance.meetingLocation,
      'meeting_start_time':
          const DateTimeConverter().toJson(instance.meetingStartTime),
    };
