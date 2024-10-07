// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_doctors_patients_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAllDoctorsPatientsModelResponse _$GetAllDoctorsPatientsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllDoctorsPatientsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllDoctorsPatientsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  @JsonKey(name: 'filter')
  List<GetFiltersOptionsDataModelResponse>? get filters =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value')
  String? get scoreValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_count')
  String? get patientCount => throw _privateConstructorUsedError;
  GetAllDoctorsPatientDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetAllDoctorsPatientsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllDoctorsPatientsModelResponseCopyWith<
          GetAllDoctorsPatientsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllDoctorsPatientsModelResponseCopyWith<$Res> {
  factory $GetAllDoctorsPatientsModelResponseCopyWith(
          GetAllDoctorsPatientsModelResponse value,
          $Res Function(GetAllDoctorsPatientsModelResponse) then) =
      _$GetAllDoctorsPatientsModelResponseCopyWithImpl<$Res,
          GetAllDoctorsPatientsModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(name: 'filter')
      List<GetFiltersOptionsDataModelResponse>? filters,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'patient_count') String? patientCount,
      GetAllDoctorsPatientDataModelResponse? data});

  $GetAllDoctorsPatientDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetAllDoctorsPatientsModelResponseCopyWithImpl<$Res,
        $Val extends GetAllDoctorsPatientsModelResponse>
    implements $GetAllDoctorsPatientsModelResponseCopyWith<$Res> {
  _$GetAllDoctorsPatientsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? filters = freezed,
    Object? scoreValue = freezed,
    Object? patientCount = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetAllDoctorsPatientDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetAllDoctorsPatientDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetAllDoctorsPatientDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAllDoctorsPatientsModelResponseImplCopyWith<$Res>
    implements $GetAllDoctorsPatientsModelResponseCopyWith<$Res> {
  factory _$$GetAllDoctorsPatientsModelResponseImplCopyWith(
          _$GetAllDoctorsPatientsModelResponseImpl value,
          $Res Function(_$GetAllDoctorsPatientsModelResponseImpl) then) =
      __$$GetAllDoctorsPatientsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(name: 'filter')
      List<GetFiltersOptionsDataModelResponse>? filters,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'patient_count') String? patientCount,
      GetAllDoctorsPatientDataModelResponse? data});

  @override
  $GetAllDoctorsPatientDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetAllDoctorsPatientsModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllDoctorsPatientsModelResponseCopyWithImpl<$Res,
        _$GetAllDoctorsPatientsModelResponseImpl>
    implements _$$GetAllDoctorsPatientsModelResponseImplCopyWith<$Res> {
  __$$GetAllDoctorsPatientsModelResponseImplCopyWithImpl(
      _$GetAllDoctorsPatientsModelResponseImpl _value,
      $Res Function(_$GetAllDoctorsPatientsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? filters = freezed,
    Object? scoreValue = freezed,
    Object? patientCount = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetAllDoctorsPatientsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetAllDoctorsPatientDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllDoctorsPatientsModelResponseImpl
    implements _GetAllDoctorsPatientsModelResponse {
  const _$GetAllDoctorsPatientsModelResponseImpl(
      {this.value,
      this.verified,
      @JsonKey(name: 'filter')
      final List<GetFiltersOptionsDataModelResponse>? filters,
      @JsonKey(name: 'score_value') this.scoreValue,
      @JsonKey(name: 'patient_count') this.patientCount,
      this.data})
      : _filters = filters;

  factory _$GetAllDoctorsPatientsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllDoctorsPatientsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final bool? verified;
  final List<GetFiltersOptionsDataModelResponse>? _filters;
  @override
  @JsonKey(name: 'filter')
  List<GetFiltersOptionsDataModelResponse>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'score_value')
  final String? scoreValue;
  @override
  @JsonKey(name: 'patient_count')
  final String? patientCount;
  @override
  final GetAllDoctorsPatientDataModelResponse? data;

  @override
  String toString() {
    return 'GetAllDoctorsPatientsModelResponse(value: $value, verified: $verified, filters: $filters, scoreValue: $scoreValue, patientCount: $patientCount, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllDoctorsPatientsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.scoreValue, scoreValue) ||
                other.scoreValue == scoreValue) &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      value,
      verified,
      const DeepCollectionEquality().hash(_filters),
      scoreValue,
      patientCount,
      data);

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllDoctorsPatientsModelResponseImplCopyWith<
          _$GetAllDoctorsPatientsModelResponseImpl>
      get copyWith => __$$GetAllDoctorsPatientsModelResponseImplCopyWithImpl<
          _$GetAllDoctorsPatientsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllDoctorsPatientsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllDoctorsPatientsModelResponse
    implements GetAllDoctorsPatientsModelResponse {
  const factory _GetAllDoctorsPatientsModelResponse(
          {final bool? value,
          final bool? verified,
          @JsonKey(name: 'filter')
          final List<GetFiltersOptionsDataModelResponse>? filters,
          @JsonKey(name: 'score_value') final String? scoreValue,
          @JsonKey(name: 'patient_count') final String? patientCount,
          final GetAllDoctorsPatientDataModelResponse? data}) =
      _$GetAllDoctorsPatientsModelResponseImpl;

  factory _GetAllDoctorsPatientsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllDoctorsPatientsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  bool? get verified;
  @override
  @JsonKey(name: 'filter')
  List<GetFiltersOptionsDataModelResponse>? get filters;
  @override
  @JsonKey(name: 'score_value')
  String? get scoreValue;
  @override
  @JsonKey(name: 'patient_count')
  String? get patientCount;
  @override
  GetAllDoctorsPatientDataModelResponse? get data;

  /// Create a copy of GetAllDoctorsPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllDoctorsPatientsModelResponseImplCopyWith<
          _$GetAllDoctorsPatientsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetAllDoctorsPatientDataModelResponse
    _$GetAllDoctorsPatientDataModelResponseFromJson(Map<String, dynamic> json) {
  return _GetAllDoctorsPatientDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllDoctorsPatientDataModelResponse {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  List<PatientHomeDataModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_page_url')
  String? get firstPageUrl => throw _privateConstructorUsedError;
  int? get from => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int? get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page_url')
  String? get lastPageUrl => throw _privateConstructorUsedError;
  List<Link>? get links => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this GetAllDoctorsPatientDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllDoctorsPatientDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllDoctorsPatientDataModelResponseCopyWith<
          GetAllDoctorsPatientDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllDoctorsPatientDataModelResponseCopyWith<$Res> {
  factory $GetAllDoctorsPatientDataModelResponseCopyWith(
          GetAllDoctorsPatientDataModelResponse value,
          $Res Function(GetAllDoctorsPatientDataModelResponse) then) =
      _$GetAllDoctorsPatientDataModelResponseCopyWithImpl<$Res,
          GetAllDoctorsPatientDataModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<PatientHomeDataModel>? data,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      List<Link>? links,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class _$GetAllDoctorsPatientDataModelResponseCopyWithImpl<$Res,
        $Val extends GetAllDoctorsPatientDataModelResponse>
    implements $GetAllDoctorsPatientDataModelResponseCopyWith<$Res> {
  _$GetAllDoctorsPatientDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllDoctorsPatientDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? data = freezed,
    Object? firstPageUrl = freezed,
    Object? from = freezed,
    Object? lastPage = freezed,
    Object? lastPageUrl = freezed,
    Object? links = freezed,
    Object? nextPageUrl = freezed,
    Object? path = freezed,
    Object? perPage = freezed,
    Object? prevPageUrl = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      firstPageUrl: freezed == firstPageUrl
          ? _value.firstPageUrl
          : firstPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPageUrl: freezed == lastPageUrl
          ? _value.lastPageUrl
          : lastPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAllDoctorsPatientDataModelResponseImplCopyWith<$Res>
    implements $GetAllDoctorsPatientDataModelResponseCopyWith<$Res> {
  factory _$$GetAllDoctorsPatientDataModelResponseImplCopyWith(
          _$GetAllDoctorsPatientDataModelResponseImpl value,
          $Res Function(_$GetAllDoctorsPatientDataModelResponseImpl) then) =
      __$$GetAllDoctorsPatientDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<PatientHomeDataModel>? data,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      List<Link>? links,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class __$$GetAllDoctorsPatientDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllDoctorsPatientDataModelResponseCopyWithImpl<$Res,
        _$GetAllDoctorsPatientDataModelResponseImpl>
    implements _$$GetAllDoctorsPatientDataModelResponseImplCopyWith<$Res> {
  __$$GetAllDoctorsPatientDataModelResponseImplCopyWithImpl(
      _$GetAllDoctorsPatientDataModelResponseImpl _value,
      $Res Function(_$GetAllDoctorsPatientDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllDoctorsPatientDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = freezed,
    Object? data = freezed,
    Object? firstPageUrl = freezed,
    Object? from = freezed,
    Object? lastPage = freezed,
    Object? lastPageUrl = freezed,
    Object? links = freezed,
    Object? nextPageUrl = freezed,
    Object? path = freezed,
    Object? perPage = freezed,
    Object? prevPageUrl = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_$GetAllDoctorsPatientDataModelResponseImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      firstPageUrl: freezed == firstPageUrl
          ? _value.firstPageUrl
          : firstPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as int?,
      lastPageUrl: freezed == lastPageUrl
          ? _value.lastPageUrl
          : lastPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Link>?,
      nextPageUrl: freezed == nextPageUrl
          ? _value.nextPageUrl
          : nextPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      prevPageUrl: freezed == prevPageUrl
          ? _value.prevPageUrl
          : prevPageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllDoctorsPatientDataModelResponseImpl
    implements _GetAllDoctorsPatientDataModelResponse {
  const _$GetAllDoctorsPatientDataModelResponseImpl(
      {@JsonKey(name: 'current_page') this.currentPage,
      final List<PatientHomeDataModel>? data,
      @JsonKey(name: 'first_page_url') this.firstPageUrl,
      this.from,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'last_page_url') this.lastPageUrl,
      final List<Link>? links,
      @JsonKey(name: 'next_page_url') this.nextPageUrl,
      this.path,
      this.perPage,
      @JsonKey(name: 'prev_page_url') this.prevPageUrl,
      this.to,
      this.total})
      : _data = data,
        _links = links;

  factory _$GetAllDoctorsPatientDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllDoctorsPatientDataModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<PatientHomeDataModel>? _data;
  @override
  List<PatientHomeDataModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;
  @override
  final int? from;
  @override
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @override
  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;
  final List<Link>? _links;
  @override
  List<Link>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;
  @override
  final String? path;
  @override
  final int? perPage;
  @override
  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;
  @override
  final int? to;
  @override
  final int? total;

  @override
  String toString() {
    return 'GetAllDoctorsPatientDataModelResponse(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllDoctorsPatientDataModelResponseImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.firstPageUrl, firstPageUrl) ||
                other.firstPageUrl == firstPageUrl) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.lastPageUrl, lastPageUrl) ||
                other.lastPageUrl == lastPageUrl) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                other.nextPageUrl == nextPageUrl) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                other.prevPageUrl == prevPageUrl) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPage,
      const DeepCollectionEquality().hash(_data),
      firstPageUrl,
      from,
      lastPage,
      lastPageUrl,
      const DeepCollectionEquality().hash(_links),
      nextPageUrl,
      path,
      perPage,
      prevPageUrl,
      to,
      total);

  /// Create a copy of GetAllDoctorsPatientDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllDoctorsPatientDataModelResponseImplCopyWith<
          _$GetAllDoctorsPatientDataModelResponseImpl>
      get copyWith => __$$GetAllDoctorsPatientDataModelResponseImplCopyWithImpl<
          _$GetAllDoctorsPatientDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllDoctorsPatientDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllDoctorsPatientDataModelResponse
    implements GetAllDoctorsPatientDataModelResponse {
  const factory _GetAllDoctorsPatientDataModelResponse(
      {@JsonKey(name: 'current_page') final int? currentPage,
      final List<PatientHomeDataModel>? data,
      @JsonKey(name: 'first_page_url') final String? firstPageUrl,
      final int? from,
      @JsonKey(name: 'last_page') final int? lastPage,
      @JsonKey(name: 'last_page_url') final String? lastPageUrl,
      final List<Link>? links,
      @JsonKey(name: 'next_page_url') final String? nextPageUrl,
      final String? path,
      final int? perPage,
      @JsonKey(name: 'prev_page_url') final String? prevPageUrl,
      final int? to,
      final int? total}) = _$GetAllDoctorsPatientDataModelResponseImpl;

  factory _GetAllDoctorsPatientDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllDoctorsPatientDataModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  List<PatientHomeDataModel>? get data;
  @override
  @JsonKey(name: 'first_page_url')
  String? get firstPageUrl;
  @override
  int? get from;
  @override
  @JsonKey(name: 'last_page')
  int? get lastPage;
  @override
  @JsonKey(name: 'last_page_url')
  String? get lastPageUrl;
  @override
  List<Link>? get links;
  @override
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl;
  @override
  String? get path;
  @override
  int? get perPage;
  @override
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl;
  @override
  int? get to;
  @override
  int? get total;

  /// Create a copy of GetAllDoctorsPatientDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllDoctorsPatientDataModelResponseImplCopyWith<
          _$GetAllDoctorsPatientDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
