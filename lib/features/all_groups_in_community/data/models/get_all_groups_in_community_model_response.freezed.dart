// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_groups_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAllGroupsInCommunityModelResponse
    _$GetAllGroupsInCommunityModelResponseFromJson(Map<String, dynamic> json) {
  return _GetAllGroupsInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllGroupsInCommunityModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  GetAllGroupsInCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetAllGroupsInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllGroupsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllGroupsInCommunityModelResponseCopyWith<
          GetAllGroupsInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllGroupsInCommunityModelResponseCopyWith<$Res> {
  factory $GetAllGroupsInCommunityModelResponseCopyWith(
          GetAllGroupsInCommunityModelResponse value,
          $Res Function(GetAllGroupsInCommunityModelResponse) then) =
      _$GetAllGroupsInCommunityModelResponseCopyWithImpl<$Res,
          GetAllGroupsInCommunityModelResponse>;
  @useResult
  $Res call({bool? value, GetAllGroupsInCommunityDataModelResponse? data});

  $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetAllGroupsInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends GetAllGroupsInCommunityModelResponse>
    implements $GetAllGroupsInCommunityModelResponseCopyWith<$Res> {
  _$GetAllGroupsInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllGroupsInCommunityModelResponse
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
              as GetAllGroupsInCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetAllGroupsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAllGroupsInCommunityModelResponseImplCopyWith<$Res>
    implements $GetAllGroupsInCommunityModelResponseCopyWith<$Res> {
  factory _$$GetAllGroupsInCommunityModelResponseImplCopyWith(
          _$GetAllGroupsInCommunityModelResponseImpl value,
          $Res Function(_$GetAllGroupsInCommunityModelResponseImpl) then) =
      __$$GetAllGroupsInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, GetAllGroupsInCommunityDataModelResponse? data});

  @override
  $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetAllGroupsInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllGroupsInCommunityModelResponseCopyWithImpl<$Res,
        _$GetAllGroupsInCommunityModelResponseImpl>
    implements _$$GetAllGroupsInCommunityModelResponseImplCopyWith<$Res> {
  __$$GetAllGroupsInCommunityModelResponseImplCopyWithImpl(
      _$GetAllGroupsInCommunityModelResponseImpl _value,
      $Res Function(_$GetAllGroupsInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllGroupsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetAllGroupsInCommunityModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetAllGroupsInCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllGroupsInCommunityModelResponseImpl
    implements _GetAllGroupsInCommunityModelResponse {
  const _$GetAllGroupsInCommunityModelResponseImpl({this.value, this.data});

  factory _$GetAllGroupsInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllGroupsInCommunityModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final GetAllGroupsInCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetAllGroupsInCommunityModelResponse(value: $value, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllGroupsInCommunityModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, data);

  /// Create a copy of GetAllGroupsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllGroupsInCommunityModelResponseImplCopyWith<
          _$GetAllGroupsInCommunityModelResponseImpl>
      get copyWith => __$$GetAllGroupsInCommunityModelResponseImplCopyWithImpl<
          _$GetAllGroupsInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllGroupsInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllGroupsInCommunityModelResponse
    implements GetAllGroupsInCommunityModelResponse {
  const factory _GetAllGroupsInCommunityModelResponse(
          {final bool? value,
          final GetAllGroupsInCommunityDataModelResponse? data}) =
      _$GetAllGroupsInCommunityModelResponseImpl;

  factory _GetAllGroupsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllGroupsInCommunityModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  GetAllGroupsInCommunityDataModelResponse? get data;

  /// Create a copy of GetAllGroupsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllGroupsInCommunityModelResponseImplCopyWith<
          _$GetAllGroupsInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetAllGroupsInCommunityDataModelResponse
    _$GetAllGroupsInCommunityDataModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetAllGroupsInCommunityDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllGroupsInCommunityDataModelResponse {
  List<GroupModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_page_url')
  String? get firstPageUrl => throw _privateConstructorUsedError;
  int? get from => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  int? get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page_url')
  String? get lastPageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_page_url')
  String? get nextPageUrl => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this GetAllGroupsInCommunityDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllGroupsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllGroupsInCommunityDataModelResponseCopyWith<
          GetAllGroupsInCommunityDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res> {
  factory $GetAllGroupsInCommunityDataModelResponseCopyWith(
          GetAllGroupsInCommunityDataModelResponse value,
          $Res Function(GetAllGroupsInCommunityDataModelResponse) then) =
      _$GetAllGroupsInCommunityDataModelResponseCopyWithImpl<$Res,
          GetAllGroupsInCommunityDataModelResponse>;
  @useResult
  $Res call(
      {List<GroupModel>? data,
      @JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class _$GetAllGroupsInCommunityDataModelResponseCopyWithImpl<$Res,
        $Val extends GetAllGroupsInCommunityDataModelResponse>
    implements $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res> {
  _$GetAllGroupsInCommunityDataModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllGroupsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? currentPage = freezed,
    Object? firstPageUrl = freezed,
    Object? from = freezed,
    Object? lastPage = freezed,
    Object? lastPageUrl = freezed,
    Object? nextPageUrl = freezed,
    Object? path = freezed,
    Object? perPage = freezed,
    Object? prevPageUrl = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$GetAllGroupsInCommunityDataModelResponseImplCopyWith<$Res>
    implements $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res> {
  factory _$$GetAllGroupsInCommunityDataModelResponseImplCopyWith(
          _$GetAllGroupsInCommunityDataModelResponseImpl value,
          $Res Function(_$GetAllGroupsInCommunityDataModelResponseImpl) then) =
      __$$GetAllGroupsInCommunityDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GroupModel>? data,
      @JsonKey(name: 'current_page') int? currentPage,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class __$$GetAllGroupsInCommunityDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllGroupsInCommunityDataModelResponseCopyWithImpl<$Res,
        _$GetAllGroupsInCommunityDataModelResponseImpl>
    implements _$$GetAllGroupsInCommunityDataModelResponseImplCopyWith<$Res> {
  __$$GetAllGroupsInCommunityDataModelResponseImplCopyWithImpl(
      _$GetAllGroupsInCommunityDataModelResponseImpl _value,
      $Res Function(_$GetAllGroupsInCommunityDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllGroupsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? currentPage = freezed,
    Object? firstPageUrl = freezed,
    Object? from = freezed,
    Object? lastPage = freezed,
    Object? lastPageUrl = freezed,
    Object? nextPageUrl = freezed,
    Object? path = freezed,
    Object? perPage = freezed,
    Object? prevPageUrl = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_$GetAllGroupsInCommunityDataModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$GetAllGroupsInCommunityDataModelResponseImpl
    implements _GetAllGroupsInCommunityDataModelResponse {
  const _$GetAllGroupsInCommunityDataModelResponseImpl(
      {final List<GroupModel>? data,
      @JsonKey(name: 'current_page') this.currentPage,
      @JsonKey(name: 'first_page_url') this.firstPageUrl,
      this.from,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'last_page_url') this.lastPageUrl,
      @JsonKey(name: 'next_page_url') this.nextPageUrl,
      this.path,
      this.perPage,
      @JsonKey(name: 'prev_page_url') this.prevPageUrl,
      this.to,
      this.total})
      : _data = data;

  factory _$GetAllGroupsInCommunityDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllGroupsInCommunityDataModelResponseImplFromJson(json);

  final List<GroupModel>? _data;
  @override
  List<GroupModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
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
    return 'GetAllGroupsInCommunityDataModelResponse(data: $data, currentPage: $currentPage, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllGroupsInCommunityDataModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.firstPageUrl, firstPageUrl) ||
                other.firstPageUrl == firstPageUrl) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            (identical(other.lastPageUrl, lastPageUrl) ||
                other.lastPageUrl == lastPageUrl) &&
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
      const DeepCollectionEquality().hash(_data),
      currentPage,
      firstPageUrl,
      from,
      lastPage,
      lastPageUrl,
      nextPageUrl,
      path,
      perPage,
      prevPageUrl,
      to,
      total);

  /// Create a copy of GetAllGroupsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllGroupsInCommunityDataModelResponseImplCopyWith<
          _$GetAllGroupsInCommunityDataModelResponseImpl>
      get copyWith =>
          __$$GetAllGroupsInCommunityDataModelResponseImplCopyWithImpl<
              _$GetAllGroupsInCommunityDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllGroupsInCommunityDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllGroupsInCommunityDataModelResponse
    implements GetAllGroupsInCommunityDataModelResponse {
  const factory _GetAllGroupsInCommunityDataModelResponse(
      {final List<GroupModel>? data,
      @JsonKey(name: 'current_page') final int? currentPage,
      @JsonKey(name: 'first_page_url') final String? firstPageUrl,
      final int? from,
      @JsonKey(name: 'last_page') final int? lastPage,
      @JsonKey(name: 'last_page_url') final String? lastPageUrl,
      @JsonKey(name: 'next_page_url') final String? nextPageUrl,
      final String? path,
      final int? perPage,
      @JsonKey(name: 'prev_page_url') final String? prevPageUrl,
      final int? to,
      final int? total}) = _$GetAllGroupsInCommunityDataModelResponseImpl;

  factory _GetAllGroupsInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllGroupsInCommunityDataModelResponseImpl.fromJson;

  @override
  List<GroupModel>? get data;
  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
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

  /// Create a copy of GetAllGroupsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllGroupsInCommunityDataModelResponseImplCopyWith<
          _$GetAllGroupsInCommunityDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
