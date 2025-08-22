// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_patient_recommendation_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreatePatientRecommendationModelResponse
    _$CreatePatientRecommendationModelResponseFromJson(
        Map<String, dynamic> json) {
  return _CreatePatientRecommendationModelResponse.fromJson(json);
}

/// @nodoc
mixin _$CreatePatientRecommendationModelResponse {
  String? get message => throw _privateConstructorUsedError;
  List<GetRecommendationsDataModelResponse>? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this CreatePatientRecommendationModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePatientRecommendationModelResponseCopyWith<
          CreatePatientRecommendationModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePatientRecommendationModelResponseCopyWith<$Res> {
  factory $CreatePatientRecommendationModelResponseCopyWith(
          CreatePatientRecommendationModelResponse value,
          $Res Function(CreatePatientRecommendationModelResponse) then) =
      _$CreatePatientRecommendationModelResponseCopyWithImpl<$Res,
          CreatePatientRecommendationModelResponse>;
  @useResult
  $Res call({String? message, List<GetRecommendationsDataModelResponse>? data});
}

/// @nodoc
class _$CreatePatientRecommendationModelResponseCopyWithImpl<$Res,
        $Val extends CreatePatientRecommendationModelResponse>
    implements $CreatePatientRecommendationModelResponseCopyWith<$Res> {
  _$CreatePatientRecommendationModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePatientRecommendationModelResponse
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
              as List<GetRecommendationsDataModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePatientRecommendationModelResponseImplCopyWith<$Res>
    implements $CreatePatientRecommendationModelResponseCopyWith<$Res> {
  factory _$$CreatePatientRecommendationModelResponseImplCopyWith(
          _$CreatePatientRecommendationModelResponseImpl value,
          $Res Function(_$CreatePatientRecommendationModelResponseImpl) then) =
      __$$CreatePatientRecommendationModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, List<GetRecommendationsDataModelResponse>? data});
}

/// @nodoc
class __$$CreatePatientRecommendationModelResponseImplCopyWithImpl<$Res>
    extends _$CreatePatientRecommendationModelResponseCopyWithImpl<$Res,
        _$CreatePatientRecommendationModelResponseImpl>
    implements _$$CreatePatientRecommendationModelResponseImplCopyWith<$Res> {
  __$$CreatePatientRecommendationModelResponseImplCopyWithImpl(
      _$CreatePatientRecommendationModelResponseImpl _value,
      $Res Function(_$CreatePatientRecommendationModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$CreatePatientRecommendationModelResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GetRecommendationsDataModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePatientRecommendationModelResponseImpl
    implements _CreatePatientRecommendationModelResponse {
  const _$CreatePatientRecommendationModelResponseImpl(
      {this.message, final List<GetRecommendationsDataModelResponse>? data})
      : _data = data;

  factory _$CreatePatientRecommendationModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreatePatientRecommendationModelResponseImplFromJson(json);

  @override
  final String? message;
  final List<GetRecommendationsDataModelResponse>? _data;
  @override
  List<GetRecommendationsDataModelResponse>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CreatePatientRecommendationModelResponse(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePatientRecommendationModelResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_data));

  /// Create a copy of CreatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePatientRecommendationModelResponseImplCopyWith<
          _$CreatePatientRecommendationModelResponseImpl>
      get copyWith =>
          __$$CreatePatientRecommendationModelResponseImplCopyWithImpl<
              _$CreatePatientRecommendationModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePatientRecommendationModelResponseImplToJson(
      this,
    );
  }
}

abstract class _CreatePatientRecommendationModelResponse
    implements CreatePatientRecommendationModelResponse {
  const factory _CreatePatientRecommendationModelResponse(
          {final String? message,
          final List<GetRecommendationsDataModelResponse>? data}) =
      _$CreatePatientRecommendationModelResponseImpl;

  factory _CreatePatientRecommendationModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$CreatePatientRecommendationModelResponseImpl.fromJson;

  @override
  String? get message;
  @override
  List<GetRecommendationsDataModelResponse>? get data;

  /// Create a copy of CreatePatientRecommendationModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePatientRecommendationModelResponseImplCopyWith<
          _$CreatePatientRecommendationModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
