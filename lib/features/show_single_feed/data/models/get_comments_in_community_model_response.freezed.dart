// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_comments_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetCommentsInCommunityModelResponse
    _$GetCommentsInCommunityModelResponseFromJson(Map<String, dynamic> json) {
  return _GetCommentsInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetCommentsInCommunityModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  PostCommentsData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this GetCommentsInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetCommentsInCommunityModelResponseCopyWith<
          GetCommentsInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCommentsInCommunityModelResponseCopyWith<$Res> {
  factory $GetCommentsInCommunityModelResponseCopyWith(
          GetCommentsInCommunityModelResponse value,
          $Res Function(GetCommentsInCommunityModelResponse) then) =
      _$GetCommentsInCommunityModelResponseCopyWithImpl<$Res,
          GetCommentsInCommunityModelResponse>;
  @useResult
  $Res call({bool? value, PostCommentsData? data, String? message});

  $PostCommentsDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetCommentsInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends GetCommentsInCommunityModelResponse>
    implements $GetCommentsInCommunityModelResponseCopyWith<$Res> {
  _$GetCommentsInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostCommentsData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCommentsDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $PostCommentsDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetCommentsInCommunityModelResponseImplCopyWith<$Res>
    implements $GetCommentsInCommunityModelResponseCopyWith<$Res> {
  factory _$$GetCommentsInCommunityModelResponseImplCopyWith(
          _$GetCommentsInCommunityModelResponseImpl value,
          $Res Function(_$GetCommentsInCommunityModelResponseImpl) then) =
      __$$GetCommentsInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, PostCommentsData? data, String? message});

  @override
  $PostCommentsDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetCommentsInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$GetCommentsInCommunityModelResponseCopyWithImpl<$Res,
        _$GetCommentsInCommunityModelResponseImpl>
    implements _$$GetCommentsInCommunityModelResponseImplCopyWith<$Res> {
  __$$GetCommentsInCommunityModelResponseImplCopyWithImpl(
      _$GetCommentsInCommunityModelResponseImpl _value,
      $Res Function(_$GetCommentsInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$GetCommentsInCommunityModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostCommentsData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetCommentsInCommunityModelResponseImpl
    implements _GetCommentsInCommunityModelResponse {
  const _$GetCommentsInCommunityModelResponseImpl(
      {this.value, this.data, this.message});

  factory _$GetCommentsInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetCommentsInCommunityModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final PostCommentsData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'GetCommentsInCommunityModelResponse(value: $value, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCommentsInCommunityModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, data, message);

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCommentsInCommunityModelResponseImplCopyWith<
          _$GetCommentsInCommunityModelResponseImpl>
      get copyWith => __$$GetCommentsInCommunityModelResponseImplCopyWithImpl<
          _$GetCommentsInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCommentsInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetCommentsInCommunityModelResponse
    implements GetCommentsInCommunityModelResponse {
  const factory _GetCommentsInCommunityModelResponse(
      {final bool? value,
      final PostCommentsData? data,
      final String? message}) = _$GetCommentsInCommunityModelResponseImpl;

  factory _GetCommentsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetCommentsInCommunityModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  PostCommentsData? get data;
  @override
  String? get message;

  /// Create a copy of GetCommentsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCommentsInCommunityModelResponseImplCopyWith<
          _$GetCommentsInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PostCommentsData _$PostCommentsDataFromJson(Map<String, dynamic> json) {
  return _PostCommentsData.fromJson(json);
}

/// @nodoc
mixin _$PostCommentsData {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  List<CommentModelInCommunity>? get data => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this PostCommentsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostCommentsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCommentsDataCopyWith<PostCommentsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommentsDataCopyWith<$Res> {
  factory $PostCommentsDataCopyWith(
          PostCommentsData value, $Res Function(PostCommentsData) then) =
      _$PostCommentsDataCopyWithImpl<$Res, PostCommentsData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<CommentModelInCommunity>? data,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      List<Link>? links,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      @JsonKey(name: 'per_page') int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class _$PostCommentsDataCopyWithImpl<$Res, $Val extends PostCommentsData>
    implements $PostCommentsDataCopyWith<$Res> {
  _$PostCommentsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostCommentsData
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
              as List<CommentModelInCommunity>?,
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
abstract class _$$PostCommentsDataImplCopyWith<$Res>
    implements $PostCommentsDataCopyWith<$Res> {
  factory _$$PostCommentsDataImplCopyWith(_$PostCommentsDataImpl value,
          $Res Function(_$PostCommentsDataImpl) then) =
      __$$PostCommentsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<CommentModelInCommunity>? data,
      @JsonKey(name: 'first_page_url') String? firstPageUrl,
      int? from,
      @JsonKey(name: 'last_page') int? lastPage,
      @JsonKey(name: 'last_page_url') String? lastPageUrl,
      List<Link>? links,
      @JsonKey(name: 'next_page_url') String? nextPageUrl,
      String? path,
      @JsonKey(name: 'per_page') int? perPage,
      @JsonKey(name: 'prev_page_url') String? prevPageUrl,
      int? to,
      int? total});
}

/// @nodoc
class __$$PostCommentsDataImplCopyWithImpl<$Res>
    extends _$PostCommentsDataCopyWithImpl<$Res, _$PostCommentsDataImpl>
    implements _$$PostCommentsDataImplCopyWith<$Res> {
  __$$PostCommentsDataImplCopyWithImpl(_$PostCommentsDataImpl _value,
      $Res Function(_$PostCommentsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostCommentsData
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
    return _then(_$PostCommentsDataImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<CommentModelInCommunity>?,
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
class _$PostCommentsDataImpl implements _PostCommentsData {
  const _$PostCommentsDataImpl(
      {@JsonKey(name: 'current_page') this.currentPage,
      final List<CommentModelInCommunity>? data,
      @JsonKey(name: 'first_page_url') this.firstPageUrl,
      this.from,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'last_page_url') this.lastPageUrl,
      final List<Link>? links,
      @JsonKey(name: 'next_page_url') this.nextPageUrl,
      this.path,
      @JsonKey(name: 'per_page') this.perPage,
      @JsonKey(name: 'prev_page_url') this.prevPageUrl,
      this.to,
      this.total})
      : _data = data,
        _links = links;

  factory _$PostCommentsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommentsDataImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<CommentModelInCommunity>? _data;
  @override
  List<CommentModelInCommunity>? get data {
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
  @JsonKey(name: 'per_page')
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
    return 'PostCommentsData(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommentsDataImpl &&
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

  /// Create a copy of PostCommentsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommentsDataImplCopyWith<_$PostCommentsDataImpl> get copyWith =>
      __$$PostCommentsDataImplCopyWithImpl<_$PostCommentsDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommentsDataImplToJson(
      this,
    );
  }
}

abstract class _PostCommentsData implements PostCommentsData {
  const factory _PostCommentsData(
      {@JsonKey(name: 'current_page') final int? currentPage,
      final List<CommentModelInCommunity>? data,
      @JsonKey(name: 'first_page_url') final String? firstPageUrl,
      final int? from,
      @JsonKey(name: 'last_page') final int? lastPage,
      @JsonKey(name: 'last_page_url') final String? lastPageUrl,
      final List<Link>? links,
      @JsonKey(name: 'next_page_url') final String? nextPageUrl,
      final String? path,
      @JsonKey(name: 'per_page') final int? perPage,
      @JsonKey(name: 'prev_page_url') final String? prevPageUrl,
      final int? to,
      final int? total}) = _$PostCommentsDataImpl;

  factory _PostCommentsData.fromJson(Map<String, dynamic> json) =
      _$PostCommentsDataImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  List<CommentModelInCommunity>? get data;
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
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  @JsonKey(name: 'prev_page_url')
  String? get prevPageUrl;
  @override
  int? get to;
  @override
  int? get total;

  /// Create a copy of PostCommentsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostCommentsDataImplCopyWith<_$PostCommentsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommentModelInCommunity _$CommentModelInCommunityFromJson(
    Map<String, dynamic> json) {
  return _CommentModelInCommunity.fromJson(json);
}

/// @nodoc
mixin _$CommentModelInCommunity {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'feed_post_id')
  int? get feedPostId => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  int? get doctorId => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  int? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int? get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'replies_count')
  int? get repliesCount => throw _privateConstructorUsedError;
  bool? get isLiked => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;
  List<CommentModelInCommunity>? get replies =>
      throw _privateConstructorUsedError;

  /// Serializes this CommentModelInCommunity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentModelInCommunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentModelInCommunityCopyWith<CommentModelInCommunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelInCommunityCopyWith<$Res> {
  factory $CommentModelInCommunityCopyWith(CommentModelInCommunity value,
          $Res Function(CommentModelInCommunity) then) =
      _$CommentModelInCommunityCopyWithImpl<$Res, CommentModelInCommunity>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'feed_post_id') int? feedPostId,
      @JsonKey(name: 'doctor_id') int? doctorId,
      String? comment,
      @JsonKey(name: 'parent_id') int? parentId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'replies_count') int? repliesCount,
      bool? isLiked,
      DoctorModel? doctor,
      List<CommentModelInCommunity>? replies});

  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class _$CommentModelInCommunityCopyWithImpl<$Res,
        $Val extends CommentModelInCommunity>
    implements $CommentModelInCommunityCopyWith<$Res> {
  _$CommentModelInCommunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentModelInCommunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? feedPostId = freezed,
    Object? doctorId = freezed,
    Object? comment = freezed,
    Object? parentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? likesCount = freezed,
    Object? repliesCount = freezed,
    Object? isLiked = freezed,
    Object? doctor = freezed,
    Object? replies = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      feedPostId: freezed == feedPostId
          ? _value.feedPostId
          : feedPostId // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      repliesCount: freezed == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<CommentModelInCommunity>?,
    ) as $Val);
  }

  /// Create a copy of CommentModelInCommunity
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
abstract class _$$CommentModelInCommunityImplCopyWith<$Res>
    implements $CommentModelInCommunityCopyWith<$Res> {
  factory _$$CommentModelInCommunityImplCopyWith(
          _$CommentModelInCommunityImpl value,
          $Res Function(_$CommentModelInCommunityImpl) then) =
      __$$CommentModelInCommunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'feed_post_id') int? feedPostId,
      @JsonKey(name: 'doctor_id') int? doctorId,
      String? comment,
      @JsonKey(name: 'parent_id') int? parentId,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'likes_count') int? likesCount,
      @JsonKey(name: 'replies_count') int? repliesCount,
      bool? isLiked,
      DoctorModel? doctor,
      List<CommentModelInCommunity>? replies});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
}

