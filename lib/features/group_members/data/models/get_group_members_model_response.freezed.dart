// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_group_members_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetGroupMembersModelResponse _$GetGroupMembersModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetGroupMembersModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetGroupMembersModelResponse {
  GetGroupMembersDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetGroupMembersModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetGroupMembersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetGroupMembersModelResponseCopyWith<GetGroupMembersModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetGroupMembersModelResponseCopyWith<$Res> {
  factory $GetGroupMembersModelResponseCopyWith(
          GetGroupMembersModelResponse value,
          $Res Function(GetGroupMembersModelResponse) then) =
      _$GetGroupMembersModelResponseCopyWithImpl<$Res,
          GetGroupMembersModelResponse>;
  @useResult
  $Res call({GetGroupMembersDataModelResponse? data});

  $GetGroupMembersDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetGroupMembersModelResponseCopyWithImpl<$Res,
        $Val extends GetGroupMembersModelResponse>
    implements $GetGroupMembersModelResponseCopyWith<$Res> {
  _$GetGroupMembersModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetGroupMembersModelResponse
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
              as GetGroupMembersDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetGroupMembersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetGroupMembersDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetGroupMembersDataModelResponseCopyWith<$Res>(_value.data!,
        (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetGroupMembersModelResponseImplCopyWith<$Res>
    implements $GetGroupMembersModelResponseCopyWith<$Res> {
  factory _$$GetGroupMembersModelResponseImplCopyWith(
          _$GetGroupMembersModelResponseImpl value,
          $Res Function(_$GetGroupMembersModelResponseImpl) then) =
      __$$GetGroupMembersModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetGroupMembersDataModelResponse? data});

  @override
  $GetGroupMembersDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetGroupMembersModelResponseImplCopyWithImpl<$Res>
    extends _$GetGroupMembersModelResponseCopyWithImpl<$Res,
        _$GetGroupMembersModelResponseImpl>
    implements _$$GetGroupMembersModelResponseImplCopyWith<$Res> {
  __$$GetGroupMembersModelResponseImplCopyWithImpl(
      _$GetGroupMembersModelResponseImpl _value,
      $Res Function(_$GetGroupMembersModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetGroupMembersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetGroupMembersModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetGroupMembersDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetGroupMembersModelResponseImpl
    implements _GetGroupMembersModelResponse {
  const _$GetGroupMembersModelResponseImpl({this.data});

  factory _$GetGroupMembersModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetGroupMembersModelResponseImplFromJson(json);

  @override
  final GetGroupMembersDataModelResponse? data;

  @override
  String toString() {
    return 'GetGroupMembersModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetGroupMembersModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetGroupMembersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetGroupMembersModelResponseImplCopyWith<
          _$GetGroupMembersModelResponseImpl>
      get copyWith => __$$GetGroupMembersModelResponseImplCopyWithImpl<
          _$GetGroupMembersModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetGroupMembersModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetGroupMembersModelResponse
    implements GetGroupMembersModelResponse {
  const factory _GetGroupMembersModelResponse(
          {final GetGroupMembersDataModelResponse? data}) =
      _$GetGroupMembersModelResponseImpl;

  factory _GetGroupMembersModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetGroupMembersModelResponseImpl.fromJson;

  @override
  GetGroupMembersDataModelResponse? get data;

  /// Create a copy of GetGroupMembersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetGroupMembersModelResponseImplCopyWith<
          _$GetGroupMembersModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetGroupMembersDataModelResponse _$GetGroupMembersDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetGroupMembersDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetGroupMembersDataModelResponse {
  MembersDataModelResponse? get members => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_invitations')
  List<DoctorModel>? get pendingInvitations =>
      throw _privateConstructorUsedError;

  /// Serializes this GetGroupMembersDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetGroupMembersDataModelResponseCopyWith<GetGroupMembersDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetGroupMembersDataModelResponseCopyWith<$Res> {
  factory $GetGroupMembersDataModelResponseCopyWith(
          GetGroupMembersDataModelResponse value,
          $Res Function(GetGroupMembersDataModelResponse) then) =
      _$GetGroupMembersDataModelResponseCopyWithImpl<$Res,
          GetGroupMembersDataModelResponse>;
  @useResult
  $Res call(
      {MembersDataModelResponse? members,
      @JsonKey(name: 'pending_invitations')
      List<DoctorModel>? pendingInvitations});

  $MembersDataModelResponseCopyWith<$Res>? get members;
}

/// @nodoc
class _$GetGroupMembersDataModelResponseCopyWithImpl<$Res,
        $Val extends GetGroupMembersDataModelResponse>
    implements $GetGroupMembersDataModelResponseCopyWith<$Res> {
  _$GetGroupMembersDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = freezed,
    Object? pendingInvitations = freezed,
  }) {
    return _then(_value.copyWith(
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as MembersDataModelResponse?,
      pendingInvitations: freezed == pendingInvitations
          ? _value.pendingInvitations
          : pendingInvitations // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
    ) as $Val);
  }

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MembersDataModelResponseCopyWith<$Res>? get members {
    if (_value.members == null) {
      return null;
    }

    return $MembersDataModelResponseCopyWith<$Res>(_value.members!, (value) {
      return _then(_value.copyWith(members: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetGroupMembersDataModelResponseImplCopyWith<$Res>
    implements $GetGroupMembersDataModelResponseCopyWith<$Res> {
  factory _$$GetGroupMembersDataModelResponseImplCopyWith(
          _$GetGroupMembersDataModelResponseImpl value,
          $Res Function(_$GetGroupMembersDataModelResponseImpl) then) =
      __$$GetGroupMembersDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MembersDataModelResponse? members,
      @JsonKey(name: 'pending_invitations')
      List<DoctorModel>? pendingInvitations});

  @override
  $MembersDataModelResponseCopyWith<$Res>? get members;
}

/// @nodoc
class __$$GetGroupMembersDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetGroupMembersDataModelResponseCopyWithImpl<$Res,
        _$GetGroupMembersDataModelResponseImpl>
    implements _$$GetGroupMembersDataModelResponseImplCopyWith<$Res> {
  __$$GetGroupMembersDataModelResponseImplCopyWithImpl(
      _$GetGroupMembersDataModelResponseImpl _value,
      $Res Function(_$GetGroupMembersDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = freezed,
    Object? pendingInvitations = freezed,
  }) {
    return _then(_$GetGroupMembersDataModelResponseImpl(
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as MembersDataModelResponse?,
      pendingInvitations: freezed == pendingInvitations
          ? _value._pendingInvitations
          : pendingInvitations // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetGroupMembersDataModelResponseImpl
    implements _GetGroupMembersDataModelResponse {
  const _$GetGroupMembersDataModelResponseImpl(
      {this.members,
      @JsonKey(name: 'pending_invitations')
      final List<DoctorModel>? pendingInvitations})
      : _pendingInvitations = pendingInvitations;

  factory _$GetGroupMembersDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetGroupMembersDataModelResponseImplFromJson(json);

  @override
  final MembersDataModelResponse? members;
  final List<DoctorModel>? _pendingInvitations;
  @override
  @JsonKey(name: 'pending_invitations')
  List<DoctorModel>? get pendingInvitations {
    final value = _pendingInvitations;
    if (value == null) return null;
    if (_pendingInvitations is EqualUnmodifiableListView)
      return _pendingInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetGroupMembersDataModelResponse(members: $members, pendingInvitations: $pendingInvitations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetGroupMembersDataModelResponseImpl &&
            (identical(other.members, members) || other.members == members) &&
            const DeepCollectionEquality()
                .equals(other._pendingInvitations, _pendingInvitations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, members,
      const DeepCollectionEquality().hash(_pendingInvitations));

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetGroupMembersDataModelResponseImplCopyWith<
          _$GetGroupMembersDataModelResponseImpl>
      get copyWith => __$$GetGroupMembersDataModelResponseImplCopyWithImpl<
          _$GetGroupMembersDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetGroupMembersDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetGroupMembersDataModelResponse
    implements GetGroupMembersDataModelResponse {
  const factory _GetGroupMembersDataModelResponse(
          {final MembersDataModelResponse? members,
          @JsonKey(name: 'pending_invitations')
          final List<DoctorModel>? pendingInvitations}) =
      _$GetGroupMembersDataModelResponseImpl;

  factory _GetGroupMembersDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetGroupMembersDataModelResponseImpl.fromJson;

  @override
  MembersDataModelResponse? get members;
  @override
  @JsonKey(name: 'pending_invitations')
  List<DoctorModel>? get pendingInvitations;

  /// Create a copy of GetGroupMembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetGroupMembersDataModelResponseImplCopyWith<
          _$GetGroupMembersDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MembersDataModelResponse _$MembersDataModelResponseFromJson(
    Map<String, dynamic> json) {
  return _MembersDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$MembersDataModelResponse {
  @JsonKey(name: 'current_page')
  int? get currentPage => throw _privateConstructorUsedError;
  List<DoctorModel>? get data => throw _privateConstructorUsedError;
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

  /// Serializes this MembersDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MembersDataModelResponseCopyWith<MembersDataModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MembersDataModelResponseCopyWith<$Res> {
  factory $MembersDataModelResponseCopyWith(MembersDataModelResponse value,
          $Res Function(MembersDataModelResponse) then) =
      _$MembersDataModelResponseCopyWithImpl<$Res, MembersDataModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<DoctorModel>? data,
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
class _$MembersDataModelResponseCopyWithImpl<$Res,
        $Val extends MembersDataModelResponse>
    implements $MembersDataModelResponseCopyWith<$Res> {
  _$MembersDataModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MembersDataModelResponse
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
              as List<DoctorModel>?,
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
abstract class _$$MembersDataModelResponseImplCopyWith<$Res>
    implements $MembersDataModelResponseCopyWith<$Res> {
  factory _$$MembersDataModelResponseImplCopyWith(
          _$MembersDataModelResponseImpl value,
          $Res Function(_$MembersDataModelResponseImpl) then) =
      __$$MembersDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int? currentPage,
      List<DoctorModel>? data,
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
class __$$MembersDataModelResponseImplCopyWithImpl<$Res>
    extends _$MembersDataModelResponseCopyWithImpl<$Res,
        _$MembersDataModelResponseImpl>
    implements _$$MembersDataModelResponseImplCopyWith<$Res> {
  __$$MembersDataModelResponseImplCopyWithImpl(
      _$MembersDataModelResponseImpl _value,
      $Res Function(_$MembersDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MembersDataModelResponse
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
    return _then(_$MembersDataModelResponseImpl(
      currentPage: freezed == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<DoctorModel>?,
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
class _$MembersDataModelResponseImpl implements _MembersDataModelResponse {
  const _$MembersDataModelResponseImpl(
      {@JsonKey(name: 'current_page') this.currentPage,
      final List<DoctorModel>? data,
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

  factory _$MembersDataModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MembersDataModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<DoctorModel>? _data;
  @override
  List<DoctorModel>? get data {
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
    return 'MembersDataModelResponse(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MembersDataModelResponseImpl &&
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

  /// Create a copy of MembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MembersDataModelResponseImplCopyWith<_$MembersDataModelResponseImpl>
      get copyWith => __$$MembersDataModelResponseImplCopyWithImpl<
          _$MembersDataModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MembersDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _MembersDataModelResponse implements MembersDataModelResponse {
  const factory _MembersDataModelResponse(
      {@JsonKey(name: 'current_page') final int? currentPage,
      final List<DoctorModel>? data,
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
      final int? total}) = _$MembersDataModelResponseImpl;

  factory _MembersDataModelResponse.fromJson(Map<String, dynamic> json) =
      _$MembersDataModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int? get currentPage;
  @override
  List<DoctorModel>? get data;
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

  /// Create a copy of MembersDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MembersDataModelResponseImplCopyWith<_$MembersDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
