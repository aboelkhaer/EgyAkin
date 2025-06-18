// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_new_medicine_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateNewMedicineModelResponse _$CreateNewMedicineModelResponseFromJson(
    Map<String, dynamic> json) {
  return _CreateNewMedicineModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateNewMedicineModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this CreateNewMedicineModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateNewMedicineModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateNewMedicineModelResponseCopyWith<CreateNewMedicineModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateNewMedicineModelResponseCopyWith<$Res> {
  factory $CreateNewMedicineModelResponseCopyWith(
          CreateNewMedicineModelResponse value,
          $Res Function(CreateNewMedicineModelResponse) then) =
      _$CreateNewMedicineModelResponseCopyWithImpl<$Res,
          CreateNewMedicineModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$CreateNewMedicineModelResponseCopyWithImpl<$Res,
        $Val extends CreateNewMedicineModelResponse>
    implements $CreateNewMedicineModelResponseCopyWith<$Res> {
  _$CreateNewMedicineModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateNewMedicineModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateNewMedicineModelResponseImplCopyWith<$Res>
    implements $CreateNewMedicineModelResponseCopyWith<$Res> {
  factory _$$CreateNewMedicineModelResponseImplCopyWith(
          _$CreateNewMedicineModelResponseImpl value,
          $Res Function(_$CreateNewMedicineModelResponseImpl) then) =
      __$$CreateNewMedicineModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$CreateNewMedicineModelResponseImplCopyWithImpl<$Res>
    extends _$CreateNewMedicineModelResponseCopyWithImpl<$Res,
        _$CreateNewMedicineModelResponseImpl>
    implements _$$CreateNewMedicineModelResponseImplCopyWith<$Res> {
  __$$CreateNewMedicineModelResponseImplCopyWithImpl(
      _$CreateNewMedicineModelResponseImpl _value,
      $Res Function(_$CreateNewMedicineModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateNewMedicineModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$CreateNewMedicineModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateNewMedicineModelResponseImpl
    implements _CreateNewMedicineModelResponse {
  const _$CreateNewMedicineModelResponseImpl({this.message});

  factory _$CreateNewMedicineModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateNewMedicineModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'CreateNewMedicineModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateNewMedicineModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CreateNewMedicineModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateNewMedicineModelResponseImplCopyWith<
          _$CreateNewMedicineModelResponseImpl>
      get copyWith => __$$CreateNewMedicineModelResponseImplCopyWithImpl<
          _$CreateNewMedicineModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateNewMedicineModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateNewMedicineModelResponse
    implements CreateNewMedicineModelResponse {
  const factory _CreateNewMedicineModelResponse({final String? message}) =
      _$CreateNewMedicineModelResponseImpl;

  factory _CreateNewMedicineModelResponse.fromJson(Map<String, dynamic> json) =
      _$CreateNewMedicineModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of CreateNewMedicineModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateNewMedicineModelResponseImplCopyWith<
          _$CreateNewMedicineModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
