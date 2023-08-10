// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ListItemData _$$_ListItemDataFromJson(Map<String, dynamic> json) =>
    _$_ListItemData(
      post_id: json['post_id'] as int,
      title: json['title'] as String,
      author_nickname: json['author_nickname'] as String,
      author_nation: json['author_nation'] as int,
      user_type: json['user_type'] as int,
      meeting_capacity: json['meeting_capacity'] as int,
      meeting_pic: json['meeting_pic'] as String,
      meeting_location: json['meeting_location'] as String,
      meeting_start_time: json['meeting_start_time'] as String,
    );

Map<String, dynamic> _$$_ListItemDataToJson(_$_ListItemData instance) =>
    <String, dynamic>{
      'post_id': instance.post_id,
      'title': instance.title,
      'author_nickname': instance.author_nickname,
      'author_nation': instance.author_nation,
      'user_type': instance.user_type,
      'meeting_capacity': instance.meeting_capacity,
      'meeting_pic': instance.meeting_pic,
      'meeting_location': instance.meeting_location,
      'meeting_start_time': instance.meeting_start_time,
    };
