// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_post_likes_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPostLikesModelResponse _$GetPostLikesModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPostLikesModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPostLikesModelResponse {
  MembersDataModelResponse? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPostLikesModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPostLikesModelResponseCopyWith<GetPostLikesModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostLikesModelResponseCopyWith<$Res> {
  factory $GetPostLikesModelResponseCopyWith(GetPostLikesModelResponse value,
          $Res Function(GetPostLikesModelResponse) then) =
      _$GetPostLikesModelResponseCopyWithImpl<$Res, GetPostLikesModelResponse>;
  @useResult
  $Res call({MembersDataModelResponse? data});

  $MembersDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetPostLikesModelResponseCopyWithImpl<$Res,
        $Val extends GetPostLikesModelResponse>
    implements $GetPostLikesModelResponseCopyWith<$Res> {
  _$GetPostLikesModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MembersDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MembersDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $MembersDataModelResponseCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPostLikesModelResponseImplCopyWith<$Res>
    implements $GetPostLikesModelResponseCopyWith<$Res> {
  factory _$$GetPostLikesModelResponseImplCopyWith(
          _$GetPostLikesModelResponseImpl value,
          $Res Function(_$GetPostLikesModelResponseImpl) then) =
      __$$GetPostLikesModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MembersDataModelResponse? data});

  @override
  $MembersDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetPostLikesModelResponseImplCopyWithImpl<$Res>
    extends _$GetPostLikesModelResponseCopyWithImpl<$Res,
        _$GetPostLikesModelResponseImpl>
    implements _$$GetPostLikesModelResponseImplCopyWith<$Res> {
  __$$GetPostLikesModelResponseImplCopyWithImpl(
      _$GetPostLikesModelResponseImpl _value,
      $Res Function(_$GetPostLikesModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetPostLikesModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as MembersDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPostLikesModelResponseImpl implements _GetPostLikesModelResponse {
  const _$GetPostLikesModelResponseImpl({this.data});

  factory _$GetPostLikesModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPostLikesModelResponseImplFromJson(json);

  @override
  final MembersDataModelResponse? data;

  @override
  String toString() {
    return 'GetPostLikesModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostLikesModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostLikesModelResponseImplCopyWith<_$GetPostLikesModelResponseImpl>
      get copyWith => __$$GetPostLikesModelResponseImplCopyWithImpl<
          _$GetPostLikesModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostLikesModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPostLikesModelResponse implements GetPostLikesModelResponse {
  const factory _GetPostLikesModelResponse(
      {final MembersDataModelResponse? data}) = _$GetPostLikesModelResponseImpl;

  factory _GetPostLikesModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPostLikesModelResponseImpl.fromJson;

  @override
  MembersDataModelResponse? get data;

  /// Create a copy of GetPostLikesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPostLikesModelResponseImplCopyWith<_$GetPostLikesModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
