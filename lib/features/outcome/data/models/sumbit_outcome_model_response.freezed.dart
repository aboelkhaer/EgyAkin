// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sumbit_outcome_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubmitOutcomeModelResponse _$SubmitOutcomeModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SubmitOutcomeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SubmitOutcomeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubmitOutcomeModelResponseCopyWith<SubmitOutcomeModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitOutcomeModelResponseCopyWith<$Res> {
  factory $SubmitOutcomeModelResponseCopyWith(SubmitOutcomeModelResponse value,
          $Res Function(SubmitOutcomeModelResponse) then) =
      _$SubmitOutcomeModelResponseCopyWithImpl<$Res,
          SubmitOutcomeModelResponse>;
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class _$SubmitOutcomeModelResponseCopyWithImpl<$Res,
        $Val extends SubmitOutcomeModelResponse>
    implements $SubmitOutcomeModelResponseCopyWith<$Res> {
  _$SubmitOutcomeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitOutcomeModelResponseImplCopyWith<$Res>
    implements $SubmitOutcomeModelResponseCopyWith<$Res> {
  factory _$$SubmitOutcomeModelResponseImplCopyWith(
          _$SubmitOutcomeModelResponseImpl value,
          $Res Function(_$SubmitOutcomeModelResponseImpl) then) =
      __$$SubmitOutcomeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, String? message});
}

/// @nodoc
class __$$SubmitOutcomeModelResponseImplCopyWithImpl<$Res>
    extends _$SubmitOutcomeModelResponseCopyWithImpl<$Res,
        _$SubmitOutcomeModelResponseImpl>
    implements _$$SubmitOutcomeModelResponseImplCopyWith<$Res> {
  __$$SubmitOutcomeModelResponseImplCopyWithImpl(
      _$SubmitOutcomeModelResponseImpl _value,
      $Res Function(_$SubmitOutcomeModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
  }) {
    return _then(_$SubmitOutcomeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubmitOutcomeModelResponseImpl
    with DiagnosticableTreeMixin
    implements _SubmitOutcomeModelResponse {
  const _$SubmitOutcomeModelResponseImpl({this.value, this.message});

  factory _$SubmitOutcomeModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SubmitOutcomeModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubmitOutcomeModelResponse(value: $value, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubmitOutcomeModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitOutcomeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitOutcomeModelResponseImplCopyWith<_$SubmitOutcomeModelResponseImpl>
      get copyWith => __$$SubmitOutcomeModelResponseImplCopyWithImpl<
          _$SubmitOutcomeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmitOutcomeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SubmitOutcomeModelResponse
    implements SubmitOutcomeModelResponse {
  const factory _SubmitOutcomeModelResponse(
      {final bool? value,
      final String? message}) = _$SubmitOutcomeModelResponseImpl;

  factory _SubmitOutcomeModelResponse.fromJson(Map<String, dynamic> json) =
      _$SubmitOutcomeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$SubmitOutcomeModelResponseImplCopyWith<_$SubmitOutcomeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
