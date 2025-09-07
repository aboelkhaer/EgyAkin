// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_all_notifications_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAllNotificationsModelResponse _$GetAllNotificationsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAllNotificationsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAllNotificationsModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  String? get unreadCount => throw _privateConstructorUsedError;
  List<NotificationsModel>? get todayRecords =>
      throw _privateConstructorUsedError;
  RecentNotificationForPagenationModel? get recentRecords =>
      throw _privateConstructorUsedError;

  /// Serializes this GetAllNotificationsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetAllNotificationsModelResponseCopyWith<GetAllNotificationsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAllNotificationsModelResponseCopyWith<$Res> {
  factory $GetAllNotificationsModelResponseCopyWith(
          GetAllNotificationsModelResponse value,
          $Res Function(GetAllNotificationsModelResponse) then) =
      _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
          GetAllNotificationsModelResponse>;
  @useResult
  $Res call(
      {bool? value,
      String? unreadCount,
      List<NotificationsModel>? todayRecords,
      RecentNotificationForPagenationModel? recentRecords});

  $RecentNotificationForPagenationModelCopyWith<$Res>? get recentRecords;
}

/// @nodoc
class _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
        $Val extends GetAllNotificationsModelResponse>
    implements $GetAllNotificationsModelResponseCopyWith<$Res> {
  _$GetAllNotificationsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? todayRecords = freezed,
    Object? recentRecords = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      todayRecords: freezed == todayRecords
          ? _value.todayRecords
          : todayRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
      recentRecords: freezed == recentRecords
          ? _value.recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as RecentNotificationForPagenationModel?,
    ) as $Val);
  }

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecentNotificationForPagenationModelCopyWith<$Res>? get recentRecords {
    if (_value.recentRecords == null) {
      return null;
    }

    return $RecentNotificationForPagenationModelCopyWith<$Res>(
        _value.recentRecords!, (value) {
      return _then(_value.copyWith(recentRecords: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetAllNotificationsModelResponseImplCopyWith<$Res>
    implements $GetAllNotificationsModelResponseCopyWith<$Res> {
  factory _$$GetAllNotificationsModelResponseImplCopyWith(
          _$GetAllNotificationsModelResponseImpl value,
          $Res Function(_$GetAllNotificationsModelResponseImpl) then) =
      __$$GetAllNotificationsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? value,
      String? unreadCount,
      List<NotificationsModel>? todayRecords,
      RecentNotificationForPagenationModel? recentRecords});

  @override
  $RecentNotificationForPagenationModelCopyWith<$Res>? get recentRecords;
}

/// @nodoc
class __$$GetAllNotificationsModelResponseImplCopyWithImpl<$Res>
    extends _$GetAllNotificationsModelResponseCopyWithImpl<$Res,
        _$GetAllNotificationsModelResponseImpl>
    implements _$$GetAllNotificationsModelResponseImplCopyWith<$Res> {
  __$$GetAllNotificationsModelResponseImplCopyWithImpl(
      _$GetAllNotificationsModelResponseImpl _value,
      $Res Function(_$GetAllNotificationsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? unreadCount = freezed,
    Object? todayRecords = freezed,
    Object? recentRecords = freezed,
  }) {
    return _then(_$GetAllNotificationsModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as String?,
      todayRecords: freezed == todayRecords
          ? _value._todayRecords
          : todayRecords // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
      recentRecords: freezed == recentRecords
          ? _value.recentRecords
          : recentRecords // ignore: cast_nullable_to_non_nullable
              as RecentNotificationForPagenationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAllNotificationsModelResponseImpl
    implements _GetAllNotificationsModelResponse {
  const _$GetAllNotificationsModelResponseImpl(
      {this.value,
      this.unreadCount,
      final List<NotificationsModel>? todayRecords,
      this.recentRecords})
      : _todayRecords = todayRecords;

  factory _$GetAllNotificationsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAllNotificationsModelResponseImplFromJson(json);

  @override
  final bool? value;
  @override
  final String? unreadCount;
  final List<NotificationsModel>? _todayRecords;
  @override
  List<NotificationsModel>? get todayRecords {
    final value = _todayRecords;
    if (value == null) return null;
    if (_todayRecords is EqualUnmodifiableListView) return _todayRecords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final RecentNotificationForPagenationModel? recentRecords;

  @override
  String toString() {
    return 'GetAllNotificationsModelResponse(value: $value, unreadCount: $unreadCount, todayRecords: $todayRecords, recentRecords: $recentRecords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllNotificationsModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            const DeepCollectionEquality()
                .equals(other._todayRecords, _todayRecords) &&
            (identical(other.recentRecords, recentRecords) ||
                other.recentRecords == recentRecords));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, unreadCount,
      const DeepCollectionEquality().hash(_todayRecords), recentRecords);

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllNotificationsModelResponseImplCopyWith<
          _$GetAllNotificationsModelResponseImpl>
      get copyWith => __$$GetAllNotificationsModelResponseImplCopyWithImpl<
          _$GetAllNotificationsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAllNotificationsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAllNotificationsModelResponse
    implements GetAllNotificationsModelResponse {
  const factory _GetAllNotificationsModelResponse(
          {final bool? value,
          final String? unreadCount,
          final List<NotificationsModel>? todayRecords,
          final RecentNotificationForPagenationModel? recentRecords}) =
      _$GetAllNotificationsModelResponseImpl;

  factory _GetAllNotificationsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetAllNotificationsModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  String? get unreadCount;
  @override
  List<NotificationsModel>? get todayRecords;
  @override
  RecentNotificationForPagenationModel? get recentRecords;

  /// Create a copy of GetAllNotificationsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllNotificationsModelResponseImplCopyWith<
          _$GetAllNotificationsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RecentNotificationForPagenationModel
    _$RecentNotificationForPagenationModelFromJson(Map<String, dynamic> json) {
  return _RecentNotificationForPagenationModel.fromJson(json);
}

/// @nodoc
mixin _$RecentNotificationForPagenationModel {
  List<NotificationsModel>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
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

  /// Serializes this RecentNotificationForPagenationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecentNotificationForPagenationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentNotificationForPagenationModelCopyWith<
          RecentNotificationForPagenationModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentNotificationForPagenationModelCopyWith<$Res> {
  factory $RecentNotificationForPagenationModelCopyWith(
          RecentNotificationForPagenationModel value,
          $Res Function(RecentNotificationForPagenationModel) then) =
      _$RecentNotificationForPagenationModelCopyWithImpl<$Res,
          RecentNotificationForPagenationModel>;
  @useResult
  $Res call(
      {List<NotificationsModel>? data,
      @JsonKey(name: 'current_page') int? currentPage,
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
class _$RecentNotificationForPagenationModelCopyWithImpl<$Res,
        $Val extends RecentNotificationForPagenationModel>
    implements $RecentNotificationForPagenationModelCopyWith<$Res> {
  _$RecentNotificationForPagenationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentNotificationForPagenationModel
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
    Object? links = freezed,
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
              as List<NotificationsModel>?,
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
abstract class _$$RecentNotificationForPagenationModelImplCopyWith<$Res>
    implements $RecentNotificationForPagenationModelCopyWith<$Res> {
  factory _$$RecentNotificationForPagenationModelImplCopyWith(
          _$RecentNotificationForPagenationModelImpl value,
          $Res Function(_$RecentNotificationForPagenationModelImpl) then) =
      __$$RecentNotificationForPagenationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NotificationsModel>? data,
      @JsonKey(name: 'current_page') int? currentPage,
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
class __$$RecentNotificationForPagenationModelImplCopyWithImpl<$Res>
    extends _$RecentNotificationForPagenationModelCopyWithImpl<$Res,
        _$RecentNotificationForPagenationModelImpl>
    implements _$$RecentNotificationForPagenationModelImplCopyWith<$Res> {
  __$$RecentNotificationForPagenationModelImplCopyWithImpl(
      _$RecentNotificationForPagenationModelImpl _value,
      $Res Function(_$RecentNotificationForPagenationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecentNotificationForPagenationModel
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
    Object? links = freezed,
    Object? nextPageUrl = freezed,
    Object? path = freezed,
    Object? perPage = freezed,
    Object? prevPageUrl = freezed,
    Object? to = freezed,
    Object? total = freezed,
  }) {
    return _then(_$RecentNotificationForPagenationModelImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<NotificationsModel>?,
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
class _$RecentNotificationForPagenationModelImpl
    implements _RecentNotificationForPagenationModel {
  const _$RecentNotificationForPagenationModelImpl(
      {final List<NotificationsModel>? data,
      @JsonKey(name: 'current_page') this.currentPage,
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

  factory _$RecentNotificationForPagenationModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RecentNotificationForPagenationModelImplFromJson(json);

  final List<NotificationsModel>? _data;
  @override
  List<NotificationsModel>? get data {
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
    return 'RecentNotificationForPagenationModel(data: $data, currentPage: $currentPage, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentNotificationForPagenationModelImpl &&
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
      const DeepCollectionEquality().hash(_data),
      currentPage,
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

  /// Create a copy of RecentNotificationForPagenationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentNotificationForPagenationModelImplCopyWith<
          _$RecentNotificationForPagenationModelImpl>
      get copyWith => __$$RecentNotificationForPagenationModelImplCopyWithImpl<
          _$RecentNotificationForPagenationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentNotificationForPagenationModelImplToJson(
      this,
    );
  }
}

abstract class _RecentNotificationForPagenationModel
    implements RecentNotificationForPagenationModel {
  const factory _RecentNotificationForPagenationModel(
      {final List<NotificationsModel>? data,
      @JsonKey(name: 'current_page') final int? currentPage,
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
      final int? total}) = _$RecentNotificationForPagenationModelImpl;

  factory _RecentNotificationForPagenationModel.fromJson(
          Map<String, dynamic> json) =
      _$RecentNotificationForPagenationModelImpl.fromJson;

  @override
  List<NotificationsModel>? get data;
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

  /// Create a copy of RecentNotificationForPagenationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentNotificationForPagenationModelImplCopyWith<
          _$RecentNotificationForPagenationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationsModel _$NotificationsModelFromJson(Map<String, dynamic> json) {
  return _NotificationsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationsModel {
  int? get id => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_open')
  bool? get isOpen => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_id')
  int? get typeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  PatientNotificationModel? get patient => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_doctor')
  TypeDoctorForNotificationModel? get typeDoctor =>
      throw _privateConstructorUsedError;

  /// Serializes this NotificationsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationsModelCopyWith<NotificationsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsModelCopyWith<$Res> {
  factory $NotificationsModelCopyWith(
          NotificationsModel value, $Res Function(NotificationsModel) then) =
      _$NotificationsModelCopyWithImpl<$Res, NotificationsModel>;
  @useResult
  $Res call(
      {int? id,
      bool? read,
      String? type,
      String? content,
      @JsonKey(name: 'is_open') bool? isOpen,
      @JsonKey(name: 'type_id') int? typeId,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationModel? patient,
      @JsonKey(name: 'type_doctor')
      TypeDoctorForNotificationModel? typeDoctor});

  $PatientNotificationModelCopyWith<$Res>? get patient;
  $TypeDoctorForNotificationModelCopyWith<$Res>? get typeDoctor;
}

/// @nodoc
class _$NotificationsModelCopyWithImpl<$Res, $Val extends NotificationsModel>
    implements $NotificationsModelCopyWith<$Res> {
  _$NotificationsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? isOpen = freezed,
    Object? typeId = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
    Object? typeDoctor = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationModel?,
      typeDoctor: freezed == typeDoctor
          ? _value.typeDoctor
          : typeDoctor // ignore: cast_nullable_to_non_nullable
              as TypeDoctorForNotificationModel?,
    ) as $Val);
  }

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PatientNotificationModelCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $PatientNotificationModelCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeDoctorForNotificationModelCopyWith<$Res>? get typeDoctor {
    if (_value.typeDoctor == null) {
      return null;
    }

    return $TypeDoctorForNotificationModelCopyWith<$Res>(_value.typeDoctor!,
        (value) {
      return _then(_value.copyWith(typeDoctor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationsModelImplCopyWith<$Res>
    implements $NotificationsModelCopyWith<$Res> {
  factory _$$NotificationsModelImplCopyWith(_$NotificationsModelImpl value,
          $Res Function(_$NotificationsModelImpl) then) =
      __$$NotificationsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      bool? read,
      String? type,
      String? content,
      @JsonKey(name: 'is_open') bool? isOpen,
      @JsonKey(name: 'type_id') int? typeId,
      @JsonKey(name: 'created_at') String? createdAt,
      PatientNotificationModel? patient,
      @JsonKey(name: 'type_doctor')
      TypeDoctorForNotificationModel? typeDoctor});

  @override
  $PatientNotificationModelCopyWith<$Res>? get patient;
  @override
  $TypeDoctorForNotificationModelCopyWith<$Res>? get typeDoctor;
}

/// @nodoc
class __$$NotificationsModelImplCopyWithImpl<$Res>
    extends _$NotificationsModelCopyWithImpl<$Res, _$NotificationsModelImpl>
    implements _$$NotificationsModelImplCopyWith<$Res> {
  __$$NotificationsModelImplCopyWithImpl(_$NotificationsModelImpl _value,
      $Res Function(_$NotificationsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? read = freezed,
    Object? type = freezed,
    Object? content = freezed,
    Object? isOpen = freezed,
    Object? typeId = freezed,
    Object? createdAt = freezed,
    Object? patient = freezed,
    Object? typeDoctor = freezed,
  }) {
    return _then(_$NotificationsModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      typeId: freezed == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      patient: freezed == patient
          ? _value.patient
          : patient // ignore: cast_nullable_to_non_nullable
              as PatientNotificationModel?,
      typeDoctor: freezed == typeDoctor
          ? _value.typeDoctor
          : typeDoctor // ignore: cast_nullable_to_non_nullable
              as TypeDoctorForNotificationModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationsModelImpl implements _NotificationsModel {
  const _$NotificationsModelImpl(
      {this.id,
      this.read,
      this.type,
      this.content,
      @JsonKey(name: 'is_open') this.isOpen,
      @JsonKey(name: 'type_id') this.typeId,
      @JsonKey(name: 'created_at') this.createdAt,
      this.patient,
      @JsonKey(name: 'type_doctor') this.typeDoctor});

  factory _$NotificationsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationsModelImplFromJson(json);

  @override
  final int? id;
  @override
  final bool? read;
  @override
  final String? type;
  @override
  final String? content;
  @override
  @JsonKey(name: 'is_open')
  final bool? isOpen;
  @override
  @JsonKey(name: 'type_id')
  final int? typeId;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  final PatientNotificationModel? patient;
  @override
  @JsonKey(name: 'type_doctor')
  final TypeDoctorForNotificationModel? typeDoctor;

  @override
  String toString() {
    return 'NotificationsModel(id: $id, read: $read, type: $type, content: $content, isOpen: $isOpen, typeId: $typeId, createdAt: $createdAt, patient: $patient, typeDoctor: $typeDoctor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            (identical(other.typeDoctor, typeDoctor) ||
                other.typeDoctor == typeDoctor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, read, type, content, isOpen,
      typeId, createdAt, patient, typeDoctor);

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      __$$NotificationsModelImplCopyWithImpl<_$NotificationsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationsModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationsModel implements NotificationsModel {
  const factory _NotificationsModel(
          {final int? id,
          final bool? read,
          final String? type,
          final String? content,
          @JsonKey(name: 'is_open') final bool? isOpen,
          @JsonKey(name: 'type_id') final int? typeId,
          @JsonKey(name: 'created_at') final String? createdAt,
          final PatientNotificationModel? patient,
          @JsonKey(name: 'type_doctor')
          final TypeDoctorForNotificationModel? typeDoctor}) =
      _$NotificationsModelImpl;

  factory _NotificationsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationsModelImpl.fromJson;

  @override
  int? get id;
  @override
  bool? get read;
  @override
  String? get type;
  @override
  String? get content;
  @override
  @JsonKey(name: 'is_open')
  bool? get isOpen;
  @override
  @JsonKey(name: 'type_id')
  int? get typeId;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  PatientNotificationModel? get patient;
  @override
  @JsonKey(name: 'type_doctor')
  TypeDoctorForNotificationModel? get typeDoctor;

  /// Create a copy of NotificationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsModelImplCopyWith<_$NotificationsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TypeDoctorForNotificationModel _$TypeDoctorForNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _TypeDoctorForNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$TypeDoctorForNotificationModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'lname')
  String? get lastName => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get isSyndicateCardRequired => throw _privateConstructorUsedError;

  /// Serializes this TypeDoctorForNotificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TypeDoctorForNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeDoctorForNotificationModelCopyWith<TypeDoctorForNotificationModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeDoctorForNotificationModelCopyWith<$Res> {
  factory $TypeDoctorForNotificationModelCopyWith(
          TypeDoctorForNotificationModel value,
          $Res Function(TypeDoctorForNotificationModel) then) =
      _$TypeDoctorForNotificationModelCopyWithImpl<$Res,
          TypeDoctorForNotificationModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace,
      String? image,
      String? isSyndicateCardRequired});
}

/// @nodoc
class _$TypeDoctorForNotificationModelCopyWithImpl<$Res,
        $Val extends TypeDoctorForNotificationModel>
    implements $TypeDoctorForNotificationModelCopyWith<$Res> {
  _$TypeDoctorForNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeDoctorForNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? workingplace = freezed,
    Object? image = freezed,
    Object? isSyndicateCardRequired = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypeDoctorForNotificationModelImplCopyWith<$Res>
    implements $TypeDoctorForNotificationModelCopyWith<$Res> {
  factory _$$TypeDoctorForNotificationModelImplCopyWith(
          _$TypeDoctorForNotificationModelImpl value,
          $Res Function(_$TypeDoctorForNotificationModelImpl) then) =
      __$$TypeDoctorForNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'name') String? firstName,
      @JsonKey(name: 'lname') String? lastName,
      String? workingplace,
      String? image,
      String? isSyndicateCardRequired});
}

/// @nodoc
class __$$TypeDoctorForNotificationModelImplCopyWithImpl<$Res>
    extends _$TypeDoctorForNotificationModelCopyWithImpl<$Res,
        _$TypeDoctorForNotificationModelImpl>
    implements _$$TypeDoctorForNotificationModelImplCopyWith<$Res> {
  __$$TypeDoctorForNotificationModelImplCopyWithImpl(
      _$TypeDoctorForNotificationModelImpl _value,
      $Res Function(_$TypeDoctorForNotificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypeDoctorForNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? workingplace = freezed,
    Object? image = freezed,
    Object? isSyndicateCardRequired = freezed,
  }) {
    return _then(_$TypeDoctorForNotificationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isSyndicateCardRequired: freezed == isSyndicateCardRequired
          ? _value.isSyndicateCardRequired
          : isSyndicateCardRequired // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypeDoctorForNotificationModelImpl
    implements _TypeDoctorForNotificationModel {
  const _$TypeDoctorForNotificationModelImpl(
      {this.id,
      @JsonKey(name: 'name') this.firstName,
      @JsonKey(name: 'lname') this.lastName,
      this.workingplace,
      this.image,
      this.isSyndicateCardRequired});

  factory _$TypeDoctorForNotificationModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TypeDoctorForNotificationModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? firstName;
  @override
  @JsonKey(name: 'lname')
  final String? lastName;
  @override
  final String? workingplace;
  @override
  final String? image;
  @override
  final String? isSyndicateCardRequired;

  @override
  String toString() {
    return 'TypeDoctorForNotificationModel(id: $id, firstName: $firstName, lastName: $lastName, workingplace: $workingplace, image: $image, isSyndicateCardRequired: $isSyndicateCardRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeDoctorForNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(
                    other.isSyndicateCardRequired, isSyndicateCardRequired) ||
                other.isSyndicateCardRequired == isSyndicateCardRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName,
      workingplace, image, isSyndicateCardRequired);

  /// Create a copy of TypeDoctorForNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeDoctorForNotificationModelImplCopyWith<
          _$TypeDoctorForNotificationModelImpl>
      get copyWith => __$$TypeDoctorForNotificationModelImplCopyWithImpl<
          _$TypeDoctorForNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypeDoctorForNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _TypeDoctorForNotificationModel
    implements TypeDoctorForNotificationModel {
  const factory _TypeDoctorForNotificationModel(
          {final int? id,
          @JsonKey(name: 'name') final String? firstName,
          @JsonKey(name: 'lname') final String? lastName,
          final String? workingplace,
          final String? image,
          final String? isSyndicateCardRequired}) =
      _$TypeDoctorForNotificationModelImpl;

  factory _TypeDoctorForNotificationModel.fromJson(Map<String, dynamic> json) =
      _$TypeDoctorForNotificationModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'name')
  String? get firstName;
  @override
  @JsonKey(name: 'lname')
  String? get lastName;
  @override
  String? get workingplace;
  @override
  String? get image;
  @override
  String? get isSyndicateCardRequired;

  /// Create a copy of TypeDoctorForNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeDoctorForNotificationModelImplCopyWith<
          _$TypeDoctorForNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PatientNotificationModel _$PatientNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _PatientNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$PatientNotificationModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get hospital => throw _privateConstructorUsedError;
  String? get governorate => throw _privateConstructorUsedError;
  DoctorModel? get doctor => throw _privateConstructorUsedError;
  SectionsNotificationDataModel? get sections =>
      throw _privateConstructorUsedError;

  /// Serializes this PatientNotificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientNotificationModelCopyWith<PatientNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientNotificationModelCopyWith<$Res> {
  factory $PatientNotificationModelCopyWith(PatientNotificationModel value,
          $Res Function(PatientNotificationModel) then) =
      _$PatientNotificationModelCopyWithImpl<$Res, PatientNotificationModel>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorModel? doctor,
      SectionsNotificationDataModel? sections});

  $DoctorModelCopyWith<$Res>? get doctor;
  $SectionsNotificationDataModelCopyWith<$Res>? get sections;
}

/// @nodoc
class _$PatientNotificationModelCopyWithImpl<$Res,
        $Val extends PatientNotificationModel>
    implements $PatientNotificationModelCopyWith<$Res> {
  _$PatientNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? governorate = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      governorate: freezed == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModel?,
    ) as $Val);
  }

  /// Create a copy of PatientNotificationModel
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

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionsNotificationDataModelCopyWith<$Res>? get sections {
    if (_value.sections == null) {
      return null;
    }

    return $SectionsNotificationDataModelCopyWith<$Res>(_value.sections!,
        (value) {
      return _then(_value.copyWith(sections: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatientNotificationModelImplCopyWith<$Res>
    implements $PatientNotificationModelCopyWith<$Res> {
  factory _$$PatientNotificationModelImplCopyWith(
          _$PatientNotificationModelImpl value,
          $Res Function(_$PatientNotificationModelImpl) then) =
      __$$PatientNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? hospital,
      String? governorate,
      DoctorModel? doctor,
      SectionsNotificationDataModel? sections});

  @override
  $DoctorModelCopyWith<$Res>? get doctor;
  @override
  $SectionsNotificationDataModelCopyWith<$Res>? get sections;
}

/// @nodoc
class __$$PatientNotificationModelImplCopyWithImpl<$Res>
    extends _$PatientNotificationModelCopyWithImpl<$Res,
        _$PatientNotificationModelImpl>
    implements _$$PatientNotificationModelImplCopyWith<$Res> {
  __$$PatientNotificationModelImplCopyWithImpl(
      _$PatientNotificationModelImpl _value,
      $Res Function(_$PatientNotificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? hospital = freezed,
    Object? governorate = freezed,
    Object? doctor = freezed,
    Object? sections = freezed,
  }) {
    return _then(_$PatientNotificationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      hospital: freezed == hospital
          ? _value.hospital
          : hospital // ignore: cast_nullable_to_non_nullable
              as String?,
      governorate: freezed == governorate
          ? _value.governorate
          : governorate // ignore: cast_nullable_to_non_nullable
              as String?,
      doctor: freezed == doctor
          ? _value.doctor
          : doctor // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
      sections: freezed == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as SectionsNotificationDataModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientNotificationModelImpl implements _PatientNotificationModel {
  const _$PatientNotificationModelImpl(
      {this.id,
      this.name,
      this.hospital,
      this.governorate,
      this.doctor,
      this.sections});

  factory _$PatientNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientNotificationModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? hospital;
  @override
  final String? governorate;
  @override
  final DoctorModel? doctor;
  @override
  final SectionsNotificationDataModel? sections;

  @override
  String toString() {
    return 'PatientNotificationModel(id: $id, name: $name, hospital: $hospital, governorate: $governorate, doctor: $doctor, sections: $sections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.hospital, hospital) ||
                other.hospital == hospital) &&
            (identical(other.governorate, governorate) ||
                other.governorate == governorate) &&
            (identical(other.doctor, doctor) || other.doctor == doctor) &&
            (identical(other.sections, sections) ||
                other.sections == sections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, hospital, governorate, doctor, sections);

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientNotificationModelImplCopyWith<_$PatientNotificationModelImpl>
      get copyWith => __$$PatientNotificationModelImplCopyWithImpl<
          _$PatientNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _PatientNotificationModel implements PatientNotificationModel {
  const factory _PatientNotificationModel(
          {final String? id,
          final String? name,
          final String? hospital,
          final String? governorate,
          final DoctorModel? doctor,
          final SectionsNotificationDataModel? sections}) =
      _$PatientNotificationModelImpl;

  factory _PatientNotificationModel.fromJson(Map<String, dynamic> json) =
      _$PatientNotificationModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get hospital;
  @override
  String? get governorate;
  @override
  DoctorModel? get doctor;
  @override
  SectionsNotificationDataModel? get sections;

  /// Create a copy of PatientNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientNotificationModelImplCopyWith<_$PatientNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SectionsNotificationDataModel _$SectionsNotificationDataModelFromJson(
    Map<String, dynamic> json) {
  return _SectionsNotificationDataModel.fromJson(json);
}

/// @nodoc
mixin _$SectionsNotificationDataModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'submit_status')
  bool? get submitStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus => throw _privateConstructorUsedError;
  String? get workingplace => throw _privateConstructorUsedError;

  /// Serializes this SectionsNotificationDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionsNotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionsNotificationDataModelCopyWith<SectionsNotificationDataModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionsNotificationDataModelCopyWith<$Res> {
  factory $SectionsNotificationDataModelCopyWith(
          SectionsNotificationDataModel value,
          $Res Function(SectionsNotificationDataModel) then) =
      _$SectionsNotificationDataModelCopyWithImpl<$Res,
          SectionsNotificationDataModel>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class _$SectionsNotificationDataModelCopyWithImpl<$Res,
        $Val extends SectionsNotificationDataModel>
    implements $SectionsNotificationDataModelCopyWith<$Res> {
  _$SectionsNotificationDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionsNotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SectionsNotificationDataModelImplCopyWith<$Res>
    implements $SectionsNotificationDataModelCopyWith<$Res> {
  factory _$$SectionsNotificationDataModelImplCopyWith(
          _$SectionsNotificationDataModelImpl value,
          $Res Function(_$SectionsNotificationDataModelImpl) then) =
      __$$SectionsNotificationDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'submit_status') bool? submitStatus,
      @JsonKey(name: 'outcome_status') bool? outcomeStatus,
      String? workingplace});
}

/// @nodoc
class __$$SectionsNotificationDataModelImplCopyWithImpl<$Res>
    extends _$SectionsNotificationDataModelCopyWithImpl<$Res,
        _$SectionsNotificationDataModelImpl>
    implements _$$SectionsNotificationDataModelImplCopyWith<$Res> {
  __$$SectionsNotificationDataModelImplCopyWithImpl(
      _$SectionsNotificationDataModelImpl _value,
      $Res Function(_$SectionsNotificationDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SectionsNotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? submitStatus = freezed,
    Object? outcomeStatus = freezed,
    Object? workingplace = freezed,
  }) {
    return _then(_$SectionsNotificationDataModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submitStatus: freezed == submitStatus
          ? _value.submitStatus
          : submitStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      outcomeStatus: freezed == outcomeStatus
          ? _value.outcomeStatus
          : outcomeStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      workingplace: freezed == workingplace
          ? _value.workingplace
          : workingplace // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionsNotificationDataModelImpl
    implements _SectionsNotificationDataModel {
  const _$SectionsNotificationDataModelImpl(
      {this.id,
      @JsonKey(name: 'submit_status') this.submitStatus,
      @JsonKey(name: 'outcome_status') this.outcomeStatus,
      this.workingplace});

  factory _$SectionsNotificationDataModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SectionsNotificationDataModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'submit_status')
  final bool? submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
  final bool? outcomeStatus;
  @override
  final String? workingplace;

  @override
  String toString() {
    return 'SectionsNotificationDataModel(id: $id, submitStatus: $submitStatus, outcomeStatus: $outcomeStatus, workingplace: $workingplace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionsNotificationDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.submitStatus, submitStatus) ||
                other.submitStatus == submitStatus) &&
            (identical(other.outcomeStatus, outcomeStatus) ||
                other.outcomeStatus == outcomeStatus) &&
            (identical(other.workingplace, workingplace) ||
                other.workingplace == workingplace));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, submitStatus, outcomeStatus, workingplace);

  /// Create a copy of SectionsNotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionsNotificationDataModelImplCopyWith<
          _$SectionsNotificationDataModelImpl>
      get copyWith => __$$SectionsNotificationDataModelImplCopyWithImpl<
          _$SectionsNotificationDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionsNotificationDataModelImplToJson(
      this,
    );
  }
}

abstract class _SectionsNotificationDataModel
    implements SectionsNotificationDataModel {
  const factory _SectionsNotificationDataModel(
      {final int? id,
      @JsonKey(name: 'submit_status') final bool? submitStatus,
      @JsonKey(name: 'outcome_status') final bool? outcomeStatus,
      final String? workingplace}) = _$SectionsNotificationDataModelImpl;

  factory _SectionsNotificationDataModel.fromJson(Map<String, dynamic> json) =
      _$SectionsNotificationDataModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'submit_status')
  bool? get submitStatus;
  @override
  @JsonKey(name: 'outcome_status')
  bool? get outcomeStatus;
  @override
  String? get workingplace;

  /// Create a copy of SectionsNotificationDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionsNotificationDataModelImplCopyWith<
          _$SectionsNotificationDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Link _$LinkFromJson(Map<String, dynamic> json) {
  return _Link.fromJson(json);
}

/// @nodoc
mixin _$Link {
  dynamic get url => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this Link to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkCopyWith<Link> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkCopyWith<$Res> {
  factory $LinkCopyWith(Link value, $Res Function(Link) then) =
      _$LinkCopyWithImpl<$Res, Link>;
  @useResult
  $Res call({dynamic url, String label, bool active});
}

/// @nodoc
class _$LinkCopyWithImpl<$Res, $Val extends Link>
    implements $LinkCopyWith<$Res> {
  _$LinkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? label = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as dynamic,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkImplCopyWith<$Res> implements $LinkCopyWith<$Res> {
  factory _$$LinkImplCopyWith(
          _$LinkImpl value, $Res Function(_$LinkImpl) then) =
      __$$LinkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic url, String label, bool active});
}

/// @nodoc
class __$$LinkImplCopyWithImpl<$Res>
    extends _$LinkCopyWithImpl<$Res, _$LinkImpl>
    implements _$$LinkImplCopyWith<$Res> {
  __$$LinkImplCopyWithImpl(_$LinkImpl _value, $Res Function(_$LinkImpl) _then)
      : super(_value, _then);

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? label = null,
    Object? active = null,
  }) {
    return _then(_$LinkImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as dynamic,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LinkImpl implements _Link {
  const _$LinkImpl(
      {required this.url, required this.label, required this.active});

  factory _$LinkImpl.fromJson(Map<String, dynamic> json) =>
      _$$LinkImplFromJson(json);

  @override
  final dynamic url;
  @override
  final String label;
  @override
  final bool active;

  @override
  String toString() {
    return 'Link(url: $url, label: $label, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkImpl &&
            const DeepCollectionEquality().equals(other.url, url) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(url), label, active);

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      __$$LinkImplCopyWithImpl<_$LinkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LinkImplToJson(
      this,
    );
  }
}

abstract class _Link implements Link {
  const factory _Link(
      {required final dynamic url,
      required final String label,
      required final bool active}) = _$LinkImpl;

  factory _Link.fromJson(Map<String, dynamic> json) = _$LinkImpl.fromJson;

  @override
  dynamic get url;
  @override
  String get label;
  @override
  bool get active;

  /// Create a copy of Link
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkImplCopyWith<_$LinkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
