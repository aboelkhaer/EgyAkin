// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_language_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangeLanguageModelResponse _$ChangeLanguageModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ChangeLanguageModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ChangeLanguageModelResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ChangeLanguageModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeLanguageModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeLanguageModelResponseCopyWith<ChangeLanguageModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeLanguageModelResponseCopyWith<$Res> {
  factory $ChangeLanguageModelResponseCopyWith(
          ChangeLanguageModelResponse value,
          $Res Function(ChangeLanguageModelResponse) then) =
      _$ChangeLanguageModelResponseCopyWithImpl<$Res,
          ChangeLanguageModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$ChangeLanguageModelResponseCopyWithImpl<$Res,
        $Val extends ChangeLanguageModelResponse>
    implements $ChangeLanguageModelResponseCopyWith<$Res> {
  _$ChangeLanguageModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeLanguageModelResponse
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
abstract class _$$ChangeLanguageModelResponseImplCopyWith<$Res>
    implements $ChangeLanguageModelResponseCopyWith<$Res> {
  factory _$$ChangeLanguageModelResponseImplCopyWith(
          _$ChangeLanguageModelResponseImpl value,
          $Res Function(_$ChangeLanguageModelResponseImpl) then) =
      __$$ChangeLanguageModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ChangeLanguageModelResponseImplCopyWithImpl<$Res>
    extends _$ChangeLanguageModelResponseCopyWithImpl<$Res,
        _$ChangeLanguageModelResponseImpl>
    implements _$$ChangeLanguageModelResponseImplCopyWith<$Res> {
  __$$ChangeLanguageModelResponseImplCopyWithImpl(
      _$ChangeLanguageModelResponseImpl _value,
      $Res Function(_$ChangeLanguageModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeLanguageModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ChangeLanguageModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeLanguageModelResponseImpl
    implements _ChangeLanguageModelResponse {
  const _$ChangeLanguageModelResponseImpl({this.message});

  factory _$ChangeLanguageModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangeLanguageModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'ChangeLanguageModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeLanguageModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChangeLanguageModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeLanguageModelResponseImplCopyWith<_$ChangeLanguageModelResponseImpl>
      get copyWith => __$$ChangeLanguageModelResponseImplCopyWithImpl<
          _$ChangeLanguageModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeLanguageModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ChangeLanguageModelResponse
    implements ChangeLanguageModelResponse {
  const factory _ChangeLanguageModelResponse({final String? message}) =
      _$ChangeLanguageModelResponseImpl;

  factory _ChangeLanguageModelResponse.fromJson(Map<String, dynamic> json) =
      _$ChangeLanguageModelResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of ChangeLanguageModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeLanguageModelResponseImplCopyWith<_$ChangeLanguageModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
