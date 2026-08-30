// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_external_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InviteExternalModelResponse _$InviteExternalModelResponseFromJson(
    Map<String, dynamic> json) {
  return _InviteExternalModelResponse.fromJson(json);
}

/// @nodoc
mixin _$InviteExternalModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  InviteExternalData? get data => throw _privateConstructorUsedError;

  /// Serializes this InviteExternalModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InviteExternalModelResponseCopyWith<InviteExternalModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InviteExternalModelResponseCopyWith<$Res> {
  factory $InviteExternalModelResponseCopyWith(
          InviteExternalModelResponse value,
          $Res Function(InviteExternalModelResponse) then) =
      _$InviteExternalModelResponseCopyWithImpl<$Res,
          InviteExternalModelResponse>;
  @useResult
  $Res call({bool? value, String? message, InviteExternalData? data});

  $InviteExternalDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$InviteExternalModelResponseCopyWithImpl<$Res,
        $Val extends InviteExternalModelResponse>
    implements $InviteExternalModelResponseCopyWith<$Res> {
  _$InviteExternalModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as InviteExternalData?,
    ) as $Val);
  }

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InviteExternalDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $InviteExternalDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InviteExternalModelResponseImplCopyWith<$Res>
    implements $InviteExternalModelResponseCopyWith<$Res> {
  factory _$$InviteExternalModelResponseImplCopyWith(
          _$InviteExternalModelResponseImpl value,
          $Res Function(_$InviteExternalModelResponseImpl) then) =
      __$$InviteExternalModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, InviteExternalData? data});

  @override
  $InviteExternalDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$InviteExternalModelResponseImplCopyWithImpl<$Res>
    extends _$InviteExternalModelResponseCopyWithImpl<$Res,
        _$InviteExternalModelResponseImpl>
    implements _$$InviteExternalModelResponseImplCopyWith<$Res> {
  __$$InviteExternalModelResponseImplCopyWithImpl(
      _$InviteExternalModelResponseImpl _value,
      $Res Function(_$InviteExternalModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$InviteExternalModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as InviteExternalData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InviteExternalModelResponseImpl
    implements _InviteExternalModelResponse {
  const _$InviteExternalModelResponseImpl(
      {this.value, this.message, this.data});

  factory _$InviteExternalModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InviteExternalModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  final InviteExternalData? data;

  @override
  String toString() {
    return 'InviteExternalModelResponse(value: $value, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteExternalModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message, data);

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteExternalModelResponseImplCopyWith<_$InviteExternalModelResponseImpl>
      get copyWith => __$$InviteExternalModelResponseImplCopyWithImpl<
          _$InviteExternalModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InviteExternalModelResponseImplToJson(
      this,
    );
  }
}

abstract class _InviteExternalModelResponse
    implements InviteExternalModelResponse {
  const factory _InviteExternalModelResponse(
      {final bool? value,
      final String? message,
      final InviteExternalData? data}) = _$InviteExternalModelResponseImpl;

  factory _InviteExternalModelResponse.fromJson(Map<String, dynamic> json) =
      _$InviteExternalModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  InviteExternalData? get data;

  /// Create a copy of InviteExternalModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InviteExternalModelResponseImplCopyWith<_$InviteExternalModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InviteExternalData _$InviteExternalDataFromJson(Map<String, dynamic> json) {
  return _InviteExternalData.fromJson(json);
}

/// @nodoc
mixin _$InviteExternalData {
  @JsonKey(name: 'invite_id')
  int? get inviteId => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_id')
  int? get consultationId => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String? get expiresAt => throw _privateConstructorUsedError;

  /// Present on 409 when the email already has an account.
  @JsonKey(name: 'existing_user_id')
  int? get existingUserId => throw _privateConstructorUsedError;

  /// Serializes this InviteExternalData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InviteExternalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InviteExternalDataCopyWith<InviteExternalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InviteExternalDataCopyWith<$Res> {
  factory $InviteExternalDataCopyWith(
          InviteExternalData value, $Res Function(InviteExternalData) then) =
      _$InviteExternalDataCopyWithImpl<$Res, InviteExternalData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'invite_id') int? inviteId,
      @JsonKey(name: 'consultation_id') int? consultationId,
      String? email,
      @JsonKey(name: 'expires_at') String? expiresAt,
      @JsonKey(name: 'existing_user_id') int? existingUserId});
}

