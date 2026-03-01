// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_permissions_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPermissionsModelResponse _$GetPermissionsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPermissionsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPermissionsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get permissions => throw _privateConstructorUsedError;

  /// Serializes this GetPermissionsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPermissionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPermissionsModelResponseCopyWith<GetPermissionsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPermissionsModelResponseCopyWith<$Res> {
  factory $GetPermissionsModelResponseCopyWith(
          GetPermissionsModelResponse value,
          $Res Function(GetPermissionsModelResponse) then) =
      _$GetPermissionsModelResponseCopyWithImpl<$Res,
          GetPermissionsModelResponse>;
  @useResult
  $Res call({bool? value, String? message, List<String>? permissions});
}

/// @nodoc
class _$GetPermissionsModelResponseCopyWithImpl<$Res,
        $Val extends GetPermissionsModelResponse>
    implements $GetPermissionsModelResponseCopyWith<$Res> {
  _$GetPermissionsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPermissionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? permissions = freezed,
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
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPermissionsModelResponseImplCopyWith<$Res>
    implements $GetPermissionsModelResponseCopyWith<$Res> {
  factory _$$GetPermissionsModelResponseImplCopyWith(
          _$GetPermissionsModelResponseImpl value,
          $Res Function(_$GetPermissionsModelResponseImpl) then) =
      __$$GetPermissionsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message, List<String>? permissions});
}

/// @nodoc
class __$$GetPermissionsModelResponseImplCopyWithImpl<$Res>
    extends _$GetPermissionsModelResponseCopyWithImpl<$Res,
        _$GetPermissionsModelResponseImpl>
    implements _$$GetPermissionsModelResponseImplCopyWith<$Res> {
  __$$GetPermissionsModelResponseImplCopyWithImpl(
      _$GetPermissionsModelResponseImpl _value,
      $Res Function(_$GetPermissionsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPermissionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? permissions = freezed,
  }) {
    return _then(_$GetPermissionsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$GetPermissionsModelResponseImpl
    implements _GetPermissionsModelResponse {
  const _$GetPermissionsModelResponseImpl(
      {this.value, this.message, final List<String>? permissions})
      : _permissions = permissions;

  factory _$GetPermissionsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPermissionsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
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
    return 'GetPermissionsModelResponse(value: $value, message: $message, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPermissionsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, message,
      const DeepCollectionEquality().hash(_permissions));

  /// Create a copy of GetPermissionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPermissionsModelResponseImplCopyWith<_$GetPermissionsModelResponseImpl>
      get copyWith => __$$GetPermissionsModelResponseImplCopyWithImpl<
          _$GetPermissionsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPermissionsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPermissionsModelResponse
    implements GetPermissionsModelResponse {
  const factory _GetPermissionsModelResponse(
      {final bool? value,
      final String? message,
      final List<String>? permissions}) = _$GetPermissionsModelResponseImpl;

  factory _GetPermissionsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPermissionsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  List<String>? get permissions;

  /// Create a copy of GetPermissionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPermissionsModelResponseImplCopyWith<_$GetPermissionsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
