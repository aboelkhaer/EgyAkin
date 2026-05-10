// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_patient_history_for_add_patient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPatientHistoryForAddPatientModelResponse
    _$GetPatientHistoryForAddPatientModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetPatientHistoryForAddPatientModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPatientHistoryForAddPatientModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_hint')
  String? get aiHint => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_voice_time')
  int? get aiVoiceTime => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this GetPatientHistoryForAddPatientModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPatientHistoryForAddPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPatientHistoryForAddPatientModelResponseCopyWith<
          GetPatientHistoryForAddPatientModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPatientHistoryForAddPatientModelResponseCopyWith<$Res> {
  factory $GetPatientHistoryForAddPatientModelResponseCopyWith(
          GetPatientHistoryForAddPatientModelResponse value,
          $Res Function(GetPatientHistoryForAddPatientModelResponse) then) =
      _$GetPatientHistoryForAddPatientModelResponseCopyWithImpl<$Res,
          GetPatientHistoryForAddPatientModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      List<QuestionModel>? data});
}

/// @nodoc
class _$GetPatientHistoryForAddPatientModelResponseCopyWithImpl<$Res,
        $Val extends GetPatientHistoryForAddPatientModelResponse>
    implements $GetPatientHistoryForAddPatientModelResponseCopyWith<$Res> {
  _$GetPatientHistoryForAddPatientModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPatientHistoryForAddPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
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
abstract class _$$GetPatientHistoryForAddPatientModelResponseImplCopyWith<$Res>
    implements $GetPatientHistoryForAddPatientModelResponseCopyWith<$Res> {
  factory _$$GetPatientHistoryForAddPatientModelResponseImplCopyWith(
          _$GetPatientHistoryForAddPatientModelResponseImpl value,
          $Res Function(_$GetPatientHistoryForAddPatientModelResponseImpl)
              then) =
      __$$GetPatientHistoryForAddPatientModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      List<QuestionModel>? data});
}

