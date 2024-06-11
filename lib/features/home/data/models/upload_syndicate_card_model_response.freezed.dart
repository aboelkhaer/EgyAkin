// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_syndicate_card_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UploadSyndicateCardModelResponse _$UploadSyndicateCardModelResponseFromJson(
    Map<String, dynamic> json) {
  return _UploadSyndicateCardModelResponse.fromJson(json);
}

/// @nodoc
mixin _$UploadSyndicateCardModelResponse {
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadSyndicateCardModelResponseCopyWith<UploadSyndicateCardModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadSyndicateCardModelResponseCopyWith<$Res> {
  factory $UploadSyndicateCardModelResponseCopyWith(
          UploadSyndicateCardModelResponse value,
          $Res Function(UploadSyndicateCardModelResponse) then) =
      _$UploadSyndicateCardModelResponseCopyWithImpl<$Res,
          UploadSyndicateCardModelResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$UploadSyndicateCardModelResponseCopyWithImpl<$Res,
        $Val extends UploadSyndicateCardModelResponse>
    implements $UploadSyndicateCardModelResponseCopyWith<$Res> {
  _$UploadSyndicateCardModelResponseCopyWithImpl(this._value, this._then);

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
abstract class _$$UploadSyndicateCardModelResponseImplCopyWith<$Res>
    implements $UploadSyndicateCardModelResponseCopyWith<$Res> {
  factory _$$UploadSyndicateCardModelResponseImplCopyWith(
          _$UploadSyndicateCardModelResponseImpl value,
          $Res Function(_$UploadSyndicateCardModelResponseImpl) then) =
      __$$UploadSyndicateCardModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UploadSyndicateCardModelResponseImplCopyWithImpl<$Res>
    extends _$UploadSyndicateCardModelResponseCopyWithImpl<$Res,
        _$UploadSyndicateCardModelResponseImpl>
    implements _$$UploadSyndicateCardModelResponseImplCopyWith<$Res> {
  __$$UploadSyndicateCardModelResponseImplCopyWithImpl(
      _$UploadSyndicateCardModelResponseImpl _value,
      $Res Function(_$UploadSyndicateCardModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UploadSyndicateCardModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UploadSyndicateCardModelResponseImpl
    implements _UploadSyndicateCardModelResponse {
  const _$UploadSyndicateCardModelResponseImpl({this.message});

  factory _$UploadSyndicateCardModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UploadSyndicateCardModelResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'UploadSyndicateCardModelResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadSyndicateCardModelResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadSyndicateCardModelResponseImplCopyWith<
          _$UploadSyndicateCardModelResponseImpl>
      get copyWith => __$$UploadSyndicateCardModelResponseImplCopyWithImpl<
          _$UploadSyndicateCardModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadSyndicateCardModelResponseImplToJson(
      this,
    );
  }
}

abstract class _UploadSyndicateCardModelResponse
    implements UploadSyndicateCardModelResponse {
  const factory _UploadSyndicateCardModelResponse({final String? message}) =
      _$UploadSyndicateCardModelResponseImpl;

  factory _UploadSyndicateCardModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$UploadSyndicateCardModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$UploadSyndicateCardModelResponseImplCopyWith<
          _$UploadSyndicateCardModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
