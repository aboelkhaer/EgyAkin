// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_patient_section_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPatientSectionDetailsModelResponse
    _$GetPatientSectionDetailsModelResponseFromJson(Map<String, dynamic> json) {
  return _GetPatientSectionDetailsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPatientSectionDetailsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPatientSectionDetailsModelResponseCopyWith<
          GetPatientSectionDetailsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPatientSectionDetailsModelResponseCopyWith<$Res> {
  factory $GetPatientSectionDetailsModelResponseCopyWith(
          GetPatientSectionDetailsModelResponse value,
          $Res Function(GetPatientSectionDetailsModelResponse) then) =
      _$GetPatientSectionDetailsModelResponseCopyWithImpl<$Res,
          GetPatientSectionDetailsModelResponse>;
  @useResult
  $Res call({bool? value, List<QuestionModel>? data});
}

/// @nodoc
class _$GetPatientSectionDetailsModelResponseCopyWithImpl<$Res,
        $Val extends GetPatientSectionDetailsModelResponse>
    implements $GetPatientSectionDetailsModelResponseCopyWith<$Res> {
  _$GetPatientSectionDetailsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as List<QuestionModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetPatientSectionDetailsModelResponseImplCopyWith<$Res>
    implements $GetPatientSectionDetailsModelResponseCopyWith<$Res> {
  factory _$$GetPatientSectionDetailsModelResponseImplCopyWith(
          _$GetPatientSectionDetailsModelResponseImpl value,
          $Res Function(_$GetPatientSectionDetailsModelResponseImpl) then) =
      __$$GetPatientSectionDetailsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, List<QuestionModel>? data});
}

/// @nodoc
class __$$GetPatientSectionDetailsModelResponseImplCopyWithImpl<$Res>
    extends _$GetPatientSectionDetailsModelResponseCopyWithImpl<$Res,
        _$GetPatientSectionDetailsModelResponseImpl>
    implements _$$GetPatientSectionDetailsModelResponseImplCopyWith<$Res> {
  __$$GetPatientSectionDetailsModelResponseImplCopyWithImpl(
      _$GetPatientSectionDetailsModelResponseImpl _value,
      $Res Function(_$GetPatientSectionDetailsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPatientSectionDetailsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPatientSectionDetailsModelResponseImpl
    implements _GetPatientSectionDetailsModelResponse {
  const _$GetPatientSectionDetailsModelResponseImpl(
      {this.value, final List<QuestionModel>? data})
      : _data = data;

  factory _$GetPatientSectionDetailsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPatientSectionDetailsModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<QuestionModel>? _data;
  @override
  List<QuestionModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetPatientSectionDetailsModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientSectionDetailsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientSectionDetailsModelResponseImplCopyWith<
          _$GetPatientSectionDetailsModelResponseImpl>
      get copyWith => __$$GetPatientSectionDetailsModelResponseImplCopyWithImpl<
          _$GetPatientSectionDetailsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPatientSectionDetailsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPatientSectionDetailsModelResponse
    implements GetPatientSectionDetailsModelResponse {
  const factory _GetPatientSectionDetailsModelResponse(
          {final bool? value, final List<QuestionModel>? data}) =
      _$GetPatientSectionDetailsModelResponseImpl;

  factory _GetPatientSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetPatientSectionDetailsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<QuestionModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$GetPatientSectionDetailsModelResponseImplCopyWith<
          _$GetPatientSectionDetailsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
