// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_posts_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPostsCommunityModelResponse _$GetPostsCommunityModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPostsCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPostsCommunityModelResponse {
  GetPostsCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetPostsCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPostsCommunityModelResponseCopyWith<GetPostsCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostsCommunityModelResponseCopyWith<$Res> {
  factory $GetPostsCommunityModelResponseCopyWith(
          GetPostsCommunityModelResponse value,
          $Res Function(GetPostsCommunityModelResponse) then) =
      _$GetPostsCommunityModelResponseCopyWithImpl<$Res,
          GetPostsCommunityModelResponse>;
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetPostsCommunityModelResponseCopyWithImpl<$Res,
        $Val extends GetPostsCommunityModelResponse>
    implements $GetPostsCommunityModelResponseCopyWith<$Res> {
  _$GetPostsCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetPostsCommunityDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPostsCommunityModelResponseImplCopyWith<$Res>
    implements $GetPostsCommunityModelResponseCopyWith<$Res> {
  factory _$$GetPostsCommunityModelResponseImplCopyWith(
          _$GetPostsCommunityModelResponseImpl value,
          $Res Function(_$GetPostsCommunityModelResponseImpl) then) =
      __$$GetPostsCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  @override
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetPostsCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$GetPostsCommunityModelResponseCopyWithImpl<$Res,
        _$GetPostsCommunityModelResponseImpl>
    implements _$$GetPostsCommunityModelResponseImplCopyWith<$Res> {
  __$$GetPostsCommunityModelResponseImplCopyWithImpl(
      _$GetPostsCommunityModelResponseImpl _value,
      $Res Function(_$GetPostsCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetPostsCommunityModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPostsCommunityModelResponseImpl
    implements _GetPostsCommunityModelResponse {
  const _$GetPostsCommunityModelResponseImpl({this.data});

  factory _$GetPostsCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPostsCommunityModelResponseImplFromJson(json);

  @override
  final GetPostsCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetPostsCommunityModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsCommunityModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostsCommunityModelResponseImplCopyWith<
          _$GetPostsCommunityModelResponseImpl>
      get copyWith => __$$GetPostsCommunityModelResponseImplCopyWithImpl<
          _$GetPostsCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostsCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPostsCommunityModelResponse
    implements GetPostsCommunityModelResponse {
  const factory _GetPostsCommunityModelResponse(
          {final GetPostsCommunityDataModelResponse? data}) =
      _$GetPostsCommunityModelResponseImpl;

  factory _GetPostsCommunityModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetPostsCommunityModelResponseImpl.fromJson;

  @override
  GetPostsCommunityDataModelResponse? get data;

  /// Create a copy of GetPostsCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPostsCommunityModelResponseImplCopyWith<
          _$GetPostsCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetPostsCommunityDataModelResponse _$GetPostsCommunityDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPostsCommunityDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPostsCommunityDataModelResponse {
  List<PostCommunityModel>? get data => throw _privateConstructorUsedError;
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

  /// Serializes this GetPostsCommunityDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetPostsCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetPostsCommunityDataModelResponseCopyWith<
          GetPostsCommunityDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostsCommunityDataModelResponseCopyWith<$Res> {
  factory $GetPostsCommunityDataModelResponseCopyWith(
          GetPostsCommunityDataModelResponse value,
          $Res Function(GetPostsCommunityDataModelResponse) then) =
      _$GetPostsCommunityDataModelResponseCopyWithImpl<$Res,
          GetPostsCommunityDataModelResponse>;
  @useResult
  $Res call(
      {List<PostCommunityModel>? data,
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
class _$GetPostsCommunityDataModelResponseCopyWithImpl<$Res,
        $Val extends GetPostsCommunityDataModelResponse>
    implements $GetPostsCommunityDataModelResponseCopyWith<$Res> {
  _$GetPostsCommunityDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetPostsCommunityDataModelResponse
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
              as List<PostCommunityModel>?,
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
abstract class _$$GetPostsCommunityDataModelResponseImplCopyWith<$Res>
    implements $GetPostsCommunityDataModelResponseCopyWith<$Res> {
  factory _$$GetPostsCommunityDataModelResponseImplCopyWith(
          _$GetPostsCommunityDataModelResponseImpl value,
          $Res Function(_$GetPostsCommunityDataModelResponseImpl) then) =
      __$$GetPostsCommunityDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PostCommunityModel>? data,
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
class __$$GetPostsCommunityDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetPostsCommunityDataModelResponseCopyWithImpl<$Res,
        _$GetPostsCommunityDataModelResponseImpl>
    implements _$$GetPostsCommunityDataModelResponseImplCopyWith<$Res> {
  __$$GetPostsCommunityDataModelResponseImplCopyWithImpl(
      _$GetPostsCommunityDataModelResponseImpl _value,
      $Res Function(_$GetPostsCommunityDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetPostsCommunityDataModelResponse
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
    return _then(_$GetPostsCommunityDataModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PostCommunityModel>?,
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
class _$GetPostsCommunityDataModelResponseImpl
    implements _GetPostsCommunityDataModelResponse {
  const _$GetPostsCommunityDataModelResponseImpl(
      {final List<PostCommunityModel>? data,
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

  factory _$GetPostsCommunityDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPostsCommunityDataModelResponseImplFromJson(json);

  final List<PostCommunityModel>? _data;
  @override
  List<PostCommunityModel>? get data {
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
    return 'GetPostsCommunityDataModelResponse(data: $data, currentPage: $currentPage, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsCommunityDataModelResponseImpl &&
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

  /// Create a copy of GetPostsCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostsCommunityDataModelResponseImplCopyWith<
          _$GetPostsCommunityDataModelResponseImpl>
      get copyWith => __$$GetPostsCommunityDataModelResponseImplCopyWithImpl<
          _$GetPostsCommunityDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostsCommunityDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetPostsCommunityDataModelResponse
    implements GetPostsCommunityDataModelResponse {
  const factory _GetPostsCommunityDataModelResponse(
      {final List<PostCommunityModel>? data,
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
      final int? total}) = _$GetPostsCommunityDataModelResponseImpl;

  factory _GetPostsCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetPostsCommunityDataModelResponseImpl.fromJson;

  @override
  List<PostCommunityModel>? get data;
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

  /// Create a copy of GetPostsCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetPostsCommunityDataModelResponseImplCopyWith<
          _$GetPostsCommunityDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PostCommunityModel _$PostCommunityModelFromJson(Map<String, dynamic> json) {
  return _PostCommunityModel.fromJson(json);
}

/// @nodoc
mixin _$PostCommunityModel {
  int? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_type')
  String? get mediaType => throw _privateConstructorUsedError;
  @JsonKey(name: 'media_path')
  String? get mediaPath => throw _privateConstructorUsedError;
  String? get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int? get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comments_count')
  int? get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'isSaved')
  bool? get isSaved => throw _privateConstructorUsedError;
  @JsonKey(name: 'isLiked')
  bool? get isLiked => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;

  /// Serializes this PostCommunityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCommunityModelCopyWith<PostCommunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommunityModelCopyWith<$Res> {
  factory $PostCommunityModelCopyWith(
          PostCommunityModel value, $Res Function(PostCommunityModel) then) =
      _$PostCommunityModelCopyWithImpl<$Res, PostCommunityModel>;
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'media_type') String? mediaType,
      @JsonKey(name: 'media_path') String? mediaPath,
      String? visibility,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'comments_count') int? commentsCount,
      @JsonKey(name: 'isSaved') bool? isSaved,
      @JsonKey(name: 'isLiked') bool? isLiked,
      DoctorModel? doctor});

  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class _$PostCommunityModelCopyWithImpl<$Res, $Val extends PostCommunityModel>
    implements $PostCommunityModelCopyWith<$Res> {
  _$PostCommunityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? mediaType = freezed,
    Object? mediaPath = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? isSaved = freezed,
    Object? isLiked = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaPath: freezed == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isSaved: freezed == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get doctor {
    if (_value.doctor == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.doctor!, (value) {
      return _then(_value.copyWith(doctor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostCommunityModelImplCopyWith<$Res>
    implements $PostCommunityModelCopyWith<$Res> {
  factory _$$PostCommunityModelImplCopyWith(_$PostCommunityModelImpl value,
          $Res Function(_$PostCommunityModelImpl) then) =
      __$$PostCommunityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'media_type') String? mediaType,
      @JsonKey(name: 'media_path') String? mediaPath,
      String? visibility,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'comments_count') int? commentsCount,
      @JsonKey(name: 'isSaved') bool? isSaved,
      @JsonKey(name: 'isLiked') bool? isLiked,
      DoctorModel? doctor});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class __$$PostCommunityModelImplCopyWithImpl<$Res>
    extends _$PostCommunityModelCopyWithImpl<$Res, _$PostCommunityModelImpl>
    implements _$$PostCommunityModelImplCopyWith<$Res> {
  __$$PostCommunityModelImplCopyWithImpl(_$PostCommunityModelImpl _value,
      $Res Function(_$PostCommunityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? mediaType = freezed,
    Object? mediaPath = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? likesCount = freezed,
    Object? commentsCount = freezed,
    Object? isSaved = freezed,
    Object? isLiked = freezed,
    Object? doctor = freezed,
  }) {
    return _then(_$PostCommunityModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaPath: freezed == mediaPath
          ? _value.mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isSaved: freezed == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCommunityModelImpl implements _PostCommunityModel {
  const _$PostCommunityModelImpl(
      {this.id,
      this.content,
      @JsonKey(name: 'media_type') this.mediaType,
      @JsonKey(name: 'media_path') this.mediaPath,
      this.visibility,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'likes_count') this.likesCount,
      @JsonKey(name: 'comments_count') this.commentsCount,
      @JsonKey(name: 'isSaved') this.isSaved,
      @JsonKey(name: 'isLiked') this.isLiked,
      this.doctor});

  factory _$PostCommunityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommunityModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? content;
  @override
  @JsonKey(name: 'media_type')
  final String? mediaType;
  @override
  @JsonKey(name: 'media_path')
  final String? mediaPath;
  @override
  final String? visibility;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'likes_count')
  final int? likesCount;
  @override
  @JsonKey(name: 'comments_count')
  final int? commentsCount;
  @override
  @JsonKey(name: 'isSaved')
  final bool? isSaved;
  @override
  @JsonKey(name: 'isLiked')
  final bool? isLiked;
  @override
  final DoctorModel? doctor;

  @override
  String toString() {
    return 'PostCommunityModel(id: $id, content: $content, mediaType: $mediaType, mediaPath: $mediaPath, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt, likesCount: $likesCount, commentsCount: $commentsCount, isSaved: $isSaved, isLiked: $isLiked, doctor: $doctor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommunityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.mediaPath, mediaPath) ||
                other.mediaPath == mediaPath) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.doctor, doctor) || other.doctor == doctor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      mediaType,
      mediaPath,
      visibility,
      createdAt,
      updatedAt,
      likesCount,
      commentsCount,
      isSaved,
      isLiked,
      doctor);

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommunityModelImplCopyWith<_$PostCommunityModelImpl> get copyWith =>
      __$$PostCommunityModelImplCopyWithImpl<_$PostCommunityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommunityModelImplToJson(
      this,
    );
  }
}

abstract class _PostCommunityModel implements PostCommunityModel {
  const factory _PostCommunityModel(
      {final int? id,
      final String? content,
      @JsonKey(name: 'media_type') final String? mediaType,
      @JsonKey(name: 'media_path') final String? mediaPath,
      final String? visibility,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'likes_count') final int? likesCount,
      @JsonKey(name: 'comments_count') final int? commentsCount,
      @JsonKey(name: 'isSaved') final bool? isSaved,
      @JsonKey(name: 'isLiked') final bool? isLiked,
      final DoctorModel? doctor}) = _$PostCommunityModelImpl;

  factory _PostCommunityModel.fromJson(Map<String, dynamic> json) =
      _$PostCommunityModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get content;
  @override
  @JsonKey(name: 'media_type')
  String? get mediaType;
  @override
  @JsonKey(name: 'media_path')
  String? get mediaPath;
  @override
  String? get visibility;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'likes_count')
  int? get likesCount;
  @override
  @JsonKey(name: 'comments_count')
  int? get commentsCount;
  @override
  @JsonKey(name: 'isSaved')
  bool? get isSaved;
  @override
  @JsonKey(name: 'isLiked')
  bool? get isLiked;
  @override
  DoctorModel? get doctor;

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCommunityModelImplCopyWith<_$PostCommunityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
