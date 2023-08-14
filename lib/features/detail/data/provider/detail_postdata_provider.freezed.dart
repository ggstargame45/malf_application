// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_postdata_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostData _$PostDataFromJson(Map<String, dynamic> json) {
  return _PostData.fromJson(json);
}

/// @nodoc
mixin _$PostData {
  int get isLikeCheck => throw _privateConstructorUsedError;
  set isLikeCheck(int value) => throw _privateConstructorUsedError;
  int get isLikeCount => throw _privateConstructorUsedError;
  set isLikeCount(int value) => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostDataCopyWith<PostData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDataCopyWith<$Res> {
  factory $PostDataCopyWith(PostData value, $Res Function(PostData) then) =
      _$PostDataCopyWithImpl<$Res, PostData>;
  @useResult
  $Res call({int isLikeCheck, int isLikeCount, String userName});
}

/// @nodoc
class _$PostDataCopyWithImpl<$Res, $Val extends PostData>
    implements $PostDataCopyWith<$Res> {
  _$PostDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLikeCheck = null,
    Object? isLikeCount = null,
    Object? userName = null,
  }) {
    return _then(_value.copyWith(
      isLikeCheck: null == isLikeCheck
          ? _value.isLikeCheck
          : isLikeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      isLikeCount: null == isLikeCount
          ? _value.isLikeCount
          : isLikeCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostDataCopyWith<$Res> implements $PostDataCopyWith<$Res> {
  factory _$$_PostDataCopyWith(
          _$_PostData value, $Res Function(_$_PostData) then) =
      __$$_PostDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int isLikeCheck, int isLikeCount, String userName});
}

/// @nodoc
class __$$_PostDataCopyWithImpl<$Res>
    extends _$PostDataCopyWithImpl<$Res, _$_PostData>
    implements _$$_PostDataCopyWith<$Res> {
  __$$_PostDataCopyWithImpl(
      _$_PostData _value, $Res Function(_$_PostData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLikeCheck = null,
    Object? isLikeCount = null,
    Object? userName = null,
  }) {
    return _then(_$_PostData(
      isLikeCheck: null == isLikeCheck
          ? _value.isLikeCheck
          : isLikeCheck // ignore: cast_nullable_to_non_nullable
              as int,
      isLikeCount: null == isLikeCount
          ? _value.isLikeCount
          : isLikeCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostData implements _PostData {
  _$_PostData(
      {required this.isLikeCheck,
      required this.isLikeCount,
      required this.userName});

  factory _$_PostData.fromJson(Map<String, dynamic> json) =>
      _$$_PostDataFromJson(json);

  @override
  int isLikeCheck;
  @override
  int isLikeCount;
  @override
  final String userName;

  @override
  String toString() {
    return 'PostData(isLikeCheck: $isLikeCheck, isLikeCount: $isLikeCount, userName: $userName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostDataCopyWith<_$_PostData> get copyWith =>
      __$$_PostDataCopyWithImpl<_$_PostData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostDataToJson(
      this,
    );
  }
}

abstract class _PostData implements PostData {
  factory _PostData(
      {required int isLikeCheck,
      required int isLikeCount,
      required final String userName}) = _$_PostData;

  factory _PostData.fromJson(Map<String, dynamic> json) = _$_PostData.fromJson;

  @override
  int get isLikeCheck;
  set isLikeCheck(int value);
  @override
  int get isLikeCount;
  set isLikeCount(int value);
  @override
  String get userName;
  @override
  @JsonKey(ignore: true)
  _$$_PostDataCopyWith<_$_PostData> get copyWith =>
      throw _privateConstructorUsedError;
}