/// @nodoc
class _$InviteExternalDataCopyWithImpl<$Res, $Val extends InviteExternalData>
    implements $InviteExternalDataCopyWith<$Res> {
  _$InviteExternalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InviteExternalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteId = freezed,
    Object? consultationId = freezed,
    Object? email = freezed,
    Object? expiresAt = freezed,
    Object? existingUserId = freezed,
  }) {
    return _then(_value.copyWith(
      inviteId: freezed == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as int?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
      existingUserId: freezed == existingUserId
          ? _value.existingUserId
          : existingUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InviteExternalDataImplCopyWith<$Res>
    implements $InviteExternalDataCopyWith<$Res> {
  factory _$$InviteExternalDataImplCopyWith(_$InviteExternalDataImpl value,
          $Res Function(_$InviteExternalDataImpl) then) =
      __$$InviteExternalDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'invite_id') int? inviteId,
      @JsonKey(name: 'consultation_id') int? consultationId,
      String? email,
      @JsonKey(name: 'expires_at') String? expiresAt,
      @JsonKey(name: 'existing_user_id') int? existingUserId});
}

/// @nodoc
class __$$InviteExternalDataImplCopyWithImpl<$Res>
    extends _$InviteExternalDataCopyWithImpl<$Res, _$InviteExternalDataImpl>
    implements _$$InviteExternalDataImplCopyWith<$Res> {
  __$$InviteExternalDataImplCopyWithImpl(_$InviteExternalDataImpl _value,
      $Res Function(_$InviteExternalDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of InviteExternalData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inviteId = freezed,
    Object? consultationId = freezed,
    Object? email = freezed,
    Object? expiresAt = freezed,
    Object? existingUserId = freezed,
  }) {
    return _then(_$InviteExternalDataImpl(
      inviteId: freezed == inviteId
          ? _value.inviteId
          : inviteId // ignore: cast_nullable_to_non_nullable
              as int?,
      consultationId: freezed == consultationId
          ? _value.consultationId
          : consultationId // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
      existingUserId: freezed == existingUserId
          ? _value.existingUserId
          : existingUserId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InviteExternalDataImpl implements _InviteExternalData {
  const _$InviteExternalDataImpl(
      {@JsonKey(name: 'invite_id') this.inviteId,
      @JsonKey(name: 'consultation_id') this.consultationId,
      this.email,
      @JsonKey(name: 'expires_at') this.expiresAt,
      @JsonKey(name: 'existing_user_id') this.existingUserId});

  factory _$InviteExternalDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$InviteExternalDataImplFromJson(json);

  @override
  @JsonKey(name: 'invite_id')
  final int? inviteId;
  @override
  @JsonKey(name: 'consultation_id')
  final int? consultationId;
  @override
  final String? email;
  @override
  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  /// Present on 409 when the email already has an account.
  @override
  @JsonKey(name: 'existing_user_id')
  final int? existingUserId;

  @override
  String toString() {
    return 'InviteExternalData(inviteId: $inviteId, consultationId: $consultationId, email: $email, expiresAt: $expiresAt, existingUserId: $existingUserId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InviteExternalDataImpl &&
            (identical(other.inviteId, inviteId) ||
                other.inviteId == inviteId) &&
            (identical(other.consultationId, consultationId) ||
                other.consultationId == consultationId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.existingUserId, existingUserId) ||
                other.existingUserId == existingUserId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, inviteId, consultationId, email, expiresAt, existingUserId);

  /// Create a copy of InviteExternalData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InviteExternalDataImplCopyWith<_$InviteExternalDataImpl> get copyWith =>
      __$$InviteExternalDataImplCopyWithImpl<_$InviteExternalDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InviteExternalDataImplToJson(
      this,
    );
  }
}

abstract class _InviteExternalData implements InviteExternalData {
  const factory _InviteExternalData(
          {@JsonKey(name: 'invite_id') final int? inviteId,
          @JsonKey(name: 'consultation_id') final int? consultationId,
          final String? email,
          @JsonKey(name: 'expires_at') final String? expiresAt,
          @JsonKey(name: 'existing_user_id') final int? existingUserId}) =
      _$InviteExternalDataImpl;

  factory _InviteExternalData.fromJson(Map<String, dynamic> json) =
      _$InviteExternalDataImpl.fromJson;

  @override
  @JsonKey(name: 'invite_id')
  int? get inviteId;
  @override
  @JsonKey(name: 'consultation_id')
  int? get consultationId;
  @override
  String? get email;
  @override
  @JsonKey(name: 'expires_at')
  String? get expiresAt;

  /// Present on 409 when the email already has an account.
  @override
  @JsonKey(name: 'existing_user_id')
  int? get existingUserId;

  /// Create a copy of InviteExternalData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InviteExternalDataImplCopyWith<_$InviteExternalDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
