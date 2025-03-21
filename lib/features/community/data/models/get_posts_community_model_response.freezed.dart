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
  List<String>? get mediaPath => throw _privateConstructorUsedError;
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
  GroupDetails? get group => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;
  PollModelResponse? get poll => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'media_path') List<String>? mediaPath,
      String? visibility,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'comments_count') int? commentsCount,
      @JsonKey(name: 'isSaved') bool? isSaved,
      @JsonKey(name: 'isLiked') bool? isLiked,
      GroupDetails? group,
      DoctorModel? doctor,
      PollModelResponse? poll});

  $GroupDetailsCopyWith<$Res>? get group;
  $DoctorModelCopyWith<$Res>? get doctor;
  $PollModelResponseCopyWith<$Res>? get poll;
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
    Object? group = freezed,
    Object? doctor = freezed,
    Object? poll = freezed,
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
              as List<String>?,
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
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDetails?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      poll: freezed == poll
          ? _value.poll
          : poll // ignore: cast_nullable_to_non_nullable
              as PollModelResponse?,
    ) as $Val);
  }

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupDetailsCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupDetailsCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
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

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PollModelResponseCopyWith<$Res>? get poll {
    if (_value.poll == null) {
      return null;
    }

    return $PollModelResponseCopyWith<$Res>(_value.poll!, (value) {
      return _then(_value.copyWith(poll: value) as $Val);
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
      @JsonKey(name: 'media_path') List<String>? mediaPath,
      String? visibility,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'comments_count') int? commentsCount,
      @JsonKey(name: 'isSaved') bool? isSaved,
      @JsonKey(name: 'isLiked') bool? isLiked,
      GroupDetails? group,
      DoctorModel? doctor,
      PollModelResponse? poll});

  @override
  $GroupDetailsCopyWith<$Res>? get group;
  @override
  $DoctorModelCopyWith<$Res>? get doctor;
  @override
  $PollModelResponseCopyWith<$Res>? get poll;
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
    Object? group = freezed,
    Object? doctor = freezed,
    Object? poll = freezed,
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
          ? _value._mediaPath
          : mediaPath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupDetails?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      poll: freezed == poll
          ? _value.poll
          : poll // ignore: cast_nullable_to_non_nullable
              as PollModelResponse?,
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
      @JsonKey(name: 'media_path') final List<String>? mediaPath,
      this.visibility,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'likes_count') this.likesCount,
      @JsonKey(name: 'comments_count') this.commentsCount,
      @JsonKey(name: 'isSaved') this.isSaved,
      @JsonKey(name: 'isLiked') this.isLiked,
      this.group,
      this.doctor,
      this.poll})
      : _mediaPath = mediaPath;

  factory _$PostCommunityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommunityModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? content;
  @override
  @JsonKey(name: 'media_type')
  final String? mediaType;
  final List<String>? _mediaPath;
  @override
  @JsonKey(name: 'media_path')
  List<String>? get mediaPath {
    final value = _mediaPath;
    if (value == null) return null;
    if (_mediaPath is EqualUnmodifiableListView) return _mediaPath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final GroupDetails? group;
  @override
  final DoctorModel? doctor;
  @override
  final PollModelResponse? poll;

  @override
  String toString() {
    return 'PostCommunityModel(id: $id, content: $content, mediaType: $mediaType, mediaPath: $mediaPath, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt, likesCount: $likesCount, commentsCount: $commentsCount, isSaved: $isSaved, isLiked: $isLiked, group: $group, doctor: $doctor, poll: $poll)';
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
            const DeepCollectionEquality()
                .equals(other._mediaPath, _mediaPath) &&
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
            (identical(other.group, group) || other.group == group) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.poll, poll) || other.poll == poll));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      mediaType,
      const DeepCollectionEquality().hash(_mediaPath),
      visibility,
      createdAt,
      updatedAt,
      likesCount,
      commentsCount,
      isSaved,
      isLiked,
      group,
      doctor,
      poll);

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
      @JsonKey(name: 'media_path') final List<String>? mediaPath,
      final String? visibility,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'likes_count') final int? likesCount,
      @JsonKey(name: 'comments_count') final int? commentsCount,
      @JsonKey(name: 'isSaved') final bool? isSaved,
      @JsonKey(name: 'isLiked') final bool? isLiked,
      final GroupDetails? group,
      final DoctorModel? doctor,
      final PollModelResponse? poll}) = _$PostCommunityModelImpl;

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
  List<String>? get mediaPath;
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
  GroupDetails? get group;
  @override
  DoctorModel? get doctor;
  @override
  PollModelResponse? get poll;

  /// Create a copy of PostCommunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCommunityModelImplCopyWith<_$PostCommunityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollModelResponse _$PollModelResponseFromJson(Map<String, dynamic> json) {
  return _PollModelResponse.fromJson(json);
}

