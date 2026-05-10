// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_outcome_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetOutcomeModelResponse _$GetOutcomeModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetOutcomeModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetOutcomeModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<QuestionModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_mode')
  String? get aiMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_hint')
  String? get aiHint => throw _privateConstructorUsedError;
  @JsonKey(name: 'ai_voice_time')
  int? get aiVoiceTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Submitter')
  OutcomeSubmitterModel? get submitter => throw _privateConstructorUsedError;

  /// Serializes this GetOutcomeModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetOutcomeModelResponseCopyWith<GetOutcomeModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetOutcomeModelResponseCopyWith<$Res> {
  factory $GetOutcomeModelResponseCopyWith(GetOutcomeModelResponse value,
          $Res Function(GetOutcomeModelResponse) then) =
      _$GetOutcomeModelResponseCopyWithImpl<$Res, GetOutcomeModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      List<QuestionModel>? data,
      @JsonKey(name: 'ai_mode') String? aiMode,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter});

  $OutcomeSubmitterModelCopyWith<$Res>? get submitter;
}

/// @nodoc
class _$GetOutcomeModelResponseCopyWithImpl<$Res,
        $Val extends GetOutcomeModelResponse>
    implements $GetOutcomeModelResponseCopyWith<$Res> {
  _$GetOutcomeModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? aiMode = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? submitter = freezed,
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
      submitter: freezed == submitter
          ? _value.submitter
          : submitter // ignore: cast_nullable_to_non_nullable
              as OutcomeSubmitterModel?,
    ) as $Val);
  }

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OutcomeSubmitterModelCopyWith<$Res>? get submitter {
    if (_value.submitter == null) {
      return null;
    }

    return $OutcomeSubmitterModelCopyWith<$Res>(_value.submitter!, (value) {
      return _then(_value.copyWith(submitter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetOutcomeModelResponseImplCopyWith<$Res>
    implements $GetOutcomeModelResponseCopyWith<$Res> {
  factory _$$GetOutcomeModelResponseImplCopyWith(
          _$GetOutcomeModelResponseImpl value,
          $Res Function(_$GetOutcomeModelResponseImpl) then) =
      __$$GetOutcomeModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      List<QuestionModel>? data,
      @JsonKey(name: 'ai_mode') String? aiMode,
      @JsonKey(name: 'ai_hint') String? aiHint,
      @JsonKey(name: 'ai_voice_time') int? aiVoiceTime,
      @JsonKey(name: 'Submitter') OutcomeSubmitterModel? submitter});

  @override
  $OutcomeSubmitterModelCopyWith<$Res>? get submitter;
}

/// @nodoc
class __$$GetOutcomeModelResponseImplCopyWithImpl<$Res>
    extends _$GetOutcomeModelResponseCopyWithImpl<$Res,
        _$GetOutcomeModelResponseImpl>
    implements _$$GetOutcomeModelResponseImplCopyWith<$Res> {
  __$$GetOutcomeModelResponseImplCopyWithImpl(
      _$GetOutcomeModelResponseImpl _value,
      $Res Function(_$GetOutcomeModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? aiMode = freezed,
    Object? aiHint = freezed,
    Object? aiVoiceTime = freezed,
    Object? submitter = freezed,
  }) {
    return _then(_$GetOutcomeModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>?,
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
      submitter: freezed == submitter
          ? _value.submitter
          : submitter // ignore: cast_nullable_to_non_nullable
              as OutcomeSubmitterModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetOutcomeModelResponseImpl implements _GetOutcomeModelResponse {
  const _$GetOutcomeModelResponseImpl(
      {this.value,
      final List<QuestionModel>? data,
      @JsonKey(name: 'ai_mode') this.aiMode,
      @JsonKey(name: 'ai_hint') this.aiHint,
      @JsonKey(name: 'ai_voice_time') this.aiVoiceTime,
      @JsonKey(name: 'Submitter') this.submitter})
      : _data = data;

  factory _$GetOutcomeModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetOutcomeModelResponseImplFromJson(json);

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
  @JsonKey(name: 'ai_mode')
  final String? aiMode;
  @override
  @JsonKey(name: 'ai_hint')
  final String? aiHint;
  @override
  @JsonKey(name: 'ai_voice_time')
  final int? aiVoiceTime;
  @override
  @JsonKey(name: 'Submitter')
  final OutcomeSubmitterModel? submitter;

  @override
  String toString() {
    return 'GetOutcomeModelResponse(value: $value, data: $data, aiMode: $aiMode, aiHint: $aiHint, aiVoiceTime: $aiVoiceTime, submitter: $submitter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetOutcomeModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.aiMode, aiMode) || other.aiMode == aiMode) &&
            (identical(other.aiHint, aiHint) || other.aiHint == aiHint) &&
            (identical(other.aiVoiceTime, aiVoiceTime) ||
                other.aiVoiceTime == aiVoiceTime) &&
            (identical(other.submitter, submitter) ||
                other.submitter == submitter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      value,
      const DeepCollectionEquality().hash(_data),
      aiMode,
      aiHint,
      aiVoiceTime,
      submitter);

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetOutcomeModelResponseImplCopyWith<_$GetOutcomeModelResponseImpl>
      get copyWith => __$$GetOutcomeModelResponseImplCopyWithImpl<
          _$GetOutcomeModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetOutcomeModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetOutcomeModelResponse implements GetOutcomeModelResponse {
  const factory _GetOutcomeModelResponse(
          {final bool? value,
          final List<QuestionModel>? data,
          @JsonKey(name: 'ai_mode') final String? aiMode,
          @JsonKey(name: 'ai_hint') final String? aiHint,
          @JsonKey(name: 'ai_voice_time') final int? aiVoiceTime,
          @JsonKey(name: 'Submitter') final OutcomeSubmitterModel? submitter}) =
      _$GetOutcomeModelResponseImpl;

  factory _GetOutcomeModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetOutcomeModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<QuestionModel>? get data;
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
  @JsonKey(name: 'Submitter')
  OutcomeSubmitterModel? get submitter;

  /// Create a copy of GetOutcomeModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetOutcomeModelResponseImplCopyWith<_$GetOutcomeModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OutcomeSubmitterModel _$OutcomeSubmitterModelFromJson(
    Map<String, dynamic> json) {
  return _OutcomeSubmitterModel.fromJson(json);
}

/// @nodoc
mixin _$OutcomeSubmitterModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this OutcomeSubmitterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OutcomeSubmitterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OutcomeSubmitterModelCopyWith<OutcomeSubmitterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutcomeSubmitterModelCopyWith<$Res> {
  factory $OutcomeSubmitterModelCopyWith(OutcomeSubmitterModel value,
          $Res Function(OutcomeSubmitterModel) then) =
      _$OutcomeSubmitterModelCopyWithImpl<$Res, OutcomeSubmitterModel>;
  @useResult
  $Res call({String? id, String? name, String? image});
}

/// @nodoc
class _$OutcomeSubmitterModelCopyWithImpl<$Res,
        $Val extends OutcomeSubmitterModel>
    implements $OutcomeSubmitterModelCopyWith<$Res> {
  _$OutcomeSubmitterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OutcomeSubmitterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OutcomeSubmitterModelImplCopyWith<$Res>
    implements $OutcomeSubmitterModelCopyWith<$Res> {
  factory _$$OutcomeSubmitterModelImplCopyWith(
          _$OutcomeSubmitterModelImpl value,
          $Res Function(_$OutcomeSubmitterModelImpl) then) =
      __$$OutcomeSubmitterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, String? image});
}

/// @nodoc
class __$$OutcomeSubmitterModelImplCopyWithImpl<$Res>
    extends _$OutcomeSubmitterModelCopyWithImpl<$Res,
        _$OutcomeSubmitterModelImpl>
    implements _$$OutcomeSubmitterModelImplCopyWith<$Res> {
  __$$OutcomeSubmitterModelImplCopyWithImpl(_$OutcomeSubmitterModelImpl _value,
      $Res Function(_$OutcomeSubmitterModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OutcomeSubmitterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
  }) {
    return _then(_$OutcomeSubmitterModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OutcomeSubmitterModelImpl implements _OutcomeSubmitterModel {
  const _$OutcomeSubmitterModelImpl({this.id, this.name, this.image});

  factory _$OutcomeSubmitterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OutcomeSubmitterModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? image;

  @override
  String toString() {
    return 'OutcomeSubmitterModel(id: $id, name: $name, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OutcomeSubmitterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, image);

  /// Create a copy of OutcomeSubmitterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OutcomeSubmitterModelImplCopyWith<_$OutcomeSubmitterModelImpl>
      get copyWith => __$$OutcomeSubmitterModelImplCopyWithImpl<
          _$OutcomeSubmitterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OutcomeSubmitterModelImplToJson(
      this,
    );
  }
}

abstract class _OutcomeSubmitterModel implements OutcomeSubmitterModel {
  const factory _OutcomeSubmitterModel(
      {final String? id,
      final String? name,
      final String? image}) = _$OutcomeSubmitterModelImpl;

  factory _OutcomeSubmitterModel.fromJson(Map<String, dynamic> json) =
      _$OutcomeSubmitterModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get image;

  /// Create a copy of OutcomeSubmitterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OutcomeSubmitterModelImplCopyWith<_$OutcomeSubmitterModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
