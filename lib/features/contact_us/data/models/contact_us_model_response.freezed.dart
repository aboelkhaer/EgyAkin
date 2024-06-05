// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_us_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContactUsModelResponseModelResponse
    _$ContactUsModelResponseModelResponseFromJson(Map<String, dynamic> json) {
  return _ContactUsModelResponseModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ContactUsModelResponseModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactUsModelResponseModelResponseCopyWith<
          ContactUsModelResponseModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactUsModelResponseModelResponseCopyWith<$Res> {
  factory $ContactUsModelResponseModelResponseCopyWith(
          ContactUsModelResponseModelResponse value,
          $Res Function(ContactUsModelResponseModelResponse) then) =
      _$ContactUsModelResponseModelResponseCopyWithImpl<$Res,
          ContactUsModelResponseModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$ContactUsModelResponseModelResponseCopyWithImpl<$Res,
        $Val extends ContactUsModelResponseModelResponse>
    implements $ContactUsModelResponseModelResponseCopyWith<$Res> {
  _$ContactUsModelResponseModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$ContactUsModelResponseModelResponseImplCopyWith<$Res>
    implements $ContactUsModelResponseModelResponseCopyWith<$Res> {
  factory _$$ContactUsModelResponseModelResponseImplCopyWith(
          _$ContactUsModelResponseModelResponseImpl value,
          $Res Function(_$ContactUsModelResponseModelResponseImpl) then) =
      __$$ContactUsModelResponseModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$ContactUsModelResponseModelResponseImplCopyWithImpl<$Res>
    extends _$ContactUsModelResponseModelResponseCopyWithImpl<$Res,
        _$ContactUsModelResponseModelResponseImpl>
    implements _$$ContactUsModelResponseModelResponseImplCopyWith<$Res> {
  __$$ContactUsModelResponseModelResponseImplCopyWithImpl(
      _$ContactUsModelResponseModelResponseImpl _value,
      $Res Function(_$ContactUsModelResponseModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$ContactUsModelResponseModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactUsModelResponseModelResponseImpl
    implements _ContactUsModelResponseModelResponse {
  const _$ContactUsModelResponseModelResponseImpl({this.message});

  factory _$ContactUsModelResponseModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ContactUsModelResponseModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'ContactUsModelResponseModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactUsModelResponseModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactUsModelResponseModelResponseImplCopyWith<
          _$ContactUsModelResponseModelResponseImpl>
      get copyWith => __$$ContactUsModelResponseModelResponseImplCopyWithImpl<
          _$ContactUsModelResponseModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactUsModelResponseModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ContactUsModelResponseModelResponse
    implements ContactUsModelResponseModelResponse {
  const factory _ContactUsModelResponseModelResponse({final String? message}) =
      _$ContactUsModelResponseModelResponseImpl;

  factory _ContactUsModelResponseModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ContactUsModelResponseModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$ContactUsModelResponseModelResponseImplCopyWith<
          _$ContactUsModelResponseModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