/// @nodoc
mixin _$PollModelResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'feed_post_id')
  int? get feedPostId => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_add_options')
  bool? get allowAddOptions => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_multiple_choice')
  bool? get allowMultipleChoice => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  List<PollOptionsModelResponse>? get options =>
      throw _privateConstructorUsedError;

  /// Serializes this PollModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollModelResponseCopyWith<PollModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollModelResponseCopyWith<$Res> {
  factory $PollModelResponseCopyWith(
          PollModelResponse value, $Res Function(PollModelResponse) then) =
      _$PollModelResponseCopyWithImpl<$Res, PollModelResponse>;
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'feed_post_id') int? feedPostId,
      String? question,
      @JsonKey(name: 'allow_add_options') bool? allowAddOptions,
      @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoice,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      List<PollOptionsModelResponse>? options});
}

/// @nodoc
class _$PollModelResponseCopyWithImpl<$Res, $Val extends PollModelResponse>
    implements $PollModelResponseCopyWith<$Res> {
  _$PollModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? feedPostId = freezed,
    Object? question = freezed,
    Object? allowAddOptions = freezed,
    Object? allowMultipleChoice = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? options = freezed,
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
      feedPostId: freezed == feedPostId
          ? _value.feedPostId
          : feedPostId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      allowAddOptions: freezed == allowAddOptions
          ? _value.allowAddOptions
          : allowAddOptions // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleChoice: freezed == allowMultipleChoice
          ? _value.allowMultipleChoice
          : allowMultipleChoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PollOptionsModelResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollModelResponseImplCopyWith<$Res>
    implements $PollModelResponseCopyWith<$Res> {
  factory _$$PollModelResponseImplCopyWith(_$PollModelResponseImpl value,
          $Res Function(_$PollModelResponseImpl) then) =
      __$$PollModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? content,
      @JsonKey(name: 'feed_post_id') int? feedPostId,
      String? question,
      @JsonKey(name: 'allow_add_options') bool? allowAddOptions,
      @JsonKey(name: 'allow_multiple_choice') bool? allowMultipleChoice,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      List<PollOptionsModelResponse>? options});
}

/// @nodoc
class __$$PollModelResponseImplCopyWithImpl<$Res>
    extends _$PollModelResponseCopyWithImpl<$Res, _$PollModelResponseImpl>
    implements _$$PollModelResponseImplCopyWith<$Res> {
  __$$PollModelResponseImplCopyWithImpl(_$PollModelResponseImpl _value,
      $Res Function(_$PollModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? feedPostId = freezed,
    Object? question = freezed,
    Object? allowAddOptions = freezed,
    Object? allowMultipleChoice = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? options = freezed,
  }) {
    return _then(_$PollModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      feedPostId: freezed == feedPostId
          ? _value.feedPostId
          : feedPostId // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      allowAddOptions: freezed == allowAddOptions
          ? _value.allowAddOptions
          : allowAddOptions // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowMultipleChoice: freezed == allowMultipleChoice
          ? _value.allowMultipleChoice
          : allowMultipleChoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<PollOptionsModelResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollModelResponseImpl implements _PollModelResponse {
  const _$PollModelResponseImpl(
      {this.id,
      this.content,
      @JsonKey(name: 'feed_post_id') this.feedPostId,
      this.question,
      @JsonKey(name: 'allow_add_options') this.allowAddOptions,
      @JsonKey(name: 'allow_multiple_choice') this.allowMultipleChoice,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      final List<PollOptionsModelResponse>? options})
      : _options = options;

  factory _$PollModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? content;
  @override
  @JsonKey(name: 'feed_post_id')
  final int? feedPostId;
  @override
  final String? question;
  @override
  @JsonKey(name: 'allow_add_options')
  final bool? allowAddOptions;
  @override
  @JsonKey(name: 'allow_multiple_choice')
  final bool? allowMultipleChoice;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final List<PollOptionsModelResponse>? _options;
  @override
  List<PollOptionsModelResponse>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PollModelResponse(id: $id, content: $content, feedPostId: $feedPostId, question: $question, allowAddOptions: $allowAddOptions, allowMultipleChoice: $allowMultipleChoice, createdAt: $createdAt, updatedAt: $updatedAt, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.feedPostId, feedPostId) ||
                other.feedPostId == feedPostId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.allowAddOptions, allowAddOptions) ||
                other.allowAddOptions == allowAddOptions) &&
            (identical(other.allowMultipleChoice, allowMultipleChoice) ||
                other.allowMultipleChoice == allowMultipleChoice) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      feedPostId,
      question,
      allowAddOptions,
      allowMultipleChoice,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of PollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollModelResponseImplCopyWith<_$PollModelResponseImpl> get copyWith =>
      __$$PollModelResponseImplCopyWithImpl<_$PollModelResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollModelResponseImplToJson(
      this,
    );
  }
}

