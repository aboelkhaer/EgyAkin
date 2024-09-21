// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_profile_patients_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetProfilePatientsModelResponse _$GetProfilePatientsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetProfilePatientsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetProfilePatientsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  GetProfilePatientsDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetProfilePatientsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetProfilePatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetProfilePatientsModelResponseCopyWith<GetProfilePatientsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProfilePatientsModelResponseCopyWith<$Res> {
  factory $GetProfilePatientsModelResponseCopyWith(
          GetProfilePatientsModelResponse value,
          $Res Function(GetProfilePatientsModelResponse) then) =
      _$GetProfilePatientsModelResponseCopyWithImpl<$Res,
          GetProfilePatientsModelResponse>;
  @useResult
  $Res call({bool? value, GetProfilePatientsDataModelResponse? data});

  $GetProfilePatientsDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetProfilePatientsModelResponseCopyWithImpl<$Res,
        $Val extends GetProfilePatientsModelResponse>
    implements $GetProfilePatientsModelResponseCopyWith<$Res> {
  _$GetProfilePatientsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetProfilePatientsModelResponse
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
              as GetProfilePatientsDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetProfilePatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetProfilePatientsDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetProfilePatientsDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetProfilePatientsModelResponseImplCopyWith<$Res>
    implements $GetProfilePatientsModelResponseCopyWith<$Res> {
  factory _$$GetProfilePatientsModelResponseImplCopyWith(
          _$GetProfilePatientsModelResponseImpl value,
          $Res Function(_$GetProfilePatientsModelResponseImpl) then) =
      __$$GetProfilePatientsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, GetProfilePatientsDataModelResponse? data});

  @override
  $GetProfilePatientsDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetProfilePatientsModelResponseImplCopyWithImpl<$Res>
    extends _$GetProfilePatientsModelResponseCopyWithImpl<$Res,
        _$GetProfilePatientsModelResponseImpl>
    implements _$$GetProfilePatientsModelResponseImplCopyWith<$Res> {
  __$$GetProfilePatientsModelResponseImplCopyWithImpl(
      _$GetProfilePatientsModelResponseImpl _value,
      $Res Function(_$GetProfilePatientsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetProfilePatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetProfilePatientsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetProfilePatientsDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetProfilePatientsModelResponseImpl
    implements _GetProfilePatientsModelResponse {
  const _$GetProfilePatientsModelResponseImpl({this.value, this.data});

  factory _$GetProfilePatientsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetProfilePatientsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final GetProfilePatientsDataModelResponse? data;

  @override
  String toString() {
    return 'GetProfilePatientsModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetProfilePatientsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, data);

  /// Create a copy of GetProfilePatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetProfilePatientsModelResponseImplCopyWith<
          _$GetProfilePatientsModelResponseImpl>
      get copyWith => __$$GetProfilePatientsModelResponseImplCopyWithImpl<
          _$GetProfilePatientsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetProfilePatientsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetProfilePatientsModelResponse
    implements GetProfilePatientsModelResponse {
  const factory _GetProfilePatientsModelResponse(
          {final bool? value,
          final GetProfilePatientsDataModelResponse? data}) =
      _$GetProfilePatientsModelResponseImpl;

  factory _GetProfilePatientsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetProfilePatientsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  GetProfilePatientsDataModelResponse? get data;

  /// Create a copy of GetProfilePatientsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetProfilePatientsModelResponseImplCopyWith<
          _$GetProfilePatientsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetProfilePatientsDataModelResponse
    _$GetProfilePatientsDataModelResponseFromJson(Map<String, dynamic> json) {
  return _GetProfilePatientsDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetProfilePatientsDataModelResponse {
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

  /// Serializes this GetProfilePatientsDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetProfilePatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetProfilePatientsDataModelResponseCopyWith<
          GetProfilePatientsDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProfilePatientsDataModelResponseCopyWith<$Res> {
  factory $GetProfilePatientsDataModelResponseCopyWith(
          GetProfilePatientsDataModelResponse value,
          $Res Function(GetProfilePatientsDataModelResponse) then) =
      _$GetProfilePatientsDataModelResponseCopyWithImpl<$Res,
          GetProfilePatientsDataModelResponse>;
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
class _$GetProfilePatientsDataModelResponseCopyWithImpl<$Res,
        $Val extends GetProfilePatientsDataModelResponse>
    implements $GetProfilePatientsDataModelResponseCopyWith<$Res> {
  _$GetProfilePatientsDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetProfilePatientsDataModelResponse
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
abstract class _$$GetProfilePatientsDataModelResponseImplCopyWith<$Res>
    implements $GetProfilePatientsDataModelResponseCopyWith<$Res> {
  factory _$$GetProfilePatientsDataModelResponseImplCopyWith(
          _$GetProfilePatientsDataModelResponseImpl value,
          $Res Function(_$GetProfilePatientsDataModelResponseImpl) then) =
      __$$GetProfilePatientsDataModelResponseImplCopyWithImpl<$Res>;
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
class __$$GetProfilePatientsDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetProfilePatientsDataModelResponseCopyWithImpl<$Res,
        _$GetProfilePatientsDataModelResponseImpl>
    implements _$$GetProfilePatientsDataModelResponseImplCopyWith<$Res> {
  __$$GetProfilePatientsDataModelResponseImplCopyWithImpl(
      _$GetProfilePatientsDataModelResponseImpl _value,
      $Res Function(_$GetProfilePatientsDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetProfilePatientsDataModelResponse
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
    return _then(_$GetProfilePatientsDataModelResponseImpl(
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
class _$GetProfilePatientsDataModelResponseImpl
    implements _GetProfilePatientsDataModelResponse {
  const _$GetProfilePatientsDataModelResponseImpl(
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

  factory _$GetProfilePatientsDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetProfilePatientsDataModelResponseImplFromJson(json);

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
    return 'GetProfilePatientsDataModelResponse(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetProfilePatientsDataModelResponseImpl &&
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

  /// Create a copy of GetProfilePatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetProfilePatientsDataModelResponseImplCopyWith<
          _$GetProfilePatientsDataModelResponseImpl>
      get copyWith => __$$GetProfilePatientsDataModelResponseImplCopyWithImpl<
          _$GetProfilePatientsDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetProfilePatientsDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetProfilePatientsDataModelResponse
    implements GetProfilePatientsDataModelResponse {
  const factory _GetProfilePatientsDataModelResponse(
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
      final int? total}) = _$GetProfilePatientsDataModelResponseImpl;

  factory _GetProfilePatientsDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetProfilePatientsDataModelResponseImpl.fromJson;

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

  /// Create a copy of GetProfilePatientsDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetProfilePatientsDataModelResponseImplCopyWith<
          _$GetProfilePatientsDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
