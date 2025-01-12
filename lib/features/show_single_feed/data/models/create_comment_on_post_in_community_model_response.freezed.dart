// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_comment_on_post_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateCommentOnPostInCommunityModelResponse
    _$CreateCommentOnPostInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _CreateCommentOnPostInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateCommentOnPostInCommunityModelResponse {
  String? get message => throw _privateConstructorUsedError;
  CreateCommentOnPostInCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this CreateCommentOnPostInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCommentOnPostInCommunityModelResponseCopyWith<
          CreateCommentOnPostInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  factory $CreateCommentOnPostInCommunityModelResponseCopyWith(
          CreateCommentOnPostInCommunityModelResponse value,
          $Res Function(CreateCommentOnPostInCommunityModelResponse) then) =
      _$CreateCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
          CreateCommentOnPostInCommunityModelResponse>;
  @useResult
  $Res call(
      {String? message, CreateCommentOnPostInCommunityDataModelResponse? data});

  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$CreateCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends CreateCommentOnPostInCommunityModelResponse>
    implements $CreateCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  _$CreateCommentOnPostInCommunityModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CreateCommentOnPostInCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateCommentOnPostInCommunityModelResponseImplCopyWith<$Res>
    implements $CreateCommentOnPostInCommunityModelResponseCopyWith<$Res> {
  factory _$$CreateCommentOnPostInCommunityModelResponseImplCopyWith(
          _$CreateCommentOnPostInCommunityModelResponseImpl value,
          $Res Function(_$CreateCommentOnPostInCommunityModelResponseImpl)
              then) =
      __$$CreateCommentOnPostInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message, CreateCommentOnPostInCommunityDataModelResponse? data});

  @override
  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$CreateCommentOnPostInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$CreateCommentOnPostInCommunityModelResponseCopyWithImpl<$Res,
        _$CreateCommentOnPostInCommunityModelResponseImpl>
    implements
        _$$CreateCommentOnPostInCommunityModelResponseImplCopyWith<$Res> {
  __$$CreateCommentOnPostInCommunityModelResponseImplCopyWithImpl(
      _$CreateCommentOnPostInCommunityModelResponseImpl _value,
      $Res Function(_$CreateCommentOnPostInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CreateCommentOnPostInCommunityModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CreateCommentOnPostInCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCommentOnPostInCommunityModelResponseImpl
    implements _CreateCommentOnPostInCommunityModelResponse {
  const _$CreateCommentOnPostInCommunityModelResponseImpl(
      {this.message, this.data});

  factory _$CreateCommentOnPostInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateCommentOnPostInCommunityModelResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final CreateCommentOnPostInCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'CreateCommentOnPostInCommunityModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCommentOnPostInCommunityModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCommentOnPostInCommunityModelResponseImplCopyWith<
          _$CreateCommentOnPostInCommunityModelResponseImpl>
      get copyWith =>
          __$$CreateCommentOnPostInCommunityModelResponseImplCopyWithImpl<
                  _$CreateCommentOnPostInCommunityModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCommentOnPostInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateCommentOnPostInCommunityModelResponse
    implements CreateCommentOnPostInCommunityModelResponse {
  const factory _CreateCommentOnPostInCommunityModelResponse(
          {final String? message,
          final CreateCommentOnPostInCommunityDataModelResponse? data}) =
      _$CreateCommentOnPostInCommunityModelResponseImpl;

  factory _CreateCommentOnPostInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreateCommentOnPostInCommunityModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  CreateCommentOnPostInCommunityDataModelResponse? get data;

  /// Create a copy of CreateCommentOnPostInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCommentOnPostInCommunityModelResponseImplCopyWith<
          _$CreateCommentOnPostInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateCommentOnPostInCommunityDataModelResponse
    _$CreateCommentOnPostInCommunityDataModelResponseFromJson(
        Map<String, dynamic> json) {
  return _CreateCommentOnPostInCommunityDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateCommentOnPostInCommunityDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  int? get doctorId => throw _privateConstructorUsedError;

  /// Serializes this CreateCommentOnPostInCommunityDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateCommentOnPostInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateCommentOnPostInCommunityDataModelResponseCopyWith<
          CreateCommentOnPostInCommunityDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res> {
  factory $CreateCommentOnPostInCommunityDataModelResponseCopyWith(
          CreateCommentOnPostInCommunityDataModelResponse value,
          $Res Function(CreateCommentOnPostInCommunityDataModelResponse) then) =
      _$CreateCommentOnPostInCommunityDataModelResponseCopyWithImpl<$Res,
          CreateCommentOnPostInCommunityDataModelResponse>;
  @useResult
  $Res call(
      {int? id, String? comment, @JsonKey(name: 'doctor_id') int? doctorId});
}

/// @nodoc
class _$CreateCommentOnPostInCommunityDataModelResponseCopyWithImpl<$Res,
        $Val extends CreateCommentOnPostInCommunityDataModelResponse>
    implements $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res> {
  _$CreateCommentOnPostInCommunityDataModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateCommentOnPostInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comment = freezed,
    Object? doctorId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWith<
        $Res>
    implements $CreateCommentOnPostInCommunityDataModelResponseCopyWith<$Res> {
  factory _$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWith(
          _$CreateCommentOnPostInCommunityDataModelResponseImpl value,
          $Res Function(_$CreateCommentOnPostInCommunityDataModelResponseImpl)
              then) =
      __$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? comment, @JsonKey(name: 'doctor_id') int? doctorId});
}

/// @nodoc
class __$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWithImpl<$Res>
    extends _$CreateCommentOnPostInCommunityDataModelResponseCopyWithImpl<$Res,
        _$CreateCommentOnPostInCommunityDataModelResponseImpl>
    implements
        _$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWith<$Res> {
  __$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWithImpl(
      _$CreateCommentOnPostInCommunityDataModelResponseImpl _value,
      $Res Function(_$CreateCommentOnPostInCommunityDataModelResponseImpl)
          _then)
      : super(_value, _then);

  /// Create a copy of CreateCommentOnPostInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comment = freezed,
    Object? doctorId = freezed,
  }) {
    return _then(_$CreateCommentOnPostInCommunityDataModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateCommentOnPostInCommunityDataModelResponseImpl
    implements _CreateCommentOnPostInCommunityDataModelResponse {
  const _$CreateCommentOnPostInCommunityDataModelResponseImpl(
      {this.id, this.comment, @JsonKey(name: 'doctor_id') this.doctorId});

  factory _$CreateCommentOnPostInCommunityDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateCommentOnPostInCommunityDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? comment;
  @override
  @JsonKey(name: 'doctor_id')
  final int? doctorId;

  @override
  String toString() {
    return 'CreateCommentOnPostInCommunityDataModelResponse(id: $id, comment: $comment, doctorId: $doctorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCommentOnPostInCommunityDataModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, comment, doctorId);

  /// Create a copy of CreateCommentOnPostInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWith<
          _$CreateCommentOnPostInCommunityDataModelResponseImpl>
      get copyWith =>
          __$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWithImpl<
                  _$CreateCommentOnPostInCommunityDataModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateCommentOnPostInCommunityDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateCommentOnPostInCommunityDataModelResponse
    implements CreateCommentOnPostInCommunityDataModelResponse {
  const factory _CreateCommentOnPostInCommunityDataModelResponse(
          {final int? id,
          final String? comment,
          @JsonKey(name: 'doctor_id') final int? doctorId}) =
      _$CreateCommentOnPostInCommunityDataModelResponseImpl;

  factory _CreateCommentOnPostInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreateCommentOnPostInCommunityDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'doctor_id')
  int? get doctorId;

  /// Create a copy of CreateCommentOnPostInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCommentOnPostInCommunityDataModelResponseImplCopyWith<
          _$CreateCommentOnPostInCommunityDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
