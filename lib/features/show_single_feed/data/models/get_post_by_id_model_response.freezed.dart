// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_post_by_id_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPostByIdModelResponse _$GetPostByIdModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPostByIdModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPostByIdModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  PostCommunityModel? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPostByIdModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPostByIdModelResponseCopyWith<GetPostByIdModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostByIdModelResponseCopyWith<$Res> {
  factory $GetPostByIdModelResponseCopyWith(GetPostByIdModelResponse value,
          $Res Function(GetPostByIdModelResponse) then) =
      _$GetPostByIdModelResponseCopyWithImpl<$Res, GetPostByIdModelResponse>;
  @useResult
  $Res call({bool? value, PostCommunityModel? data});

  $PostCommunityModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetPostByIdModelResponseCopyWithImpl<$Res,
        $Val extends GetPostByIdModelResponse>
    implements $GetPostByIdModelResponseCopyWith<$Res> {
  _$GetPostByIdModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostCommunityModel?,
    ) as $Val);
  }

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCommunityModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PostCommunityModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPostByIdModelResponseImplCopyWith<$Res>
    implements $GetPostByIdModelResponseCopyWith<$Res> {
  factory _$$GetPostByIdModelResponseImplCopyWith(
          _$GetPostByIdModelResponseImpl value,
          $Res Function(_$GetPostByIdModelResponseImpl) then) =
      __$$GetPostByIdModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, PostCommunityModel? data});

  @override
  $PostCommunityModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetPostByIdModelResponseImplCopyWithImpl<$Res>
    extends _$GetPostByIdModelResponseCopyWithImpl<$Res,
        _$GetPostByIdModelResponseImpl>
    implements _$$GetPostByIdModelResponseImplCopyWith<$Res> {
  __$$GetPostByIdModelResponseImplCopyWithImpl(
      _$GetPostByIdModelResponseImpl _value,
      $Res Function(_$GetPostByIdModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPostByIdModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostCommunityModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPostByIdModelResponseImpl implements _GetPostByIdModelResponse {
  const _$GetPostByIdModelResponseImpl({this.value, this.data});

  factory _$GetPostByIdModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPostByIdModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final PostCommunityModel? data;

  @override
  String toString() {
    return 'GetPostByIdModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostByIdModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, data);

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostByIdModelResponseImplCopyWith<_$GetPostByIdModelResponseImpl>
      get copyWith => __$$GetPostByIdModelResponseImplCopyWithImpl<
          _$GetPostByIdModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostByIdModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPostByIdModelResponse implements GetPostByIdModelResponse {
  const factory _GetPostByIdModelResponse(
      {final bool? value,
      final PostCommunityModel? data}) = _$GetPostByIdModelResponseImpl;

  factory _GetPostByIdModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPostByIdModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  PostCommunityModel? get data;

  /// Create a copy of GetPostByIdModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPostByIdModelResponseImplCopyWith<_$GetPostByIdModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
