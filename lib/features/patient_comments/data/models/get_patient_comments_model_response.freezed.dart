// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_patient_comments_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPatientCommentsModelResponse _$GetPatientCommentsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPatientCommentsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPatientCommentsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<CommentModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPatientCommentsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPatientCommentsModelResponseCopyWith<GetPatientCommentsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPatientCommentsModelResponseCopyWith<$Res> {
  factory $GetPatientCommentsModelResponseCopyWith(
          GetPatientCommentsModelResponse value,
          $Res Function(GetPatientCommentsModelResponse) then) =
      _$GetPatientCommentsModelResponseCopyWithImpl<$Res,
          GetPatientCommentsModelResponse>;
  @useResult
  $Res call({bool? value, List<CommentModel>? data});
}

/// @nodoc
class _$GetPatientCommentsModelResponseCopyWithImpl<$Res,
        $Val extends GetPatientCommentsModelResponse>
    implements $GetPatientCommentsModelResponseCopyWith<$Res> {
  _$GetPatientCommentsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPatientCommentsModelResponseImplCopyWith<$Res>
    implements $GetPatientCommentsModelResponseCopyWith<$Res> {
  factory _$$GetPatientCommentsModelResponseImplCopyWith(
          _$GetPatientCommentsModelResponseImpl value,
          $Res Function(_$GetPatientCommentsModelResponseImpl) then) =
      __$$GetPatientCommentsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, List<CommentModel>? data});
}

/// @nodoc
class __$$GetPatientCommentsModelResponseImplCopyWithImpl<$Res>
    extends _$GetPatientCommentsModelResponseCopyWithImpl<$Res,
        _$GetPatientCommentsModelResponseImpl>
    implements _$$GetPatientCommentsModelResponseImplCopyWith<$Res> {
  __$$GetPatientCommentsModelResponseImplCopyWithImpl(
      _$GetPatientCommentsModelResponseImpl _value,
      $Res Function(_$GetPatientCommentsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPatientCommentsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPatientCommentsModelResponseImpl
    implements _GetPatientCommentsModelResponse {
  const _$GetPatientCommentsModelResponseImpl(
      {this.value, final List<CommentModel>? data})
      : _data = data;

  factory _$GetPatientCommentsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPatientCommentsModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<CommentModel>? _data;
  @override
  List<CommentModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetPatientCommentsModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientCommentsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientCommentsModelResponseImplCopyWith<
          _$GetPatientCommentsModelResponseImpl>
      get copyWith => __$$GetPatientCommentsModelResponseImplCopyWithImpl<
          _$GetPatientCommentsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPatientCommentsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPatientCommentsModelResponse
    implements GetPatientCommentsModelResponse {
  const factory _GetPatientCommentsModelResponse(
      {final bool? value,
      final List<CommentModel>? data}) = _$GetPatientCommentsModelResponseImpl;

  factory _GetPatientCommentsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPatientCommentsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<CommentModel>? get data;

  /// Create a copy of GetPatientCommentsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPatientCommentsModelResponseImplCopyWith<
          _$GetPatientCommentsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
