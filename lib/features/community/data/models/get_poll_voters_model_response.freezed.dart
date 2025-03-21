// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_poll_voters_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPollVotersModelResponse _$GetPollVotersModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPollVotersModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPollVotersModelResponse {
  List<DoctorModel>? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this GetPollVotersModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPollVotersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPollVotersModelResponseCopyWith<GetPollVotersModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPollVotersModelResponseCopyWith<$Res> {
  factory $GetPollVotersModelResponseCopyWith(GetPollVotersModelResponse value,
          $Res Function(GetPollVotersModelResponse) then) =
      _$GetPollVotersModelResponseCopyWithImpl<$Res,
          GetPollVotersModelResponse>;
  @useResult
  $Res call({List<DoctorModel>? data, String? message});
}

/// @nodoc
class _$GetPollVotersModelResponseCopyWithImpl<$Res,
        $Val extends GetPollVotersModelResponse>
    implements $GetPollVotersModelResponseCopyWith<$Res> {
  _$GetPollVotersModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPollVotersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPollVotersModelResponseImplCopyWith<$Res>
    implements $GetPollVotersModelResponseCopyWith<$Res> {
  factory _$$GetPollVotersModelResponseImplCopyWith(
          _$GetPollVotersModelResponseImpl value,
          $Res Function(_$GetPollVotersModelResponseImpl) then) =
      __$$GetPollVotersModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DoctorModel>? data, String? message});
}

/// @nodoc
class __$$GetPollVotersModelResponseImplCopyWithImpl<$Res>
    extends _$GetPollVotersModelResponseCopyWithImpl<$Res,
        _$GetPollVotersModelResponseImpl>
    implements _$$GetPollVotersModelResponseImplCopyWith<$Res> {
  __$$GetPollVotersModelResponseImplCopyWithImpl(
      _$GetPollVotersModelResponseImpl _value,
      $Res Function(_$GetPollVotersModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPollVotersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$GetPollVotersModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPollVotersModelResponseImpl implements _GetPollVotersModelResponse {
  const _$GetPollVotersModelResponseImpl(
      {final List<DoctorModel>? data, this.message})
      : _data = data;

  factory _$GetPollVotersModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPollVotersModelResponseImplFromJson(json);

  final List<DoctorModel>? _data;
  @override
  List<DoctorModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? message;

  @override
  String toString() {
    return 'GetPollVotersModelResponse(data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPollVotersModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), message);

  /// Create a copy of GetPollVotersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPollVotersModelResponseImplCopyWith<_$GetPollVotersModelResponseImpl>
      get copyWith => __$$GetPollVotersModelResponseImplCopyWithImpl<
          _$GetPollVotersModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPollVotersModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPollVotersModelResponse
    implements GetPollVotersModelResponse {
  const factory _GetPollVotersModelResponse(
      {final List<DoctorModel>? data,
      final String? message}) = _$GetPollVotersModelResponseImpl;

  factory _GetPollVotersModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPollVotersModelResponseImpl.fromJson;

  @override
  List<DoctorModel>? get data;
  @override
  String? get message;

  /// Create a copy of GetPollVotersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPollVotersModelResponseImplCopyWith<_$GetPollVotersModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
