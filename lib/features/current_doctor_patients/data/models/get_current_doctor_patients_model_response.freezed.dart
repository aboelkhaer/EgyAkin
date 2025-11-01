// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_current_doctor_patients_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetDoctorPatientsModelResponse _$GetDoctorPatientsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetDoctorPatientsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetDoctorPatientsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  bool? get verified => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_value')
  String? get scoreValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_count')
  String? get patientCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'filter')
  List<GetFiltersOptionsDataModelResponse>? get filters =>
      throw _privateConstructorUsedError;
  GetDoctorPatientsDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetDoctorPatientsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetDoctorPatientsModelResponseCopyWith<GetDoctorPatientsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetDoctorPatientsModelResponseCopyWith<$Res> {
  factory $GetDoctorPatientsModelResponseCopyWith(
          GetDoctorPatientsModelResponse value,
          $Res Function(GetDoctorPatientsModelResponse) then) =
      _$GetDoctorPatientsModelResponseCopyWithImpl<$Res,
          GetDoctorPatientsModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'patient_count') String? patientCount,
      @JsonKey(name: 'filter')
      List<GetFiltersOptionsDataModelResponse>? filters,
      GetDoctorPatientsDataModelResponse? data});

  $GetDoctorPatientsDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetDoctorPatientsModelResponseCopyWithImpl<$Res,
        $Val extends GetDoctorPatientsModelResponse>
    implements $GetDoctorPatientsModelResponseCopyWith<$Res> {
  _$GetDoctorPatientsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? scoreValue = freezed,
    Object? patientCount = freezed,
    Object? filters = freezed,
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
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetDoctorPatientsDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetDoctorPatientsDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetDoctorPatientsDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetDoctorPatientsModelResponseImplCopyWith<$Res>
    implements $GetDoctorPatientsModelResponseCopyWith<$Res> {
  factory _$$GetDoctorPatientsModelResponseImplCopyWith(
          _$GetDoctorPatientsModelResponseImpl value,
          $Res Function(_$GetDoctorPatientsModelResponseImpl) then) =
      __$$GetDoctorPatientsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      bool? verified,
      @JsonKey(name: 'score_value') String? scoreValue,
      @JsonKey(name: 'patient_count') String? patientCount,
      @JsonKey(name: 'filter')
      List<GetFiltersOptionsDataModelResponse>? filters,
      GetDoctorPatientsDataModelResponse? data});

  @override
  $GetDoctorPatientsDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetDoctorPatientsModelResponseImplCopyWithImpl<$Res>
    extends _$GetDoctorPatientsModelResponseCopyWithImpl<$Res,
        _$GetDoctorPatientsModelResponseImpl>
    implements _$$GetDoctorPatientsModelResponseImplCopyWith<$Res> {
  __$$GetDoctorPatientsModelResponseImplCopyWithImpl(
      _$GetDoctorPatientsModelResponseImpl _value,
      $Res Function(_$GetDoctorPatientsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? verified = freezed,
    Object? scoreValue = freezed,
    Object? patientCount = freezed,
    Object? filters = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetDoctorPatientsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      scoreValue: freezed == scoreValue
          ? _value.scoreValue
          : scoreValue // ignore: cast_nullable_to_non_nullable
              as String?,
      patientCount: freezed == patientCount
          ? _value.patientCount
          : patientCount // ignore: cast_nullable_to_non_nullable
              as String?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<GetFiltersOptionsDataModelResponse>?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetDoctorPatientsDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetDoctorPatientsModelResponseImpl
    implements _GetDoctorPatientsModelResponse {
  const _$GetDoctorPatientsModelResponseImpl(
      {this.value,
      this.verified,
      @JsonKey(name: 'score_value') this.scoreValue,
      @JsonKey(name: 'patient_count') this.patientCount,
      @JsonKey(name: 'filter')
      final List<GetFiltersOptionsDataModelResponse>? filters,
      this.data})
      : _filters = filters;

  factory _$GetDoctorPatientsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetDoctorPatientsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final bool? verified;
  @override
  @JsonKey(name: 'score_value')
  final String? scoreValue;
  @override
  @JsonKey(name: 'patient_count')
  final String? patientCount;
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
  final GetDoctorPatientsDataModelResponse? data;

  @override
  String toString() {
    return 'GetDoctorPatientsModelResponse(value: $value, verified: $verified, scoreValue: $scoreValue, patientCount: $patientCount, filters: $filters, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorPatientsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.scoreValue, scoreValue) ||
                other.scoreValue == scoreValue) &&
            (identical(other.patientCount, patientCount) ||
                other.patientCount == patientCount) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, verified, scoreValue,
      patientCount, const DeepCollectionEquality().hash(_filters), data);

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorPatientsModelResponseImplCopyWith<
          _$GetDoctorPatientsModelResponseImpl>
      get copyWith => __$$GetDoctorPatientsModelResponseImplCopyWithImpl<
          _$GetDoctorPatientsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetDoctorPatientsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetDoctorPatientsModelResponse
    implements GetDoctorPatientsModelResponse {
  const factory _GetDoctorPatientsModelResponse(
          {final bool? value,
          final bool? verified,
          @JsonKey(name: 'score_value') final String? scoreValue,
          @JsonKey(name: 'patient_count') final String? patientCount,
          @JsonKey(name: 'filter')
          final List<GetFiltersOptionsDataModelResponse>? filters,
          final GetDoctorPatientsDataModelResponse? data}) =
      _$GetDoctorPatientsModelResponseImpl;

  factory _GetDoctorPatientsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetDoctorPatientsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  bool? get verified;
  @override
  @JsonKey(name: 'score_value')
  String? get scoreValue;
  @override
  @JsonKey(name: 'patient_count')
  String? get patientCount;
  @override
  @JsonKey(name: 'filter')
  List<GetFiltersOptionsDataModelResponse>? get filters;
  @override
  GetDoctorPatientsDataModelResponse? get data;

  /// Create a copy of GetDoctorPatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorPatientsModelResponseImplCopyWith<
          _$GetDoctorPatientsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetDoctorPatientsDataModelResponse _$GetDoctorPatientsDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetDoctorPatientsDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetDoctorPatientsDataModelResponse {
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

  /// Serializes this GetDoctorPatientsDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetDoctorPatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetDoctorPatientsDataModelResponseCopyWith<
          GetDoctorPatientsDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetDoctorPatientsDataModelResponseCopyWith<$Res> {
  factory $GetDoctorPatientsDataModelResponseCopyWith(
          GetDoctorPatientsDataModelResponse value,
          $Res Function(GetDoctorPatientsDataModelResponse) then) =
      _$GetDoctorPatientsDataModelResponseCopyWithImpl<$Res,
          GetDoctorPatientsDataModelResponse>;
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
class _$GetDoctorPatientsDataModelResponseCopyWithImpl<$Res,
        $Val extends GetDoctorPatientsDataModelResponse>
    implements $GetDoctorPatientsDataModelResponseCopyWith<$Res> {
  _$GetDoctorPatientsDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetDoctorPatientsDataModelResponse
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
abstract class _$$GetDoctorPatientsDataModelResponseImplCopyWith<$Res>
    implements $GetDoctorPatientsDataModelResponseCopyWith<$Res> {
  factory _$$GetDoctorPatientsDataModelResponseImplCopyWith(
          _$GetDoctorPatientsDataModelResponseImpl value,
          $Res Function(_$GetDoctorPatientsDataModelResponseImpl) then) =
      __$$GetDoctorPatientsDataModelResponseImplCopyWithImpl<$Res>;
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
class __$$GetDoctorPatientsDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetDoctorPatientsDataModelResponseCopyWithImpl<$Res,
        _$GetDoctorPatientsDataModelResponseImpl>
    implements _$$GetDoctorPatientsDataModelResponseImplCopyWith<$Res> {
  __$$GetDoctorPatientsDataModelResponseImplCopyWithImpl(
      _$GetDoctorPatientsDataModelResponseImpl _value,
      $Res Function(_$GetDoctorPatientsDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetDoctorPatientsDataModelResponse
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
    return _then(_$GetDoctorPatientsDataModelResponseImpl(
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
class _$GetDoctorPatientsDataModelResponseImpl
    implements _GetDoctorPatientsDataModelResponse {
  const _$GetDoctorPatientsDataModelResponseImpl(
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

  factory _$GetDoctorPatientsDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetDoctorPatientsDataModelResponseImplFromJson(json);

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
    return 'GetDoctorPatientsDataModelResponse(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorPatientsDataModelResponseImpl &&
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

  /// Create a copy of GetDoctorPatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorPatientsDataModelResponseImplCopyWith<
          _$GetDoctorPatientsDataModelResponseImpl>
      get copyWith => __$$GetDoctorPatientsDataModelResponseImplCopyWithImpl<
          _$GetDoctorPatientsDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetDoctorPatientsDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetDoctorPatientsDataModelResponse
    implements GetDoctorPatientsDataModelResponse {
  const factory _GetDoctorPatientsDataModelResponse(
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
      final int? total}) = _$GetDoctorPatientsDataModelResponseImpl;

  factory _GetDoctorPatientsDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetDoctorPatientsDataModelResponseImpl.fromJson;

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

  /// Create a copy of GetDoctorPatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorPatientsDataModelResponseImplCopyWith<
          _$GetDoctorPatientsDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
