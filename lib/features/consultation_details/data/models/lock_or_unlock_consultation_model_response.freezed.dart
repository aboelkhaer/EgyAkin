// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lock_or_unlock_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LockOrUnlockConsultationModelResponse
    _$LockOrUnlockConsultationModelResponseFromJson(Map<String, dynamic> json) {
  return _LockOrUnlockConsultationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$LockOrUnlockConsultationModelResponse {
  String? get message => throw _privateConstructorUsedError;
  LockOrUnlockConsultationModelResponseData? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this LockOrUnlockConsultationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LockOrUnlockConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LockOrUnlockConsultationModelResponseCopyWith<
          LockOrUnlockConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LockOrUnlockConsultationModelResponseCopyWith<$Res> {
  factory $LockOrUnlockConsultationModelResponseCopyWith(
          LockOrUnlockConsultationModelResponse value,
          $Res Function(LockOrUnlockConsultationModelResponse) then) =
      _$LockOrUnlockConsultationModelResponseCopyWithImpl<$Res,
          LockOrUnlockConsultationModelResponse>;
  @useResult
  $Res call({String? message, LockOrUnlockConsultationModelResponseData? data});

  $LockOrUnlockConsultationModelResponseDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$LockOrUnlockConsultationModelResponseCopyWithImpl<$Res,
        $Val extends LockOrUnlockConsultationModelResponse>
    implements $LockOrUnlockConsultationModelResponseCopyWith<$Res> {
  _$LockOrUnlockConsultationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LockOrUnlockConsultationModelResponse
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
              as LockOrUnlockConsultationModelResponseData?,
    ) as $Val);
  }

  /// Create a copy of LockOrUnlockConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LockOrUnlockConsultationModelResponseDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $LockOrUnlockConsultationModelResponseDataCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LockOrUnlockConsultationModelResponseImplCopyWith<$Res>
    implements $LockOrUnlockConsultationModelResponseCopyWith<$Res> {
  factory _$$LockOrUnlockConsultationModelResponseImplCopyWith(
          _$LockOrUnlockConsultationModelResponseImpl value,
          $Res Function(_$LockOrUnlockConsultationModelResponseImpl) then) =
      __$$LockOrUnlockConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, LockOrUnlockConsultationModelResponseData? data});

  @override
  $LockOrUnlockConsultationModelResponseDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$LockOrUnlockConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$LockOrUnlockConsultationModelResponseCopyWithImpl<$Res,
        _$LockOrUnlockConsultationModelResponseImpl>
    implements _$$LockOrUnlockConsultationModelResponseImplCopyWith<$Res> {
  __$$LockOrUnlockConsultationModelResponseImplCopyWithImpl(
      _$LockOrUnlockConsultationModelResponseImpl _value,
      $Res Function(_$LockOrUnlockConsultationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LockOrUnlockConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$LockOrUnlockConsultationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LockOrUnlockConsultationModelResponseData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LockOrUnlockConsultationModelResponseImpl
    implements _LockOrUnlockConsultationModelResponse {
  const _$LockOrUnlockConsultationModelResponseImpl({this.message, this.data});

  factory _$LockOrUnlockConsultationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LockOrUnlockConsultationModelResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final LockOrUnlockConsultationModelResponseData? data;

  @override
  String toString() {
    return 'LockOrUnlockConsultationModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LockOrUnlockConsultationModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  /// Create a copy of LockOrUnlockConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LockOrUnlockConsultationModelResponseImplCopyWith<
          _$LockOrUnlockConsultationModelResponseImpl>
      get copyWith => __$$LockOrUnlockConsultationModelResponseImplCopyWithImpl<
          _$LockOrUnlockConsultationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LockOrUnlockConsultationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _LockOrUnlockConsultationModelResponse
    implements LockOrUnlockConsultationModelResponse {
  const factory _LockOrUnlockConsultationModelResponse(
          {final String? message,
          final LockOrUnlockConsultationModelResponseData? data}) =
      _$LockOrUnlockConsultationModelResponseImpl;

  factory _LockOrUnlockConsultationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$LockOrUnlockConsultationModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  LockOrUnlockConsultationModelResponseData? get data;

  /// Create a copy of LockOrUnlockConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LockOrUnlockConsultationModelResponseImplCopyWith<
          _$LockOrUnlockConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LockOrUnlockConsultationModelResponseData
    _$LockOrUnlockConsultationModelResponseDataFromJson(
        Map<String, dynamic> json) {
  return _LockOrUnlockConsultationModelResponseData.fromJson(json);
}

/// @nodoc
mixin _$LockOrUnlockConsultationModelResponseData {
  @JsonKey(name: 'consultation_id')
  int? get consultationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool? get isOpen => throw _privateConstructorUsedError;

  /// Serializes this LockOrUnlockConsultationModelResponseData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LockOrUnlockConsultationModelResponseData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LockOrUnlockConsultationModelResponseDataCopyWith<
          LockOrUnlockConsultationModelResponseData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LockOrUnlockConsultationModelResponseDataCopyWith<$Res> {
  factory $LockOrUnlockConsultationModelResponseDataCopyWith(
          LockOrUnlockConsultationModelResponseData value,
          $Res Function(LockOrUnlockConsultationModelResponseData) then) =
      _$LockOrUnlockConsultationModelResponseDataCopyWithImpl<$Res,
          LockOrUnlockConsultationModelResponseData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'consultation_id') int? consultationId,
      @JsonKey(name: 'is_open') bool? isOpen});
}

/// @nodoc
class _$LockOrUnlockConsultationModelResponseDataCopyWithImpl<$Res,
        $Val extends LockOrUnlockConsultationModelResponseData>
    implements $LockOrUnlockConsultationModelResponseDataCopyWith<$Res> {
  _$LockOrUnlockConsultationModelResponseDataCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LockOrUnlockConsultationModelResponseData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultationId = freezed,
    Object? isOpen = freezed,
  }) {
    return _then(_value.copyWith(
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LockOrUnlockConsultationModelResponseDataImplCopyWith<$Res>
    implements $LockOrUnlockConsultationModelResponseDataCopyWith<$Res> {
  factory _$$LockOrUnlockConsultationModelResponseDataImplCopyWith(
          _$LockOrUnlockConsultationModelResponseDataImpl value,
          $Res Function(_$LockOrUnlockConsultationModelResponseDataImpl) then) =
      __$$LockOrUnlockConsultationModelResponseDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'consultation_id') int? consultationId,
      @JsonKey(name: 'is_open') bool? isOpen});
}

/// @nodoc
class __$$LockOrUnlockConsultationModelResponseDataImplCopyWithImpl<$Res>
    extends _$LockOrUnlockConsultationModelResponseDataCopyWithImpl<$Res,
        _$LockOrUnlockConsultationModelResponseDataImpl>
    implements _$$LockOrUnlockConsultationModelResponseDataImplCopyWith<$Res> {
  __$$LockOrUnlockConsultationModelResponseDataImplCopyWithImpl(
      _$LockOrUnlockConsultationModelResponseDataImpl _value,
      $Res Function(_$LockOrUnlockConsultationModelResponseDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LockOrUnlockConsultationModelResponseData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consultationId = freezed,
    Object? isOpen = freezed,
  }) {
    return _then(_$LockOrUnlockConsultationModelResponseDataImpl(
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LockOrUnlockConsultationModelResponseDataImpl
    implements _LockOrUnlockConsultationModelResponseData {
  const _$LockOrUnlockConsultationModelResponseDataImpl(
      {@JsonKey(name: 'consultation_id') this.consultationId,
      @JsonKey(name: 'is_open') this.isOpen});

  factory _$LockOrUnlockConsultationModelResponseDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LockOrUnlockConsultationModelResponseDataImplFromJson(json);

  @override
  @JsonKey(name: 'consultation_id')
  final int? consultationId;
  @override
  @JsonKey(name: 'is_open')
  final bool? isOpen;

  @override
  String toString() {
    return 'LockOrUnlockConsultationModelResponseData(consultationId: $consultationId, isOpen: $isOpen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LockOrUnlockConsultationModelResponseDataImpl &&
            (identical(other.consultationId, consultationId) ||
                other.consultationId == consultationId) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, consultationId, isOpen);

  /// Create a copy of LockOrUnlockConsultationModelResponseData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LockOrUnlockConsultationModelResponseDataImplCopyWith<
          _$LockOrUnlockConsultationModelResponseDataImpl>
      get copyWith =>
          __$$LockOrUnlockConsultationModelResponseDataImplCopyWithImpl<
                  _$LockOrUnlockConsultationModelResponseDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LockOrUnlockConsultationModelResponseDataImplToJson(
      this,
    );
  }
}

abstract class _LockOrUnlockConsultationModelResponseData
    implements LockOrUnlockConsultationModelResponseData {
  const factory _LockOrUnlockConsultationModelResponseData(
          {@JsonKey(name: 'consultation_id') final int? consultationId,
          @JsonKey(name: 'is_open') final bool? isOpen}) =
      _$LockOrUnlockConsultationModelResponseDataImpl;

  factory _LockOrUnlockConsultationModelResponseData.fromJson(
          Map<String, dynamic> json) =
      _$LockOrUnlockConsultationModelResponseDataImpl.fromJson;

  @override
  @JsonKey(name: 'consultation_id')
  int? get consultationId;
  @override
  @JsonKey(name: 'is_open')
  bool? get isOpen;

  /// Create a copy of LockOrUnlockConsultationModelResponseData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LockOrUnlockConsultationModelResponseDataImplCopyWith<
          _$LockOrUnlockConsultationModelResponseDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