/// @nodoc
class __$$CommentModelInCommunityImplCopyWithImpl<$Res>
    extends _$CommentModelInCommunityCopyWithImpl<$Res,
        _$CommentModelInCommunityImpl>
    implements _$$CommentModelInCommunityImplCopyWith<$Res> {
  __$$CommentModelInCommunityImplCopyWithImpl(
      _$CommentModelInCommunityImpl _value,
      $Res Function(_$CommentModelInCommunityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommentModelInCommunity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? feedPostId = freezed,
    Object? doctorId = freezed,
    Object? comment = freezed,
    Object? parentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? likesCount = freezed,
    Object? repliesCount = freezed,
    Object? isLiked = freezed,
    Object? doctor = freezed,
    Object? replies = freezed,
  }) {
    return _then(_$CommentModelInCommunityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      feedPostId: freezed == feedPostId
          ? _value.feedPostId
          : feedPostId // ignore: cast_nullable_to_non_nullable
              as int?,
      doctorId: freezed == doctorId
          ? _value.doctorId
          : doctorId // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      repliesCount: freezed == repliesCount
          ? _value.repliesCount
          : repliesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      replies: freezed == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<CommentModelInCommunity>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelInCommunityImpl implements _CommentModelInCommunity {
  const _$CommentModelInCommunityImpl(
      {this.id,
      @JsonKey(name: 'feed_post_id') this.feedPostId,
      @JsonKey(name: 'doctor_id') this.doctorId,
      this.comment,
      @JsonKey(name: 'parent_id') this.parentId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'likes_count') this.likesCount,
      @JsonKey(name: 'replies_count') this.repliesCount,
      this.isLiked,
      this.doctor,
      final List<CommentModelInCommunity>? replies})
      : _replies = replies;

  factory _$CommentModelInCommunityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelInCommunityImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'feed_post_id')
  final int? feedPostId;
  @override
  @JsonKey(name: 'doctor_id')
  final int? doctorId;
  @override
  final String? comment;
  @override
  @JsonKey(name: 'parent_id')
  final int? parentId;
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
  @JsonKey(name: 'replies_count')
  final int? repliesCount;
  @override
  final bool? isLiked;
  @override
  final DoctorModel? doctor;
  final List<CommentModelInCommunity>? _replies;
  @override
  List<CommentModelInCommunity>? get replies {
    final value = _replies;
    if (value == null) return null;
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CommentModelInCommunity(id: $id, feedPostId: $feedPostId, doctorId: $doctorId, comment: $comment, parentId: $parentId, createdAt: $createdAt, updatedAt: $updatedAt, likesCount: $likesCount, repliesCount: $repliesCount, isLiked: $isLiked, doctor: $doctor, replies: $replies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelInCommunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.feedPostId, feedPostId) ||
                other.feedPostId == feedPostId) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.repliesCount, repliesCount) ||
                other.repliesCount == repliesCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      feedPostId,
      doctorId,
      comment,
      parentId,
      createdAt,
      updatedAt,
      likesCount,
      repliesCount,
      isLiked,
      doctor,
      const DeepCollectionEquality().hash(_replies));

  /// Create a copy of CommentModelInCommunity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelInCommunityImplCopyWith<_$CommentModelInCommunityImpl>
      get copyWith => __$$CommentModelInCommunityImplCopyWithImpl<
          _$CommentModelInCommunityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelInCommunityImplToJson(
      this,
    );
  }
}

