// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_with_google_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthenticationWithGoogleModelResponse
    _$AuthenticationWithGoogleModelResponseFromJson(Map<String, dynamic> json) {
  return _AuthenticationWithGoogleModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationWithGoogleModelResponse {
  String? get message => throw _privateConstructorUsedError;
  AuthenticationWithGoogleDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this AuthenticationWithGoogleModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthenticationWithGoogleModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthenticationWithGoogleModelResponseCopyWith<
          AuthenticationWithGoogleModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationWithGoogleModelResponseCopyWith<$Res> {
  factory $AuthenticationWithGoogleModelResponseCopyWith(
          AuthenticationWithGoogleModelResponse value,
          $Res Function(AuthenticationWithGoogleModelResponse) then) =
      _$AuthenticationWithGoogleModelResponseCopyWithImpl<$Res,
          AuthenticationWithGoogleModelResponse>;
  @useResult
  $Res call({String? message, AuthenticationWithGoogleDataModelResponse? data});

  $AuthenticationWithGoogleDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$AuthenticationWithGoogleModelResponseCopyWithImpl<$Res,
        $Val extends AuthenticationWithGoogleModelResponse>
    implements $AuthenticationWithGoogleModelResponseCopyWith<$Res> {
  _$AuthenticationWithGoogleModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationWithGoogleModelResponse
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
              as AuthenticationWithGoogleDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of AuthenticationWithGoogleModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthenticationWithGoogleDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $AuthenticationWithGoogleDataModelResponseCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationWithGoogleModelResponseImplCopyWith<$Res>
    implements $AuthenticationWithGoogleModelResponseCopyWith<$Res> {
  factory _$$AuthenticationWithGoogleModelResponseImplCopyWith(
          _$AuthenticationWithGoogleModelResponseImpl value,
          $Res Function(_$AuthenticationWithGoogleModelResponseImpl) then) =
      __$$AuthenticationWithGoogleModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, AuthenticationWithGoogleDataModelResponse? data});

  @override
  $AuthenticationWithGoogleDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$AuthenticationWithGoogleModelResponseImplCopyWithImpl<$Res>
    extends _$AuthenticationWithGoogleModelResponseCopyWithImpl<$Res,
        _$AuthenticationWithGoogleModelResponseImpl>
    implements _$$AuthenticationWithGoogleModelResponseImplCopyWith<$Res> {
  __$$AuthenticationWithGoogleModelResponseImplCopyWithImpl(
      _$AuthenticationWithGoogleModelResponseImpl _value,
      $Res Function(_$AuthenticationWithGoogleModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationWithGoogleModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$AuthenticationWithGoogleModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthenticationWithGoogleDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationWithGoogleModelResponseImpl
    implements _AuthenticationWithGoogleModelResponse {
  const _$AuthenticationWithGoogleModelResponseImpl({this.message, this.data});

  factory _$AuthenticationWithGoogleModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationWithGoogleModelResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final AuthenticationWithGoogleDataModelResponse? data;

  @override
  String toString() {
    return 'AuthenticationWithGoogleModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationWithGoogleModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, data);

  /// Create a copy of AuthenticationWithGoogleModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationWithGoogleModelResponseImplCopyWith<
          _$AuthenticationWithGoogleModelResponseImpl>
      get copyWith => __$$AuthenticationWithGoogleModelResponseImplCopyWithImpl<
          _$AuthenticationWithGoogleModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationWithGoogleModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationWithGoogleModelResponse
    implements AuthenticationWithGoogleModelResponse {
  const factory _AuthenticationWithGoogleModelResponse(
          {final String? message,
          final AuthenticationWithGoogleDataModelResponse? data}) =
      _$AuthenticationWithGoogleModelResponseImpl;

  factory _AuthenticationWithGoogleModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AuthenticationWithGoogleModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  AuthenticationWithGoogleDataModelResponse? get data;

  /// Create a copy of AuthenticationWithGoogleModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationWithGoogleModelResponseImplCopyWith<
          _$AuthenticationWithGoogleModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AuthenticationWithGoogleDataModelResponse
    _$AuthenticationWithGoogleDataModelResponseFromJson(
        Map<String, dynamic> json) {
  return _AuthenticationWithGoogleDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationWithGoogleDataModelResponse {
  @JsonKey(name: 'user')
  DoctorModel? get doctorModel => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  List<String>? get permissions => throw _privateConstructorUsedError;

  /// Serializes this AuthenticationWithGoogleDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthenticationWithGoogleDataModelResponseCopyWith<
          AuthenticationWithGoogleDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationWithGoogleDataModelResponseCopyWith<$Res> {
  factory $AuthenticationWithGoogleDataModelResponseCopyWith(
          AuthenticationWithGoogleDataModelResponse value,
          $Res Function(AuthenticationWithGoogleDataModelResponse) then) =
      _$AuthenticationWithGoogleDataModelResponseCopyWithImpl<$Res,
          AuthenticationWithGoogleDataModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user') DoctorModel? doctorModel,
      String? token,
      String? provider,
      List<String>? permissions});

  $DoctorModelCopyWith<$Res>? get doctorModel;
}

/// @nodoc
class _$AuthenticationWithGoogleDataModelResponseCopyWithImpl<$Res,
        $Val extends AuthenticationWithGoogleDataModelResponse>
    implements $AuthenticationWithGoogleDataModelResponseCopyWith<$Res> {
  _$AuthenticationWithGoogleDataModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorModel = freezed,
    Object? token = freezed,
    Object? provider = freezed,
    Object? permissions = freezed,
  }) {
    return _then(_value.copyWith(
      doctorModel: freezed == doctorModel
          ? _value.doctorModel
          : doctorModel // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctorModel {
    if (_value.doctorModel == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctorModel!, (value) {
      return _then(_value.copyWith(doctorModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthenticationWithGoogleDataModelResponseImplCopyWith<$Res>
    implements $AuthenticationWithGoogleDataModelResponseCopyWith<$Res> {
  factory _$$AuthenticationWithGoogleDataModelResponseImplCopyWith(
          _$AuthenticationWithGoogleDataModelResponseImpl value,
          $Res Function(_$AuthenticationWithGoogleDataModelResponseImpl) then) =
      __$$AuthenticationWithGoogleDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user') DoctorModel? doctorModel,
      String? token,
      String? provider,
      List<String>? permissions});

  @override
  $DoctorModelCopyWith<$Res>? get doctorModel;
}

/// @nodoc
class __$$AuthenticationWithGoogleDataModelResponseImplCopyWithImpl<$Res>
    extends _$AuthenticationWithGoogleDataModelResponseCopyWithImpl<$Res,
        _$AuthenticationWithGoogleDataModelResponseImpl>
    implements _$$AuthenticationWithGoogleDataModelResponseImplCopyWith<$Res> {
  __$$AuthenticationWithGoogleDataModelResponseImplCopyWithImpl(
      _$AuthenticationWithGoogleDataModelResponseImpl _value,
      $Res Function(_$AuthenticationWithGoogleDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? doctorModel = freezed,
    Object? token = freezed,
    Object? provider = freezed,
    Object? permissions = freezed,
  }) {
    return _then(_$AuthenticationWithGoogleDataModelResponseImpl(
      doctorModel: freezed == doctorModel
          ? _value.doctorModel
          : doctorModel // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      permissions: freezed == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationWithGoogleDataModelResponseImpl
    implements _AuthenticationWithGoogleDataModelResponse {
  const _$AuthenticationWithGoogleDataModelResponseImpl(
      {@JsonKey(name: 'user') this.doctorModel,
      this.token,
      this.provider,
      final List<String>? permissions})
      : _permissions = permissions;

  factory _$AuthenticationWithGoogleDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationWithGoogleDataModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'user')
  final DoctorModel? doctorModel;
  @override
  final String? token;
  @override
  final String? provider;
  final List<String>? _permissions;
  @override
  List<String>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AuthenticationWithGoogleDataModelResponse(doctorModel: $doctorModel, token: $token, provider: $provider, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationWithGoogleDataModelResponseImpl &&
            (identical(other.doctorModel, doctorModel) ||
                other.doctorModel == doctorModel) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, doctorModel, token, provider,
      const DeepCollectionEquality().hash(_permissions));

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationWithGoogleDataModelResponseImplCopyWith<
          _$AuthenticationWithGoogleDataModelResponseImpl>
      get copyWith =>
          __$$AuthenticationWithGoogleDataModelResponseImplCopyWithImpl<
                  _$AuthenticationWithGoogleDataModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationWithGoogleDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationWithGoogleDataModelResponse
    implements AuthenticationWithGoogleDataModelResponse {
  const factory _AuthenticationWithGoogleDataModelResponse(
          {@JsonKey(name: 'user') final DoctorModel? doctorModel,
          final String? token,
          final String? provider,
          final List<String>? permissions}) =
      _$AuthenticationWithGoogleDataModelResponseImpl;

  factory _AuthenticationWithGoogleDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$AuthenticationWithGoogleDataModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'user')
  DoctorModel? get doctorModel;
  @override
  String? get token;
  @override
  String? get provider;
  @override
  List<String>? get permissions;

  /// Create a copy of AuthenticationWithGoogleDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationWithGoogleDataModelResponseImplCopyWith<
          _$AuthenticationWithGoogleDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
