// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_option_in_poll_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddOptionInPollModelResponse _$AddOptionInPollModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddOptionInPollModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddOptionInPollModelResponse {
  AddOptionInPollDataModelResponse? get data =>
      throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this AddOptionInPollModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddOptionInPollModelResponseCopyWith<AddOptionInPollModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddOptionInPollModelResponseCopyWith<$Res> {
  factory $AddOptionInPollModelResponseCopyWith(
          AddOptionInPollModelResponse value,
          $Res Function(AddOptionInPollModelResponse) then) =
      _$AddOptionInPollModelResponseCopyWithImpl<$Res,
          AddOptionInPollModelResponse>;
  @useResult
  $Res call({AddOptionInPollDataModelResponse? data, String? message});

  $AddOptionInPollDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$AddOptionInPollModelResponseCopyWithImpl<$Res,
        $Val extends AddOptionInPollModelResponse>
    implements $AddOptionInPollModelResponseCopyWith<$Res> {
  _$AddOptionInPollModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AddOptionInPollDataModelResponse?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddOptionInPollDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AddOptionInPollDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddOptionInPollModelResponseImplCopyWith<$Res>
    implements $AddOptionInPollModelResponseCopyWith<$Res> {
  factory _$$AddOptionInPollModelResponseImplCopyWith(
          _$AddOptionInPollModelResponseImpl value,
          $Res Function(_$AddOptionInPollModelResponseImpl) then) =
      __$$AddOptionInPollModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddOptionInPollDataModelResponse? data, String? message});

  @override
  $AddOptionInPollDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AddOptionInPollModelResponseImplCopyWithImpl<$Res>
    extends _$AddOptionInPollModelResponseCopyWithImpl<$Res,
        _$AddOptionInPollModelResponseImpl>
    implements _$$AddOptionInPollModelResponseImplCopyWith<$Res> {
  __$$AddOptionInPollModelResponseImplCopyWithImpl(
      _$AddOptionInPollModelResponseImpl _value,
      $Res Function(_$AddOptionInPollModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$AddOptionInPollModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AddOptionInPollDataModelResponse?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddOptionInPollModelResponseImpl
    implements _AddOptionInPollModelResponse {
  const _$AddOptionInPollModelResponseImpl({this.data, this.message});

  factory _$AddOptionInPollModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddOptionInPollModelResponseImplFromJson(json);

  @override
  final AddOptionInPollDataModelResponse? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'AddOptionInPollModelResponse(data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOptionInPollModelResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOptionInPollModelResponseImplCopyWith<
          _$AddOptionInPollModelResponseImpl>
      get copyWith => __$$AddOptionInPollModelResponseImplCopyWithImpl<
          _$AddOptionInPollModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddOptionInPollModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddOptionInPollModelResponse
    implements AddOptionInPollModelResponse {
  const factory _AddOptionInPollModelResponse(
      {final AddOptionInPollDataModelResponse? data,
      final String? message}) = _$AddOptionInPollModelResponseImpl;

  factory _AddOptionInPollModelResponse.fromJson(Map<String, dynamic> json) =
      _$AddOptionInPollModelResponseImpl.fromJson;

  @override
  AddOptionInPollDataModelResponse? get data;
  @override
  String? get message;

  /// Create a copy of AddOptionInPollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOptionInPollModelResponseImplCopyWith<
          _$AddOptionInPollModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AddOptionInPollDataModelResponse _$AddOptionInPollDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _AddOptionInPollDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AddOptionInPollDataModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'poll_id')
  String? get pollId => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_text')
  String? get option => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AddOptionInPollDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddOptionInPollDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddOptionInPollDataModelResponseCopyWith<AddOptionInPollDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddOptionInPollDataModelResponseCopyWith<$Res> {
  factory $AddOptionInPollDataModelResponseCopyWith(
          AddOptionInPollDataModelResponse value,
          $Res Function(AddOptionInPollDataModelResponse) then) =
      _$AddOptionInPollDataModelResponseCopyWithImpl<$Res,
          AddOptionInPollDataModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'poll_id') String? pollId,
      @JsonKey(name: 'option_text') String? option,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$AddOptionInPollDataModelResponseCopyWithImpl<$Res,
        $Val extends AddOptionInPollDataModelResponse>
    implements $AddOptionInPollDataModelResponseCopyWith<$Res> {
  _$AddOptionInPollDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddOptionInPollDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pollId = freezed,
    Object? option = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as String?,
      option: freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddOptionInPollDataModelResponseImplCopyWith<$Res>
    implements $AddOptionInPollDataModelResponseCopyWith<$Res> {
  factory _$$AddOptionInPollDataModelResponseImplCopyWith(
          _$AddOptionInPollDataModelResponseImpl value,
          $Res Function(_$AddOptionInPollDataModelResponseImpl) then) =
      __$$AddOptionInPollDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'poll_id') String? pollId,
      @JsonKey(name: 'option_text') String? option,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$AddOptionInPollDataModelResponseImplCopyWithImpl<$Res>
    extends _$AddOptionInPollDataModelResponseCopyWithImpl<$Res,
        _$AddOptionInPollDataModelResponseImpl>
    implements _$$AddOptionInPollDataModelResponseImplCopyWith<$Res> {
  __$$AddOptionInPollDataModelResponseImplCopyWithImpl(
      _$AddOptionInPollDataModelResponseImpl _value,
      $Res Function(_$AddOptionInPollDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddOptionInPollDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pollId = freezed,
    Object? option = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AddOptionInPollDataModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as String?,
      option: freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddOptionInPollDataModelResponseImpl
    implements _AddOptionInPollDataModelResponse {
  const _$AddOptionInPollDataModelResponseImpl(
      {this.id,
      @JsonKey(name: 'poll_id') this.pollId,
      @JsonKey(name: 'option_text') this.option,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$AddOptionInPollDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AddOptionInPollDataModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'poll_id')
  final String? pollId;
  @override
  @JsonKey(name: 'option_text')
  final String? option;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'AddOptionInPollDataModelResponse(id: $id, pollId: $pollId, option: $option, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddOptionInPollDataModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.option, option) || other.option == option) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, pollId, option, createdAt, updatedAt);

  /// Create a copy of AddOptionInPollDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddOptionInPollDataModelResponseImplCopyWith<
          _$AddOptionInPollDataModelResponseImpl>
      get copyWith => __$$AddOptionInPollDataModelResponseImplCopyWithImpl<
          _$AddOptionInPollDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddOptionInPollDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AddOptionInPollDataModelResponse
    implements AddOptionInPollDataModelResponse {
  const factory _AddOptionInPollDataModelResponse(
          {final int? id,
          @JsonKey(name: 'poll_id') final String? pollId,
          @JsonKey(name: 'option_text') final String? option,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt}) =
      _$AddOptionInPollDataModelResponseImpl;

  factory _AddOptionInPollDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AddOptionInPollDataModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'poll_id')
  String? get pollId;
  @override
  @JsonKey(name: 'option_text')
  String? get option;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of AddOptionInPollDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddOptionInPollDataModelResponseImplCopyWith<
          _$AddOptionInPollDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
