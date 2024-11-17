// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_ai_consultation_history_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAiConsultationHistoryModelResponse
    _$GetAiConsultationHistoryModelResponseFromJson(Map<String, dynamic> json) {
  return _GetAiConsultationHistoryModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAiConsultationHistoryModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'trial_count')
  int? get trialCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reset_date')
  String? get resetDate => throw _privateConstructorUsedError;
  ConsultationHistory? get history => throw _privateConstructorUsedError;

  /// Serializes this GetAiConsultationHistoryModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAiConsultationHistoryModelResponseCopyWith<
          GetAiConsultationHistoryModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAiConsultationHistoryModelResponseCopyWith<$Res> {
  factory $GetAiConsultationHistoryModelResponseCopyWith(
          GetAiConsultationHistoryModelResponse value,
          $Res Function(GetAiConsultationHistoryModelResponse) then) =
      _$GetAiConsultationHistoryModelResponseCopyWithImpl<$Res,
          GetAiConsultationHistoryModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      String? message,
      @JsonKey(name: 'trial_count') int? trialCount,
      @JsonKey(name: 'reset_date') String? resetDate,
      ConsultationHistory? history});

  $ConsultationHistoryCopyWith<$Res>? get history;
}

/// @nodoc
class _$GetAiConsultationHistoryModelResponseCopyWithImpl<$Res,
        $Val extends GetAiConsultationHistoryModelResponse>
    implements $GetAiConsultationHistoryModelResponseCopyWith<$Res> {
  _$GetAiConsultationHistoryModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? trialCount = freezed,
    Object? resetDate = freezed,
    Object? history = freezed,
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
      trialCount: freezed == trialCount
          ? _value.trialCount
          : trialCount // ignore: cast_nullable_to_non_nullable
              as int?,
      resetDate: freezed == resetDate
          ? _value.resetDate
          : resetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as ConsultationHistory?,
    ) as $Val);
  }

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConsultationHistoryCopyWith<$Res>? get history {
    if (_value.history == null) {
      return null;
    }

    return $ConsultationHistoryCopyWith<$Res>(_value.history!, (value) {
      return _then(_value.copyWith(history: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAiConsultationHistoryModelResponseImplCopyWith<$Res>
    implements $GetAiConsultationHistoryModelResponseCopyWith<$Res> {
  factory _$$GetAiConsultationHistoryModelResponseImplCopyWith(
          _$GetAiConsultationHistoryModelResponseImpl value,
          $Res Function(_$GetAiConsultationHistoryModelResponseImpl) then) =
      __$$GetAiConsultationHistoryModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      String? message,
      @JsonKey(name: 'trial_count') int? trialCount,
      @JsonKey(name: 'reset_date') String? resetDate,
      ConsultationHistory? history});

  @override
  $ConsultationHistoryCopyWith<$Res>? get history;
}

/// @nodoc
class __$$GetAiConsultationHistoryModelResponseImplCopyWithImpl<$Res>
    extends _$GetAiConsultationHistoryModelResponseCopyWithImpl<$Res,
        _$GetAiConsultationHistoryModelResponseImpl>
    implements _$$GetAiConsultationHistoryModelResponseImplCopyWith<$Res> {
  __$$GetAiConsultationHistoryModelResponseImplCopyWithImpl(
      _$GetAiConsultationHistoryModelResponseImpl _value,
      $Res Function(_$GetAiConsultationHistoryModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? message = freezed,
    Object? trialCount = freezed,
    Object? resetDate = freezed,
    Object? history = freezed,
  }) {
    return _then(_$GetAiConsultationHistoryModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      trialCount: freezed == trialCount
          ? _value.trialCount
          : trialCount // ignore: cast_nullable_to_non_nullable
              as int?,
      resetDate: freezed == resetDate
          ? _value.resetDate
          : resetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as ConsultationHistory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAiConsultationHistoryModelResponseImpl
    implements _GetAiConsultationHistoryModelResponse {
  const _$GetAiConsultationHistoryModelResponseImpl(
      {this.value,
      this.message,
      @JsonKey(name: 'trial_count') this.trialCount,
      @JsonKey(name: 'reset_date') this.resetDate,
      this.history});

  factory _$GetAiConsultationHistoryModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAiConsultationHistoryModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? message;
  @override
  @JsonKey(name: 'trial_count')
  final int? trialCount;
  @override
  @JsonKey(name: 'reset_date')
  final String? resetDate;
  @override
  final ConsultationHistory? history;

  @override
  String toString() {
    return 'GetAiConsultationHistoryModelResponse(value: $value, message: $message, trialCount: $trialCount, resetDate: $resetDate, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAiConsultationHistoryModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.trialCount, trialCount) ||
                other.trialCount == trialCount) &&
            (identical(other.resetDate, resetDate) ||
                other.resetDate == resetDate) &&
            (identical(other.history, history) || other.history == history));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, value, message, trialCount, resetDate, history);

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAiConsultationHistoryModelResponseImplCopyWith<
          _$GetAiConsultationHistoryModelResponseImpl>
      get copyWith => __$$GetAiConsultationHistoryModelResponseImplCopyWithImpl<
          _$GetAiConsultationHistoryModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAiConsultationHistoryModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAiConsultationHistoryModelResponse
    implements GetAiConsultationHistoryModelResponse {
  const factory _GetAiConsultationHistoryModelResponse(
          {final bool? value,
          final String? message,
          @JsonKey(name: 'trial_count') final int? trialCount,
          @JsonKey(name: 'reset_date') final String? resetDate,
          final ConsultationHistory? history}) =
      _$GetAiConsultationHistoryModelResponseImpl;

  factory _GetAiConsultationHistoryModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAiConsultationHistoryModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get message;
  @override
  @JsonKey(name: 'trial_count')
  int? get trialCount;
  @override
  @JsonKey(name: 'reset_date')
  String? get resetDate;
  @override
  ConsultationHistory? get history;

  /// Create a copy of GetAiConsultationHistoryModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAiConsultationHistoryModelResponseImplCopyWith<
          _$GetAiConsultationHistoryModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ConsultationHistory _$ConsultationHistoryFromJson(Map<String, dynamic> json) {
  return _ConsultationHistory.fromJson(json);
}

/// @nodoc
mixin _$ConsultationHistory {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  List<ConsultationData>? get data => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int? get lastPage => throw _privateConstructorUsedError;

  /// Serializes this ConsultationHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultationHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultationHistoryCopyWith<ConsultationHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultationHistoryCopyWith<$Res> {
  factory $ConsultationHistoryCopyWith(
          ConsultationHistory value, $Res Function(ConsultationHistory) then) =
      _$ConsultationHistoryCopyWithImpl<$Res, ConsultationHistory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<ConsultationData>? data,
      int? total,
      @JsonKey(name: 'last_page') int? lastPage});
}

/// @nodoc
class _$ConsultationHistoryCopyWithImpl<$Res, $Val extends ConsultationHistory>
    implements $ConsultationHistoryCopyWith<$Res> {
  _$ConsultationHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultationHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? data = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ConsultationData>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsultationHistoryImplCopyWith<$Res>
    implements $ConsultationHistoryCopyWith<$Res> {
  factory _$$ConsultationHistoryImplCopyWith(_$ConsultationHistoryImpl value,
          $Res Function(_$ConsultationHistoryImpl) then) =
      __$$ConsultationHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<ConsultationData>? data,
      int? total,
      @JsonKey(name: 'last_page') int? lastPage});
}

/// @nodoc
class __$$ConsultationHistoryImplCopyWithImpl<$Res>
    extends _$ConsultationHistoryCopyWithImpl<$Res, _$ConsultationHistoryImpl>
    implements _$$ConsultationHistoryImplCopyWith<$Res> {
  __$$ConsultationHistoryImplCopyWithImpl(_$ConsultationHistoryImpl _value,
      $Res Function(_$ConsultationHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConsultationHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? data = freezed,
    Object? total = freezed,
    Object? lastPage = freezed,
  }) {
    return _then(_$ConsultationHistoryImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ConsultationData>?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultationHistoryImpl implements _ConsultationHistory {
  const _$ConsultationHistoryImpl(
      {@JsonKey(name: 'current_page') this.currentPage,
      final List<ConsultationData>? data,
      this.total,
      @JsonKey(name: 'last_page') this.lastPage})
      : _data = data;

  factory _$ConsultationHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultationHistoryImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<ConsultationData>? _data;
  @override
  List<ConsultationData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? total;
  @override
  @JsonKey(name: 'last_page')
  final int? lastPage;

  @override
  String toString() {
    return 'ConsultationHistory(currentPage: $currentPage, data: $data, total: $total, lastPage: $lastPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultationHistoryImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentPage,
      const DeepCollectionEquality().hash(_data), total, lastPage);

  /// Create a copy of ConsultationHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultationHistoryImplCopyWith<_$ConsultationHistoryImpl> get copyWith =>
      __$$ConsultationHistoryImplCopyWithImpl<_$ConsultationHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultationHistoryImplToJson(
      this,
    );
  }
}

abstract class _ConsultationHistory implements ConsultationHistory {
  const factory _ConsultationHistory(
          {@JsonKey(name: 'current_page') final int? currentPage,
          final List<ConsultationData>? data,
          final int? total,
          @JsonKey(name: 'last_page') final int? lastPage}) =
      _$ConsultationHistoryImpl;

  factory _ConsultationHistory.fromJson(Map<String, dynamic> json) =
      _$ConsultationHistoryImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  List<ConsultationData>? get data;
  @override
  int? get total;
  @override
  @JsonKey(name: 'last_page')
  int? get lastPage;

  /// Create a copy of ConsultationHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultationHistoryImplCopyWith<_$ConsultationHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConsultationData _$ConsultationDataFromJson(Map<String, dynamic> json) {
  return _ConsultationData.fromJson(json);
}

/// @nodoc
mixin _$ConsultationData {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  int? get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  int? get patientId => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  String? get response => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ConsultationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConsultationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsultationDataCopyWith<ConsultationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsultationDataCopyWith<$Res> {
  factory $ConsultationDataCopyWith(
          ConsultationData value, $Res Function(ConsultationData) then) =
      _$ConsultationDataCopyWithImpl<$Res, ConsultationData>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') int? doctorId,
      @JsonKey(name: 'patient_id') int? patientId,
      String? question,
      String? response,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class _$ConsultationDataCopyWithImpl<$Res, $Val extends ConsultationData>
    implements $ConsultationDataCopyWith<$Res> {
  _$ConsultationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConsultationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? patientId = freezed,
    Object? question = freezed,
    Object? response = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsultationDataImplCopyWith<$Res>
    implements $ConsultationDataCopyWith<$Res> {
  factory _$$ConsultationDataImplCopyWith(_$ConsultationDataImpl value,
          $Res Function(_$ConsultationDataImpl) then) =
      __$$ConsultationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'doctor_id') int? doctorId,
      @JsonKey(name: 'patient_id') int? patientId,
      String? question,
      String? response,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class __$$ConsultationDataImplCopyWithImpl<$Res>
    extends _$ConsultationDataCopyWithImpl<$Res, _$ConsultationDataImpl>
    implements _$$ConsultationDataImplCopyWith<$Res> {
  __$$ConsultationDataImplCopyWithImpl(_$ConsultationDataImpl _value,
      $Res Function(_$ConsultationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConsultationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? doctorId = freezed,
    Object? patientId = freezed,
    Object? question = freezed,
    Object? response = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ConsultationDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsultationDataImpl implements _ConsultationData {
  const _$ConsultationDataImpl(
      {this.id,
      @JsonKey(name: 'doctor_id') this.doctorId,
      @JsonKey(name: 'patient_id') this.patientId,
      this.question,
      this.response,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$ConsultationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsultationDataImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'doctor_id')
  final int? doctorId;
  @override
  @JsonKey(name: 'patient_id')
  final int? patientId;
  @override
  final String? question;
  @override
  final String? response;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'ConsultationData(id: $id, doctorId: $doctorId, patientId: $patientId, question: $question, response: $response, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsultationDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, doctorId, patientId, question, response, createdAt);

  /// Create a copy of ConsultationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsultationDataImplCopyWith<_$ConsultationDataImpl> get copyWith =>
      __$$ConsultationDataImplCopyWithImpl<_$ConsultationDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsultationDataImplToJson(
      this,
    );
  }
}

abstract class _ConsultationData implements ConsultationData {
  const factory _ConsultationData(
          {final int? id,
          @JsonKey(name: 'doctor_id') final int? doctorId,
          @JsonKey(name: 'patient_id') final int? patientId,
          final String? question,
          final String? response,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$ConsultationDataImpl;

  factory _ConsultationData.fromJson(Map<String, dynamic> json) =
      _$ConsultationDataImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'doctor_id')
  int? get doctorId;
  @override
  @JsonKey(name: 'patient_id')
  int? get patientId;
  @override
  String? get question;
  @override
  String? get response;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of ConsultationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsultationDataImplCopyWith<_$ConsultationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
