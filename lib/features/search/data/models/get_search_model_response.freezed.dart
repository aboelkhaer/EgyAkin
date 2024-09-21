// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_search_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetSearchModelResponse _$GetSearchModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetSearchModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetSearchModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  GetSearchDataModelResponse? get data => throw _privateConstructorUsedError;

  /// Serializes this GetSearchModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetSearchModelResponseCopyWith<GetSearchModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSearchModelResponseCopyWith<$Res> {
  factory $GetSearchModelResponseCopyWith(GetSearchModelResponse value,
          $Res Function(GetSearchModelResponse) then) =
      _$GetSearchModelResponseCopyWithImpl<$Res, GetSearchModelResponse>;
  @useResult
  $Res call({bool? value, GetSearchDataModelResponse? data});

  $GetSearchDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetSearchModelResponseCopyWithImpl<$Res,
        $Val extends GetSearchModelResponse>
    implements $GetSearchModelResponseCopyWith<$Res> {
  _$GetSearchModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetSearchModelResponse
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
              as GetSearchDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetSearchDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetSearchDataModelResponseCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetSearchModelResponseImplCopyWith<$Res>
    implements $GetSearchModelResponseCopyWith<$Res> {
  factory _$$GetSearchModelResponseImplCopyWith(
          _$GetSearchModelResponseImpl value,
          $Res Function(_$GetSearchModelResponseImpl) then) =
      __$$GetSearchModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, GetSearchDataModelResponse? data});

  @override
  $GetSearchDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetSearchModelResponseImplCopyWithImpl<$Res>
    extends _$GetSearchModelResponseCopyWithImpl<$Res,
        _$GetSearchModelResponseImpl>
    implements _$$GetSearchModelResponseImplCopyWith<$Res> {
  __$$GetSearchModelResponseImplCopyWithImpl(
      _$GetSearchModelResponseImpl _value,
      $Res Function(_$GetSearchModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetSearchModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetSearchDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetSearchModelResponseImpl implements _GetSearchModelResponse {
  const _$GetSearchModelResponseImpl({this.value, this.data});

  factory _$GetSearchModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetSearchModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final GetSearchDataModelResponse? data;

  @override
  String toString() {
    return 'GetSearchModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, data);

  /// Create a copy of GetSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSearchModelResponseImplCopyWith<_$GetSearchModelResponseImpl>
      get copyWith => __$$GetSearchModelResponseImplCopyWithImpl<
          _$GetSearchModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetSearchModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetSearchModelResponse implements GetSearchModelResponse {
  const factory _GetSearchModelResponse(
      {final bool? value,
      final GetSearchDataModelResponse? data}) = _$GetSearchModelResponseImpl;

  factory _GetSearchModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetSearchModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  GetSearchDataModelResponse? get data;

  /// Create a copy of GetSearchModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetSearchModelResponseImplCopyWith<_$GetSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetSearchDataModelResponse _$GetSearchDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetSearchDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetSearchDataModelResponse {
  List<PatientHomeDataModel>? get patients =>
      throw _privateConstructorUsedError;
  List<SearchDataForDosesModelResponse>? get doses =>
      throw _privateConstructorUsedError;

  /// Serializes this GetSearchDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetSearchDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetSearchDataModelResponseCopyWith<GetSearchDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSearchDataModelResponseCopyWith<$Res> {
  factory $GetSearchDataModelResponseCopyWith(GetSearchDataModelResponse value,
          $Res Function(GetSearchDataModelResponse) then) =
      _$GetSearchDataModelResponseCopyWithImpl<$Res,
          GetSearchDataModelResponse>;
  @useResult
  $Res call(
      {List<PatientHomeDataModel>? patients,
      List<SearchDataForDosesModelResponse>? doses});
}

/// @nodoc
class _$GetSearchDataModelResponseCopyWithImpl<$Res,
        $Val extends GetSearchDataModelResponse>
    implements $GetSearchDataModelResponseCopyWith<$Res> {
  _$GetSearchDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetSearchDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patients = freezed,
    Object? doses = freezed,
  }) {
    return _then(_value.copyWith(
      patients: freezed == patients
          ? _value.patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      doses: freezed == doses
          ? _value.doses
          : doses // ignore: cast_nullable_to_non_nullable
              as List<SearchDataForDosesModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetSearchDataModelResponseImplCopyWith<$Res>
    implements $GetSearchDataModelResponseCopyWith<$Res> {
  factory _$$GetSearchDataModelResponseImplCopyWith(
          _$GetSearchDataModelResponseImpl value,
          $Res Function(_$GetSearchDataModelResponseImpl) then) =
      __$$GetSearchDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PatientHomeDataModel>? patients,
      List<SearchDataForDosesModelResponse>? doses});
}

/// @nodoc
class __$$GetSearchDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetSearchDataModelResponseCopyWithImpl<$Res,
        _$GetSearchDataModelResponseImpl>
    implements _$$GetSearchDataModelResponseImplCopyWith<$Res> {
  __$$GetSearchDataModelResponseImplCopyWithImpl(
      _$GetSearchDataModelResponseImpl _value,
      $Res Function(_$GetSearchDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetSearchDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patients = freezed,
    Object? doses = freezed,
  }) {
    return _then(_$GetSearchDataModelResponseImpl(
      patients: freezed == patients
          ? _value._patients
          : patients // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      doses: freezed == doses
          ? _value._doses
          : doses // ignore: cast_nullable_to_non_nullable
              as List<SearchDataForDosesModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetSearchDataModelResponseImpl implements _GetSearchDataModelResponse {
  const _$GetSearchDataModelResponseImpl(
      {final List<PatientHomeDataModel>? patients,
      final List<SearchDataForDosesModelResponse>? doses})
      : _patients = patients,
        _doses = doses;

  factory _$GetSearchDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetSearchDataModelResponseImplFromJson(json);

  final List<PatientHomeDataModel>? _patients;
  @override
  List<PatientHomeDataModel>? get patients {
    final value = _patients;
    if (value == null) return null;
    if (_patients is EqualUnmodifiableListView) return _patients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SearchDataForDosesModelResponse>? _doses;
  @override
  List<SearchDataForDosesModelResponse>? get doses {
    final value = _doses;
    if (value == null) return null;
    if (_doses is EqualUnmodifiableListView) return _doses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetSearchDataModelResponse(patients: $patients, doses: $doses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSearchDataModelResponseImpl &&
            const DeepCollectionEquality().equals(other._patients, _patients) &&
            const DeepCollectionEquality().equals(other._doses, _doses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_patients),
      const DeepCollectionEquality().hash(_doses));

  /// Create a copy of GetSearchDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSearchDataModelResponseImplCopyWith<_$GetSearchDataModelResponseImpl>
      get copyWith => __$$GetSearchDataModelResponseImplCopyWithImpl<
          _$GetSearchDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetSearchDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetSearchDataModelResponse
    implements GetSearchDataModelResponse {
  const factory _GetSearchDataModelResponse(
          {final List<PatientHomeDataModel>? patients,
          final List<SearchDataForDosesModelResponse>? doses}) =
      _$GetSearchDataModelResponseImpl;

  factory _GetSearchDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetSearchDataModelResponseImpl.fromJson;

  @override
  List<PatientHomeDataModel>? get patients;
  @override
  List<SearchDataForDosesModelResponse>? get doses;

  /// Create a copy of GetSearchDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetSearchDataModelResponseImplCopyWith<_$GetSearchDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SearchDataForDosesModelResponse _$SearchDataForDosesModelResponseFromJson(
    Map<String, dynamic> json) {
  return _SearchDataForDosesModelResponse.fromJson(json);
}

/// @nodoc
mixin _$SearchDataForDosesModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get dose => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SearchDataForDosesModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SearchDataForDosesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchDataForDosesModelResponseCopyWith<SearchDataForDosesModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchDataForDosesModelResponseCopyWith<$Res> {
  factory $SearchDataForDosesModelResponseCopyWith(
          SearchDataForDosesModelResponse value,
          $Res Function(SearchDataForDosesModelResponse) then) =
      _$SearchDataForDosesModelResponseCopyWithImpl<$Res,
          SearchDataForDosesModelResponse>;
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? dose,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class _$SearchDataForDosesModelResponseCopyWithImpl<$Res,
        $Val extends SearchDataForDosesModelResponse>
    implements $SearchDataForDosesModelResponseCopyWith<$Res> {
  _$SearchDataForDosesModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchDataForDosesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dose = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchDataForDosesModelResponseImplCopyWith<$Res>
    implements $SearchDataForDosesModelResponseCopyWith<$Res> {
  factory _$$SearchDataForDosesModelResponseImplCopyWith(
          _$SearchDataForDosesModelResponseImpl value,
          $Res Function(_$SearchDataForDosesModelResponseImpl) then) =
      __$$SearchDataForDosesModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? title,
      String? description,
      String? dose,
      @JsonKey(name: 'created_at') String? createdAt});
}

/// @nodoc
class __$$SearchDataForDosesModelResponseImplCopyWithImpl<$Res>
    extends _$SearchDataForDosesModelResponseCopyWithImpl<$Res,
        _$SearchDataForDosesModelResponseImpl>
    implements _$$SearchDataForDosesModelResponseImplCopyWith<$Res> {
  __$$SearchDataForDosesModelResponseImplCopyWithImpl(
      _$SearchDataForDosesModelResponseImpl _value,
      $Res Function(_$SearchDataForDosesModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchDataForDosesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dose = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$SearchDataForDosesModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dose: freezed == dose
          ? _value.dose
          : dose // ignore: cast_nullable_to_non_nullable
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
class _$SearchDataForDosesModelResponseImpl
    implements _SearchDataForDosesModelResponse {
  const _$SearchDataForDosesModelResponseImpl(
      {this.id,
      this.title,
      this.description,
      this.dose,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$SearchDataForDosesModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SearchDataForDosesModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? dose;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  String toString() {
    return 'SearchDataForDosesModelResponse(id: $id, title: $title, description: $description, dose: $dose, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchDataForDosesModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dose, dose) || other.dose == dose) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, dose, createdAt);

  /// Create a copy of SearchDataForDosesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchDataForDosesModelResponseImplCopyWith<
          _$SearchDataForDosesModelResponseImpl>
      get copyWith => __$$SearchDataForDosesModelResponseImplCopyWithImpl<
          _$SearchDataForDosesModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchDataForDosesModelResponseImplToJson(
      this,
    );
  }
}

abstract class _SearchDataForDosesModelResponse
    implements SearchDataForDosesModelResponse {
  const factory _SearchDataForDosesModelResponse(
          {final int? id,
          final String? title,
          final String? description,
          final String? dose,
          @JsonKey(name: 'created_at') final String? createdAt}) =
      _$SearchDataForDosesModelResponseImpl;

  factory _SearchDataForDosesModelResponse.fromJson(Map<String, dynamic> json) =
      _$SearchDataForDosesModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get dose;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;

  /// Create a copy of SearchDataForDosesModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchDataForDosesModelResponseImplCopyWith<
          _$SearchDataForDosesModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
