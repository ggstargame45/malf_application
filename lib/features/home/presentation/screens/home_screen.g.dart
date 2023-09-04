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
      capacityLocal: json['capacity_local'] as int,
      capacityTravel: json['capacity_travel'] as int,
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
      'capacity_local': instance.capacityLocal,
      'capacity_travel': instance.capacityTravel,
      'meeting_pic': const PicListConverter().toJson(instance.meetingPic),
      'meeting_location': instance.meetingLocation,
      'meeting_start_time':
          const DateTimeConverter().toJson(instance.meetingStartTime),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchDataHash() => r'c3a24673d835b7278a361998708601ec741e1b18';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef FetchDataRef = AutoDisposeFutureProviderRef<List<ListItemData>>;

/// See also [fetchData].
@ProviderFor(fetchData)
const fetchDataProvider = FetchDataFamily();

/// See also [fetchData].
class FetchDataFamily extends Family<AsyncValue<List<ListItemData>>> {
  /// See also [fetchData].
  const FetchDataFamily();

  /// See also [fetchData].
  FetchDataProvider call(
    int a,
  ) {
    return FetchDataProvider(
      a,
    );
  }

  @override
  FetchDataProvider getProviderOverride(
    covariant FetchDataProvider provider,
  ) {
    return call(
      provider.a,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchDataProvider';
}

/// See also [fetchData].
class FetchDataProvider extends AutoDisposeFutureProvider<List<ListItemData>> {
  /// See also [fetchData].
  FetchDataProvider(
    this.a,
  ) : super.internal(
          (ref) => fetchData(
            ref,
            a,
          ),
          from: fetchDataProvider,
          name: r'fetchDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchDataHash,
          dependencies: FetchDataFamily._dependencies,
          allTransitiveDependencies: FetchDataFamily._allTransitiveDependencies,
        );

  final int a;

  @override
  bool operator ==(Object other) {
    return other is FetchDataProvider && other.a == a;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, a.hashCode);

    return _SystemHash.finish(hash);
  }
}

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
String _$isEndOfListHash() => r'44641c2f94399b64ee9cec29686d8c0ed1c182a5';

/// See also [IsEndOfList].
@ProviderFor(IsEndOfList)
final isEndOfListProvider =
    AutoDisposeNotifierProvider<IsEndOfList, bool>.internal(
  IsEndOfList.new,
  name: r'isEndOfListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isEndOfListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsEndOfList = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
