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
  @JsonKey(name: 'ai_mode')
  String? get aiMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_hint')
  String? get aiHint => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_voice_time')
  int? get aiVoiceTime => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPatientSectionDetailsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPatientSectionDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  $Res call(
      {bool? value,
      @JsonKey(name: 'ai_mode') String? aiMode,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      List<QuestionModel>? data});
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

  /// Create a copy of GetPatientSectionDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? aiMode = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      aiMode: freezed == aiMode
          ? _value.aiMode
          : aiMode // ignore: cast_nullable_to_non_nullable
              as String?,
      aiHint: freezed == aiHint
          ? _value.aiHint
          : aiHint // ignore: cast_nullable_to_non_nullable
              as String?,
      aiVoiceTime: freezed == aiVoiceTime
          ? _value.aiVoiceTime
          : aiVoiceTime // ignore: cast_nullable_to_non_nullable
              as int?,
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
  $Res call(
      {bool? value,
      @JsonKey(name: 'ai_mode') String? aiMode,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      List<QuestionModel>? data});
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

  /// Create a copy of GetPatientSectionDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? aiMode = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPatientSectionDetailsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      aiMode: freezed == aiMode
          ? _value.aiMode
          : aiMode // ignore: cast_nullable_to_non_nullable
              as String?,
      aiHint: freezed == aiHint
          ? _value.aiHint
          : aiHint // ignore: cast_nullable_to_non_nullable
              as String?,
      aiVoiceTime: freezed == aiVoiceTime
          ? _value.aiVoiceTime
          : aiVoiceTime // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {this.value,
      @JsonKey(name: 'ai_mode') this.aiMode,
      @JsonKey(name: 'ai_hint') this.aiHint,
      @JsonKey(name: 'ai_voice_time') this.aiVoiceTime,
      final List<QuestionModel>? data})
      : _data = data;

  factory _$GetPatientSectionDetailsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPatientSectionDetailsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  @JsonKey(name: 'ai_mode')
  final String? aiMode;
  @override
  @JsonKey(name: 'ai_hint')
  final String? aiHint;
  @override
  @JsonKey(name: 'ai_voice_time')
  final int? aiVoiceTime;
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
    return 'GetPatientSectionDetailsModelResponse(value: $value, aiMode: $aiMode, aiHint: $aiHint, aiVoiceTime: $aiVoiceTime, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientSectionDetailsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.aiMode, aiMode) || other.aiMode == aiMode) &&
            (identical(other.aiHint, aiHint) || other.aiHint == aiHint) &&
            (identical(other.aiVoiceTime, aiVoiceTime) ||
                other.aiVoiceTime == aiVoiceTime) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, aiMode, aiHint,
      aiVoiceTime, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetPatientSectionDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
          {final bool? value,
          @JsonKey(name: 'ai_mode') final String? aiMode,
          @JsonKey(name: 'ai_hint') final String? aiHint,
          @JsonKey(name: 'ai_voice_time') final int? aiVoiceTime,
          final List<QuestionModel>? data}) =
      _$GetPatientSectionDetailsModelResponseImpl;

  factory _GetPatientSectionDetailsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetPatientSectionDetailsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  @JsonKey(name: 'ai_mode')
  String? get aiMode;
  @override
  @JsonKey(name: 'ai_hint')
  String? get aiHint;
  @override
  @JsonKey(name: 'ai_voice_time')
  int? get aiVoiceTime;
  @override
  List<QuestionModel>? get data;

  /// Create a copy of GetPatientSectionDetailsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPatientSectionDetailsModelResponseImplCopyWith<
          _$GetPatientSectionDetailsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
