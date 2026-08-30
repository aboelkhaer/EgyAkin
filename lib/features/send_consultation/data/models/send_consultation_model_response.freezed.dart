// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_consultation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SendConsultationModelResponse {
  String? get message => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_id')
  int? get consultationId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Create a copy of SendConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendConsultationModelResponseCopyWith<SendConsultationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendConsultationModelResponseCopyWith<$Res> {
  factory $SendConsultationModelResponseCopyWith(
          SendConsultationModelResponse value,
          $Res Function(SendConsultationModelResponse) then) =
      _$SendConsultationModelResponseCopyWithImpl<$Res,
          SendConsultationModelResponse>;
  @useResult
  $Res call(
      {String? message,
      int? id,
      @JsonKey(name: 'consultation_id') int? consultationId,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$SendConsultationModelResponseCopyWithImpl<$Res,
        $Val extends SendConsultationModelResponse>
    implements $SendConsultationModelResponseCopyWith<$Res> {
  _$SendConsultationModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? id = freezed,
    Object? consultationId = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendConsultationModelResponseImplCopyWith<$Res>
    implements $SendConsultationModelResponseCopyWith<$Res> {
  factory _$$SendConsultationModelResponseImplCopyWith(
          _$SendConsultationModelResponseImpl value,
          $Res Function(_$SendConsultationModelResponseImpl) then) =
      __$$SendConsultationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      int? id,
      @JsonKey(name: 'consultation_id') int? consultationId,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$SendConsultationModelResponseImplCopyWithImpl<$Res>
    extends _$SendConsultationModelResponseCopyWithImpl<$Res,
        _$SendConsultationModelResponseImpl>
    implements _$$SendConsultationModelResponseImplCopyWith<$Res> {
  __$$SendConsultationModelResponseImplCopyWithImpl(
      _$SendConsultationModelResponseImpl _value,
      $Res Function(_$SendConsultationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? id = freezed,
    Object? consultationId = freezed,
    Object? data = freezed,
  }) {
    return _then(_$SendConsultationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$SendConsultationModelResponseImpl
    extends _SendConsultationModelResponse {
  const _$SendConsultationModelResponseImpl(
      {this.message,
      this.id,
      @JsonKey(name: 'consultation_id') this.consultationId,
      final Map<String, dynamic>? data})
      : _data = data,
        super._();

  @override
  final String? message;
  @override
  final int? id;
  @override
  @JsonKey(name: 'consultation_id')
  final int? consultationId;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SendConsultationModelResponse(message: $message, id: $id, consultationId: $consultationId, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendConsultationModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.consultationId, consultationId) ||
                other.consultationId == consultationId) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, id, consultationId,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of SendConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendConsultationModelResponseImplCopyWith<
          _$SendConsultationModelResponseImpl>
      get copyWith => __$$SendConsultationModelResponseImplCopyWithImpl<
          _$SendConsultationModelResponseImpl>(this, _$identity);
}

abstract class _SendConsultationModelResponse
    extends SendConsultationModelResponse {
  const factory _SendConsultationModelResponse(
      {final String? message,
      final int? id,
      @JsonKey(name: 'consultation_id') final int? consultationId,
      final Map<String, dynamic>? data}) = _$SendConsultationModelResponseImpl;
  const _SendConsultationModelResponse._() : super._();

  @override
  String? get message;
  @override
  int? get id;
  @override
  @JsonKey(name: 'consultation_id')
  int? get consultationId;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of SendConsultationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendConsultationModelResponseImplCopyWith<
          _$SendConsultationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
