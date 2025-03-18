// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_doctor_posts_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAllDoctorPostsModelResponse _$GetAllDoctorPostsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllDoctorPostsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllDoctorPostsModelResponse {
  GetPostsCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetAllDoctorPostsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllDoctorPostsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllDoctorPostsModelResponseCopyWith<GetAllDoctorPostsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllDoctorPostsModelResponseCopyWith<$Res> {
  factory $GetAllDoctorPostsModelResponseCopyWith(
          GetAllDoctorPostsModelResponse value,
          $Res Function(GetAllDoctorPostsModelResponse) then) =
      _$GetAllDoctorPostsModelResponseCopyWithImpl<$Res,
          GetAllDoctorPostsModelResponse>;
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetAllDoctorPostsModelResponseCopyWithImpl<$Res,
        $Val extends GetAllDoctorPostsModelResponse>
    implements $GetAllDoctorPostsModelResponseCopyWith<$Res> {
  _$GetAllDoctorPostsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllDoctorPostsModelResponse
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
              as GetPostsCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetAllDoctorPostsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetPostsCommunityDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAllDoctorPostsModelResponseImplCopyWith<$Res>
    implements $GetAllDoctorPostsModelResponseCopyWith<$Res> {
  factory _$$GetAllDoctorPostsModelResponseImplCopyWith(
          _$GetAllDoctorPostsModelResponseImpl value,
          $Res Function(_$GetAllDoctorPostsModelResponseImpl) then) =
      __$$GetAllDoctorPostsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  @override
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetAllDoctorPostsModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllDoctorPostsModelResponseCopyWithImpl<$Res,
        _$GetAllDoctorPostsModelResponseImpl>
    implements _$$GetAllDoctorPostsModelResponseImplCopyWith<$Res> {
  __$$GetAllDoctorPostsModelResponseImplCopyWithImpl(
      _$GetAllDoctorPostsModelResponseImpl _value,
      $Res Function(_$GetAllDoctorPostsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllDoctorPostsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetAllDoctorPostsModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllDoctorPostsModelResponseImpl
    implements _GetAllDoctorPostsModelResponse {
  const _$GetAllDoctorPostsModelResponseImpl({this.data});

  factory _$GetAllDoctorPostsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllDoctorPostsModelResponseImplFromJson(json);

  @override
  final GetPostsCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetAllDoctorPostsModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllDoctorPostsModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetAllDoctorPostsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllDoctorPostsModelResponseImplCopyWith<
          _$GetAllDoctorPostsModelResponseImpl>
      get copyWith => __$$GetAllDoctorPostsModelResponseImplCopyWithImpl<
          _$GetAllDoctorPostsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllDoctorPostsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllDoctorPostsModelResponse
    implements GetAllDoctorPostsModelResponse {
  const factory _GetAllDoctorPostsModelResponse(
          {final GetPostsCommunityDataModelResponse? data}) =
      _$GetAllDoctorPostsModelResponseImpl;

  factory _GetAllDoctorPostsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetAllDoctorPostsModelResponseImpl.fromJson;

  @override
  GetPostsCommunityDataModelResponse? get data;

  /// Create a copy of GetAllDoctorPostsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllDoctorPostsModelResponseImplCopyWith<
          _$GetAllDoctorPostsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