abstract class _PollModelResponse implements PollModelResponse {
  const factory _PollModelResponse(
      {final int? id,
      final String? content,
      @JsonKey(name: 'feed_post_id') final int? feedPostId,
      final String? question,
      @JsonKey(name: 'allow_add_options') final bool? allowAddOptions,
      @JsonKey(name: 'allow_multiple_choice') final bool? allowMultipleChoice,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      final List<PollOptionsModelResponse>? options}) = _$PollModelResponseImpl;

  factory _PollModelResponse.fromJson(Map<String, dynamic> json) =
      _$PollModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get content;
  @override
  @JsonKey(name: 'feed_post_id')
  int? get feedPostId;
  @override
  String? get question;
  @override
  @JsonKey(name: 'allow_add_options')
  bool? get allowAddOptions;
  @override
  @JsonKey(name: 'allow_multiple_choice')
  bool? get allowMultipleChoice;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  List<PollOptionsModelResponse>? get options;

  /// Create a copy of PollModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollModelResponseImplCopyWith<_$PollModelResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PollOptionsModelResponse _$PollOptionsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _PollOptionsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$PollOptionsModelResponse {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'poll_id')
  int? get pollId => throw _privateConstructorUsedError;
  @JsonKey(name: 'option_text')
  String? get optionText => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'votes_count')
  int? get votesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_voted')
  bool? get isVoted => throw _privateConstructorUsedError;

  /// Serializes this PollOptionsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PollOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PollOptionsModelResponseCopyWith<PollOptionsModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollOptionsModelResponseCopyWith<$Res> {
  factory $PollOptionsModelResponseCopyWith(PollOptionsModelResponse value,
          $Res Function(PollOptionsModelResponse) then) =
      _$PollOptionsModelResponseCopyWithImpl<$Res, PollOptionsModelResponse>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'poll_id') int? pollId,
      @JsonKey(name: 'option_text') String? optionText,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'votes_count') int? votesCount,
      @JsonKey(name: 'is_voted') bool? isVoted});
}

/// @nodoc
class _$PollOptionsModelResponseCopyWithImpl<$Res,
        $Val extends PollOptionsModelResponse>
    implements $PollOptionsModelResponseCopyWith<$Res> {
  _$PollOptionsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PollOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pollId = freezed,
    Object? optionText = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? votesCount = freezed,
    Object? isVoted = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int?,
      optionText: freezed == optionText
          ? _value.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      votesCount: freezed == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PollOptionsModelResponseImplCopyWith<$Res>
    implements $PollOptionsModelResponseCopyWith<$Res> {
  factory _$$PollOptionsModelResponseImplCopyWith(
          _$PollOptionsModelResponseImpl value,
          $Res Function(_$PollOptionsModelResponseImpl) then) =
      __$$PollOptionsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'poll_id') int? pollId,
      @JsonKey(name: 'option_text') String? optionText,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'votes_count') int? votesCount,
      @JsonKey(name: 'is_voted') bool? isVoted});
}