abstract class _CommentModelInCommunity implements CommentModelInCommunity {
  const factory _CommentModelInCommunity(
          {final int? id,
          @JsonKey(name: 'feed_post_id') final int? feedPostId,
          @JsonKey(name: 'doctor_id') final int? doctorId,
          final String? comment,
          @JsonKey(name: 'parent_id') final int? parentId,
          @JsonKey(name: 'created_at') final String? createdAt,
          @JsonKey(name: 'updated_at') final String? updatedAt,
          @JsonKey(name: 'likes_count') final int? likesCount,
          @JsonKey(name: 'replies_count') final int? repliesCount,
          final bool? isLiked,
          final DoctorModel? doctor,
          final List<CommentModelInCommunity>? replies}) =
      _$CommentModelInCommunityImpl;

  factory _CommentModelInCommunity.fromJson(Map<String, dynamic> json) =
      _$CommentModelInCommunityImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'feed_post_id')
  int? get feedPostId;
  @override
  @JsonKey(name: 'doctor_id')
  int? get doctorId;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'parent_id')
  int? get parentId;
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
  @JsonKey(name: 'replies_count')
  int? get repliesCount;
  @override
  bool? get isLiked;
  @override
  DoctorModel? get doctor;
  @override
  List<CommentModelInCommunity>? get replies;

  /// Create a copy of CommentModelInCommunity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentModelInCommunityImplCopyWith<_$CommentModelInCommunityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
