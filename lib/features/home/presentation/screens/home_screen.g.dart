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

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchDataHash() => r'f380af3aa5279f26722f1f9bd09ec88b77e581c9';

/// See also [fetchData].
@ProviderFor(fetchData)
final fetchDataProvider =
    AutoDisposeFutureProvider<List<ListItemData>>.internal(
  fetchData,
  name: r'fetchDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchDataRef = AutoDisposeFutureProviderRef<List<ListItemData>>;
String _$pageNumberNotifierHash() =>
    r'0f0330b6300ed93886a219f8085d3ee989cef57a';

/// See also [PageNumberNotifier].
@ProviderFor(PageNumberNotifier)
final pageNumberNotifierProvider =
    AutoDisposeNotifierProvider<PageNumberNotifier, int>.internal(
  PageNumberNotifier.new,
  name: r'pageNumberNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pageNumberNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PageNumberNotifier = AutoDisposeNotifier<int>;
String _$dataListNotifierHash() => r'3f026e00c77c6189a2477606dee8d7f702704593';

/// See also [DataListNotifier].
@ProviderFor(DataListNotifier)
final dataListNotifierProvider =
    AutoDisposeNotifierProvider<DataListNotifier, List<ListItemData>>.internal(
  DataListNotifier.new,
  name: r'dataListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dataListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DataListNotifier = AutoDisposeNotifier<List<ListItemData>>;
String _$isEndOfListHash() => r'cce80a8719454a01b4ea82df68229dc34d7e98ee';

/// See also [isEndOfList].
@ProviderFor(isEndOfList)
final isEndOfListProvider =
    AutoDisposeNotifierProvider<isEndOfList, bool>.internal(
  isEndOfList.new,
  name: r'isEndOfListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isEndOfListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$isEndOfList = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