/// @nodoc
class __$$PollOptionsModelResponseImplCopyWithImpl<$Res>
    extends _$PollOptionsModelResponseCopyWithImpl<$Res,
        _$PollOptionsModelResponseImpl>
    implements _$$PollOptionsModelResponseImplCopyWith<$Res> {
  __$$PollOptionsModelResponseImplCopyWithImpl(
      _$PollOptionsModelResponseImpl _value,
      $Res Function(_$PollOptionsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PollOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pollId = freezed,
    Object? optionText = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? votesCount = freezed,
    Object? isVoted = freezed,
  }) {
    return _then(_$PollOptionsModelResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pollId: freezed == pollId
          ? _value.pollId
          : pollId // ignore: cast_nullable_to_non_nullable
              as int?,
      optionText: freezed == optionText
          ? _value.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      votesCount: freezed == votesCount
          ? _value.votesCount
          : votesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isVoted: freezed == isVoted
          ? _value.isVoted
          : isVoted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PollOptionsModelResponseImpl implements _PollOptionsModelResponse {
  const _$PollOptionsModelResponseImpl(
      {this.id,
      @JsonKey(name: 'poll_id') this.pollId,
      @JsonKey(name: 'option_text') this.optionText,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'votes_count') this.votesCount,
      @JsonKey(name: 'is_voted') this.isVoted});

  factory _$PollOptionsModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PollOptionsModelResponseImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'poll_id')
  final int? pollId;
  @override
  @JsonKey(name: 'option_text')
  final String? optionText;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'votes_count')
  final int? votesCount;
  @override
  @JsonKey(name: 'is_voted')
  final bool? isVoted;

  @override
  String toString() {
    return 'PollOptionsModelResponse(id: $id, pollId: $pollId, optionText: $optionText, createdAt: $createdAt, updatedAt: $updatedAt, votesCount: $votesCount, isVoted: $isVoted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollOptionsModelResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pollId, pollId) || other.pollId == pollId) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.votesCount, votesCount) ||
                other.votesCount == votesCount) &&
            (identical(other.isVoted, isVoted) || other.isVoted == isVoted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, pollId, optionText,
      createdAt, updatedAt, votesCount, isVoted);

  /// Create a copy of PollOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollOptionsModelResponseImplCopyWith<_$PollOptionsModelResponseImpl>
      get copyWith => __$$PollOptionsModelResponseImplCopyWithImpl<
          _$PollOptionsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PollOptionsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _PollOptionsModelResponse implements PollOptionsModelResponse {
  const factory _PollOptionsModelResponse(
          {final int? id,
          @JsonKey(name: 'poll_id') final int? pollId,
          @JsonKey(name: 'option_text') final String? optionText,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'votes_count') final int? votesCount,
          @JsonKey(name: 'is_voted') final bool? isVoted}) =
      _$PollOptionsModelResponseImpl;

  factory _PollOptionsModelResponse.fromJson(Map<String, dynamic> json) =
      _$PollOptionsModelResponseImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'poll_id')
  int? get pollId;
  @override
  @JsonKey(name: 'option_text')
  String? get optionText;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'votes_count')
  int? get votesCount;
  @override
  @JsonKey(name: 'is_voted')
  bool? get isVoted;

  /// Create a copy of PollOptionsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollOptionsModelResponseImplCopyWith<_$PollOptionsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GroupDetails _$GroupDetailsFromJson(Map<String, dynamic> json) {
  return _GroupDetails.fromJson(json);
}

/// @nodoc
mixin _$GroupDetails {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this GroupDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupDetailsCopyWith<GroupDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDetailsCopyWith<$Res> {
  factory $GroupDetailsCopyWith(
          GroupDetails value, $Res Function(GroupDetails) then) =
      _$GroupDetailsCopyWithImpl<$Res, GroupDetails>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$GroupDetailsCopyWithImpl<$Res, $Val extends GroupDetails>
    implements $GroupDetailsCopyWith<$Res> {
  _$GroupDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupDetailsImplCopyWith<$Res>
    implements $GroupDetailsCopyWith<$Res> {
  factory _$$GroupDetailsImplCopyWith(
          _$GroupDetailsImpl value, $Res Function(_$GroupDetailsImpl) then) =
      __$$GroupDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$GroupDetailsImplCopyWithImpl<$Res>
    extends _$GroupDetailsCopyWithImpl<$Res, _$GroupDetailsImpl>
    implements _$$GroupDetailsImplCopyWith<$Res> {
  __$$GroupDetailsImplCopyWithImpl(
      _$GroupDetailsImpl _value, $Res Function(_$GroupDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$GroupDetailsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupDetailsImpl implements _GroupDetails {
  const _$GroupDetailsImpl({this.id, this.name});

  factory _$GroupDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupDetailsImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'GroupDetails(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of GroupDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailsImplCopyWith<_$GroupDetailsImpl> get copyWith =>
      __$$GroupDetailsImplCopyWithImpl<_$GroupDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupDetailsImplToJson(
      this,
    );
  }
}

abstract class _GroupDetails implements GroupDetails {
  const factory _GroupDetails({final int? id, final String? name}) =
      _$GroupDetailsImpl;

  factory _GroupDetails.fromJson(Map<String, dynamic> json) =
      _$GroupDetailsImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of GroupDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupDetailsImplCopyWith<_$GroupDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
