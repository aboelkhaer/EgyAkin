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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
class _$GetSearchModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetSearchModelResponse {
  const _$GetSearchModelResponseImpl({this.value, this.data});

  factory _$GetSearchModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetSearchModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final GetSearchDataModelResponse? data;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetSearchModelResponse(value: $value, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetSearchModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value, data);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$GetSearchModelResponseImplCopyWith<_$GetSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetSearchDataModelResponse _$GetSearchDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetSearchDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetSearchDataModelResponse {
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
class _$GetSearchDataModelResponseCopyWithImpl<$Res,
        $Val extends GetSearchDataModelResponse>
    implements $GetSearchDataModelResponseCopyWith<$Res> {
  _$GetSearchDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$GetSearchDataModelResponseImplCopyWith<$Res>
    implements $GetSearchDataModelResponseCopyWith<$Res> {
  factory _$$GetSearchDataModelResponseImplCopyWith(
          _$GetSearchDataModelResponseImpl value,
          $Res Function(_$GetSearchDataModelResponseImpl) then) =
      __$$GetSearchDataModelResponseImplCopyWithImpl<$Res>;
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
class __$$GetSearchDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetSearchDataModelResponseCopyWithImpl<$Res,
        _$GetSearchDataModelResponseImpl>
    implements _$$GetSearchDataModelResponseImplCopyWith<$Res> {
  __$$GetSearchDataModelResponseImplCopyWithImpl(
      _$GetSearchDataModelResponseImpl _value,
      $Res Function(_$GetSearchDataModelResponseImpl) _then)
      : super(_value, _then);

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
    return _then(_$GetSearchDataModelResponseImpl(
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
class _$GetSearchDataModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetSearchDataModelResponse {
  const _$GetSearchDataModelResponseImpl(
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

  factory _$GetSearchDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetSearchDataModelResponseImplFromJson(json);

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetSearchDataModelResponse(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetSearchDataModelResponse'))
      ..add(DiagnosticsProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('firstPageUrl', firstPageUrl))
      ..add(DiagnosticsProperty('from', from))
      ..add(DiagnosticsProperty('lastPage', lastPage))
      ..add(DiagnosticsProperty('lastPageUrl', lastPageUrl))
      ..add(DiagnosticsProperty('links', links))
      ..add(DiagnosticsProperty('nextPageUrl', nextPageUrl))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('perPage', perPage))
      ..add(DiagnosticsProperty('prevPageUrl', prevPageUrl))
      ..add(DiagnosticsProperty('to', to))
      ..add(DiagnosticsProperty('total', total));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSearchDataModelResponseImpl &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
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
      final int? total}) = _$GetSearchDataModelResponseImpl;

  factory _GetSearchDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetSearchDataModelResponseImpl.fromJson;

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
  @override
  @JsonKey(ignore: true)
  _$$GetSearchDataModelResponseImplCopyWith<_$GetSearchDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