/// @nodoc
class __$$GetPatientHistoryForAddPatientModelResponseImplCopyWithImpl<$Res>
    extends _$GetPatientHistoryForAddPatientModelResponseCopyWithImpl<$Res,
        _$GetPatientHistoryForAddPatientModelResponseImpl>
    implements
        _$$GetPatientHistoryForAddPatientModelResponseImplCopyWith<$Res> {
  __$$GetPatientHistoryForAddPatientModelResponseImplCopyWithImpl(
      _$GetPatientHistoryForAddPatientModelResponseImpl _value,
      $Res Function(_$GetPatientHistoryForAddPatientModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPatientHistoryForAddPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetPatientHistoryForAddPatientModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
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
class _$GetPatientHistoryForAddPatientModelResponseImpl
    implements _GetPatientHistoryForAddPatientModelResponse {
  const _$GetPatientHistoryForAddPatientModelResponseImpl(
      {this.value,
      @JsonKey(name: 'ai_hint') this.aiHint,
      @JsonKey(name: 'ai_voice_time') this.aiVoiceTime,
      final List<QuestionModel>? data})
      : _data = data;

  factory _$GetPatientHistoryForAddPatientModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPatientHistoryForAddPatientModelResponseImplFromJson(json);

  @override
  final bool? value;
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
    return 'GetPatientHistoryForAddPatientModelResponse(value: $value, aiHint: $aiHint, aiVoiceTime: $aiVoiceTime, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPatientHistoryForAddPatientModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.aiHint, aiHint) || other.aiHint == aiHint) &&
            (identical(other.aiVoiceTime, aiVoiceTime) ||
                other.aiVoiceTime == aiVoiceTime) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, aiHint, aiVoiceTime,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetPatientHistoryForAddPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPatientHistoryForAddPatientModelResponseImplCopyWith<
          _$GetPatientHistoryForAddPatientModelResponseImpl>
      get copyWith =>
          __$$GetPatientHistoryForAddPatientModelResponseImplCopyWithImpl<
                  _$GetPatientHistoryForAddPatientModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPatientHistoryForAddPatientModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPatientHistoryForAddPatientModelResponse
    implements GetPatientHistoryForAddPatientModelResponse {
  const factory _GetPatientHistoryForAddPatientModelResponse(
          {final bool? value,
          @JsonKey(name: 'ai_hint') final String? aiHint,
          @JsonKey(name: 'ai_voice_time') final int? aiVoiceTime,
          final List<QuestionModel>? data}) =
      _$GetPatientHistoryForAddPatientModelResponseImpl;

  factory _GetPatientHistoryForAddPatientModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetPatientHistoryForAddPatientModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  @JsonKey(name: 'ai_hint')
  String? get aiHint;
  @override
  @JsonKey(name: 'ai_voice_time')
  int? get aiVoiceTime;
  @override
  List<QuestionModel>? get data;

  /// Create a copy of GetPatientHistoryForAddPatientModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPatientHistoryForAddPatientModelResponseImplCopyWith<
          _$GetPatientHistoryForAddPatientModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return _QuestionModel.fromJson(json);
}

/// @nodoc
mixin _$QuestionModel {
  int? get id => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  List<dynamic>? get values => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'keyboard_type')
  String? get keyboardType => throw _privateConstructorUsedError;
  bool? get mandatory => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  dynamic get answer => throw _privateConstructorUsedError;

  /// Serializes this QuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionModelCopyWith<QuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionModelCopyWith<$Res> {
  factory $QuestionModelCopyWith(
          QuestionModel value, $Res Function(QuestionModel) then) =
      _$QuestionModelCopyWithImpl<$Res, QuestionModel>;
  @useResult
  $Res call(
      {int? id,
      String? question,
      List<dynamic>? values,
      String? type,
      @JsonKey(name: 'keyboard_type') String? keyboardType,
      bool? mandatory,
      @JsonKey(name: 'updated_at') String? updatedAt,
      dynamic answer});
}

/// @nodoc
class _$QuestionModelCopyWithImpl<$Res, $Val extends QuestionModel>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? values = freezed,
    Object? type = freezed,
    Object? keyboardType = freezed,
    Object? mandatory = freezed,
    Object? updatedAt = freezed,
    Object? answer = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      values: freezed == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String?,
      mandatory: freezed == mandatory
          ? _value.mandatory
          : mandatory // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuestionModelImplCopyWith<$Res>
    implements $QuestionModelCopyWith<$Res> {
  factory _$$QuestionModelImplCopyWith(
          _$QuestionModelImpl value, $Res Function(_$QuestionModelImpl) then) =
      __$$QuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? question,
      List<dynamic>? values,
      String? type,
      @JsonKey(name: 'keyboard_type') String? keyboardType,
      bool? mandatory,
      @JsonKey(name: 'updated_at') String? updatedAt,
      dynamic answer});
}

/// @nodoc
class __$$QuestionModelImplCopyWithImpl<$Res>
    extends _$QuestionModelCopyWithImpl<$Res, _$QuestionModelImpl>
    implements _$$QuestionModelImplCopyWith<$Res> {
  __$$QuestionModelImplCopyWithImpl(
      _$QuestionModelImpl _value, $Res Function(_$QuestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? values = freezed,
    Object? type = freezed,
    Object? keyboardType = freezed,
    Object? mandatory = freezed,
    Object? updatedAt = freezed,
    Object? answer = freezed,
  }) {
    return _then(_$QuestionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      values: freezed == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      keyboardType: freezed == keyboardType
          ? _value.keyboardType
          : keyboardType // ignore: cast_nullable_to_non_nullable
              as String?,
      mandatory: freezed == mandatory
          ? _value.mandatory
          : mandatory // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionModelImpl implements _QuestionModel {
  const _$QuestionModelImpl(
      {this.id,
      this.question,
      final List<dynamic>? values,
      this.type,
      @JsonKey(name: 'keyboard_type') this.keyboardType,
      this.mandatory,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.answer})
      : _values = values;

  factory _$QuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? question;
  final List<dynamic>? _values;
  @override
  List<dynamic>? get values {
    final value = _values;
    if (value == null) return null;
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? type;
  @override
  @JsonKey(name: 'keyboard_type')
  final String? keyboardType;
  @override
  final bool? mandatory;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  final dynamic answer;

  @override
  String toString() {
    return 'QuestionModel(id: $id, question: $question, values: $values, type: $type, keyboardType: $keyboardType, mandatory: $mandatory, updatedAt: $updatedAt, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.keyboardType, keyboardType) ||
                other.keyboardType == keyboardType) &&
            (identical(other.mandatory, mandatory) ||
                other.mandatory == mandatory) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.answer, answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      question,
      const DeepCollectionEquality().hash(_values),
      type,
      keyboardType,
      mandatory,
      updatedAt,
      const DeepCollectionEquality().hash(answer));

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionModelImplCopyWith<_$QuestionModelImpl> get copyWith =>
      __$$QuestionModelImplCopyWithImpl<_$QuestionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionModelImplToJson(
      this,
    );
  }
}

abstract class _QuestionModel implements QuestionModel {
  const factory _QuestionModel(
      {final int? id,
      final String? question,
      final List<dynamic>? values,
      final String? type,
      @JsonKey(name: 'keyboard_type') final String? keyboardType,
      final bool? mandatory,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final dynamic answer}) = _$QuestionModelImpl;

  factory _QuestionModel.fromJson(Map<String, dynamic> json) =
      _$QuestionModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get question;
  @override
  List<dynamic>? get values;
  @override
  String? get type;
  @override
  @JsonKey(name: 'keyboard_type')
  String? get keyboardType;
  @override
  bool? get mandatory;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  dynamic get answer;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionModelImplCopyWith<_$QuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
