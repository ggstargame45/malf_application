// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_data_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$JsonDataState {
  bool get isLoading => throw _privateConstructorUsedError;
  JsonData get jsonData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $JsonDataStateCopyWith<JsonDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonDataStateCopyWith<$Res> {
  factory $JsonDataStateCopyWith(
          JsonDataState value, $Res Function(JsonDataState) then) =
      _$JsonDataStateCopyWithImpl<$Res, JsonDataState>;
  @useResult
  $Res call({bool isLoading, JsonData jsonData});
}

/// @nodoc
class _$JsonDataStateCopyWithImpl<$Res, $Val extends JsonDataState>
    implements $JsonDataStateCopyWith<$Res> {
  _$JsonDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? jsonData = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      jsonData: null == jsonData
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as JsonData,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JsonDataStateCopyWith<$Res>
    implements $JsonDataStateCopyWith<$Res> {
  factory _$$_JsonDataStateCopyWith(
          _$_JsonDataState value, $Res Function(_$_JsonDataState) then) =
      __$$_JsonDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, JsonData jsonData});
}

/// @nodoc
class __$$_JsonDataStateCopyWithImpl<$Res>
    extends _$JsonDataStateCopyWithImpl<$Res, _$_JsonDataState>
    implements _$$_JsonDataStateCopyWith<$Res> {
  __$$_JsonDataStateCopyWithImpl(
      _$_JsonDataState _value, $Res Function(_$_JsonDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? jsonData = null,
  }) {
    return _then(_$_JsonDataState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      jsonData: null == jsonData
          ? _value.jsonData
          : jsonData // ignore: cast_nullable_to_non_nullable
              as JsonData,
    ));
  }
}

/// @nodoc

class _$_JsonDataState extends _JsonDataState {
  const _$_JsonDataState({this.isLoading = true, required this.jsonData})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final JsonData jsonData;

  @override
  String toString() {
    return 'JsonDataState(isLoading: $isLoading, jsonData: $jsonData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JsonDataState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.jsonData, jsonData) ||
                other.jsonData == jsonData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, jsonData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JsonDataStateCopyWith<_$_JsonDataState> get copyWith =>
      __$$_JsonDataStateCopyWithImpl<_$_JsonDataState>(this, _$identity);
}

abstract class _JsonDataState extends JsonDataState {
  const factory _JsonDataState(
      {final bool isLoading,
      required final JsonData jsonData}) = _$_JsonDataState;
  const _JsonDataState._() : super._();

  @override
  bool get isLoading;
  @override
  JsonData get jsonData;
  @override
  @JsonKey(ignore: true)
  _$$_JsonDataStateCopyWith<_$_JsonDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
