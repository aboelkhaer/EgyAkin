// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_groups_tab_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetGroupsTabModelResponse _$GetGroupsTabModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetGroupsTabModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetGroupsTabModelResponse {
  LatestGroupsData? get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this GetGroupsTabModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetGroupsTabModelResponseCopyWith<GetGroupsTabModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetGroupsTabModelResponseCopyWith<$Res> {
  factory $GetGroupsTabModelResponseCopyWith(GetGroupsTabModelResponse value,
          $Res Function(GetGroupsTabModelResponse) then) =
      _$GetGroupsTabModelResponseCopyWithImpl<$Res, GetGroupsTabModelResponse>;
  @useResult
  $Res call({LatestGroupsData? data, String? message});

  $LatestGroupsDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetGroupsTabModelResponseCopyWithImpl<$Res,
        $Val extends GetGroupsTabModelResponse>
    implements $GetGroupsTabModelResponseCopyWith<$Res> {
  _$GetGroupsTabModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LatestGroupsData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatestGroupsDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $LatestGroupsDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetGroupsTabModelResponseImplCopyWith<$Res>
    implements $GetGroupsTabModelResponseCopyWith<$Res> {
  factory _$$GetGroupsTabModelResponseImplCopyWith(
          _$GetGroupsTabModelResponseImpl value,
          $Res Function(_$GetGroupsTabModelResponseImpl) then) =
      __$$GetGroupsTabModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatestGroupsData? data, String? message});

  @override
  $LatestGroupsDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetGroupsTabModelResponseImplCopyWithImpl<$Res>
    extends _$GetGroupsTabModelResponseCopyWithImpl<$Res,
        _$GetGroupsTabModelResponseImpl>
    implements _$$GetGroupsTabModelResponseImplCopyWith<$Res> {
  __$$GetGroupsTabModelResponseImplCopyWithImpl(
      _$GetGroupsTabModelResponseImpl _value,
      $Res Function(_$GetGroupsTabModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$GetGroupsTabModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LatestGroupsData?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetGroupsTabModelResponseImpl implements _GetGroupsTabModelResponse {
  const _$GetGroupsTabModelResponseImpl({this.data, this.message});

  factory _$GetGroupsTabModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetGroupsTabModelResponseImplFromJson(json);

  @override
  final LatestGroupsData? data;
  @override
  final String? message;

  @override
  String toString() {
    return 'GetGroupsTabModelResponse(data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetGroupsTabModelResponseImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data, message);

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetGroupsTabModelResponseImplCopyWith<_$GetGroupsTabModelResponseImpl>
      get copyWith => __$$GetGroupsTabModelResponseImplCopyWithImpl<
          _$GetGroupsTabModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetGroupsTabModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetGroupsTabModelResponse implements GetGroupsTabModelResponse {
  const factory _GetGroupsTabModelResponse(
      {final LatestGroupsData? data,
      final String? message}) = _$GetGroupsTabModelResponseImpl;

  factory _GetGroupsTabModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetGroupsTabModelResponseImpl.fromJson;

  @override
  LatestGroupsData? get data;
  @override
  String? get message;

  /// Create a copy of GetGroupsTabModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetGroupsTabModelResponseImplCopyWith<_$GetGroupsTabModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

LatestGroupsData _$LatestGroupsDataFromJson(Map<String, dynamic> json) {
  return _LatestGroupsData.fromJson(json);
}

/// @nodoc
mixin _$LatestGroupsData {
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups => throw _privateConstructorUsedError;
  @JsonKey(name: 'random_posts')
  GetPostsCommunityDataModelResponse? get randomPosts =>
      throw _privateConstructorUsedError;

  /// Serializes this LatestGroupsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatestGroupsDataCopyWith<LatestGroupsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestGroupsDataCopyWith<$Res> {
  factory $LatestGroupsDataCopyWith(
          LatestGroupsData value, $Res Function(LatestGroupsData) then) =
      _$LatestGroupsDataCopyWithImpl<$Res, LatestGroupsData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
      @JsonKey(name: 'random_posts')
      GetPostsCommunityDataModelResponse? randomPosts});

  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get randomPosts;
}

/// @nodoc
class _$LatestGroupsDataCopyWithImpl<$Res, $Val extends LatestGroupsData>
    implements $LatestGroupsDataCopyWith<$Res> {
  _$LatestGroupsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestGroups = freezed,
    Object? randomPosts = freezed,
  }) {
    return _then(_value.copyWith(
      latestGroups: freezed == latestGroups
          ? _value.latestGroups
          : latestGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      randomPosts: freezed == randomPosts
          ? _value.randomPosts
          : randomPosts // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get randomPosts {
    if (_value.randomPosts == null) {
      return null;
    }

    return $GetPostsCommunityDataModelResponseCopyWith<$Res>(
        _value.randomPosts!, (value) {
      return _then(_value.copyWith(randomPosts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LatestGroupsDataImplCopyWith<$Res>
    implements $LatestGroupsDataCopyWith<$Res> {
  factory _$$LatestGroupsDataImplCopyWith(_$LatestGroupsDataImpl value,
          $Res Function(_$LatestGroupsDataImpl) then) =
      __$$LatestGroupsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'latest_groups') List<GroupModel>? latestGroups,
      @JsonKey(name: 'random_posts')
      GetPostsCommunityDataModelResponse? randomPosts});

  @override
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get randomPosts;
}

/// @nodoc
class __$$LatestGroupsDataImplCopyWithImpl<$Res>
    extends _$LatestGroupsDataCopyWithImpl<$Res, _$LatestGroupsDataImpl>
    implements _$$LatestGroupsDataImplCopyWith<$Res> {
  __$$LatestGroupsDataImplCopyWithImpl(_$LatestGroupsDataImpl _value,
      $Res Function(_$LatestGroupsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestGroups = freezed,
    Object? randomPosts = freezed,
  }) {
    return _then(_$LatestGroupsDataImpl(
      latestGroups: freezed == latestGroups
          ? _value._latestGroups
          : latestGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupModel>?,
      randomPosts: freezed == randomPosts
          ? _value.randomPosts
          : randomPosts // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatestGroupsDataImpl implements _LatestGroupsData {
  const _$LatestGroupsDataImpl(
      {@JsonKey(name: 'latest_groups') final List<GroupModel>? latestGroups,
      @JsonKey(name: 'random_posts') this.randomPosts})
      : _latestGroups = latestGroups;

  factory _$LatestGroupsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatestGroupsDataImplFromJson(json);

  final List<GroupModel>? _latestGroups;
  @override
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups {
    final value = _latestGroups;
    if (value == null) return null;
    if (_latestGroups is EqualUnmodifiableListView) return _latestGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'random_posts')
  final GetPostsCommunityDataModelResponse? randomPosts;

  @override
  String toString() {
    return 'LatestGroupsData(latestGroups: $latestGroups, randomPosts: $randomPosts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatestGroupsDataImpl &&
            const DeepCollectionEquality()
                .equals(other._latestGroups, _latestGroups) &&
            (identical(other.randomPosts, randomPosts) ||
                other.randomPosts == randomPosts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_latestGroups), randomPosts);

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatestGroupsDataImplCopyWith<_$LatestGroupsDataImpl> get copyWith =>
      __$$LatestGroupsDataImplCopyWithImpl<_$LatestGroupsDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatestGroupsDataImplToJson(
      this,
    );
  }
}

abstract class _LatestGroupsData implements LatestGroupsData {
  const factory _LatestGroupsData(
          {@JsonKey(name: 'latest_groups') final List<GroupModel>? latestGroups,
          @JsonKey(name: 'random_posts')
          final GetPostsCommunityDataModelResponse? randomPosts}) =
      _$LatestGroupsDataImpl;

  factory _LatestGroupsData.fromJson(Map<String, dynamic> json) =
      _$LatestGroupsDataImpl.fromJson;

  @override
  @JsonKey(name: 'latest_groups')
  List<GroupModel>? get latestGroups;
  @override
  @JsonKey(name: 'random_posts')
  GetPostsCommunityDataModelResponse? get randomPosts;

  /// Create a copy of LatestGroupsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatestGroupsDataImplCopyWith<_$LatestGroupsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'header_picture')
  String? get headerPicture => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_image')
  String? get groupImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_pending_invitations')
  bool? get isHasPendingInvitations => throw _privateConstructorUsedError;
  String? get privacy => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id')
  int? get ownerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invitation_id')
  int? get invitationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'member_count')
  int? get memberCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_status')
  String? get userStatus => throw _privateConstructorUsedError;
  DoctorModel? get owner => throw _privateConstructorUsedError;

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? description,
      @JsonKey(name: 'header_picture') String? headerPicture,
      @JsonKey(name: 'group_image') String? groupImage,
      @JsonKey(name: 'has_pending_invitations') bool? isHasPendingInvitations,
      String? privacy,
      @JsonKey(name: 'owner_id') int? ownerId,
      @JsonKey(name: 'invitation_id') int? invitationId,
      @JsonKey(name: 'member_count') int? memberCount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'user_status') String? userStatus,
      DoctorModel? owner});

  $DoctorModelCopyWith<$Res>? get owner;
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? headerPicture = freezed,
    Object? groupImage = freezed,
    Object? isHasPendingInvitations = freezed,
    Object? privacy = freezed,
    Object? ownerId = freezed,
    Object? invitationId = freezed,
    Object? memberCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userStatus = freezed,
    Object? owner = freezed,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      headerPicture: freezed == headerPicture
          ? _value.headerPicture
          : headerPicture // ignore: cast_nullable_to_non_nullable
              as String?,
      groupImage: freezed == groupImage
          ? _value.groupImage
          : groupImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isHasPendingInvitations: freezed == isHasPendingInvitations
          ? _value.isHasPendingInvitations
          : isHasPendingInvitations // ignore: cast_nullable_to_non_nullable
              as bool?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int?,
      invitationId: freezed == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberCount: freezed == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      userStatus: freezed == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ) as $Val);
  }

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DoctorModelCopyWith<$Res>? get owner {
    if (_value.owner == null) {
      return null;
    }

    return $DoctorModelCopyWith<$Res>(_value.owner!, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
          _$GroupModelImpl value, $Res Function(_$GroupModelImpl) then) =
      __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? description,
      @JsonKey(name: 'header_picture') String? headerPicture,
      @JsonKey(name: 'group_image') String? groupImage,
      @JsonKey(name: 'has_pending_invitations') bool? isHasPendingInvitations,
      String? privacy,
      @JsonKey(name: 'owner_id') int? ownerId,
      @JsonKey(name: 'invitation_id') int? invitationId,
      @JsonKey(name: 'member_count') int? memberCount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt,
      @JsonKey(name: 'user_status') String? userStatus,
      DoctorModel? owner});

  @override
  $DoctorModelCopyWith<$Res>? get owner;
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
      _$GroupModelImpl _value, $Res Function(_$GroupModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? headerPicture = freezed,
    Object? groupImage = freezed,
    Object? isHasPendingInvitations = freezed,
    Object? privacy = freezed,
    Object? ownerId = freezed,
    Object? invitationId = freezed,
    Object? memberCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? userStatus = freezed,
    Object? owner = freezed,
  }) {
    return _then(_$GroupModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      headerPicture: freezed == headerPicture
          ? _value.headerPicture
          : headerPicture // ignore: cast_nullable_to_non_nullable
              as String?,
      groupImage: freezed == groupImage
          ? _value.groupImage
          : groupImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isHasPendingInvitations: freezed == isHasPendingInvitations
          ? _value.isHasPendingInvitations
          : isHasPendingInvitations // ignore: cast_nullable_to_non_nullable
              as bool?,
      privacy: freezed == privacy
          ? _value.privacy
          : privacy // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int?,
      invitationId: freezed == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int?,
      memberCount: freezed == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      userStatus: freezed == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      owner: freezed == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as DoctorModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl implements _GroupModel {
  const _$GroupModelImpl(
      {this.id,
      this.name,
      this.description,
      @JsonKey(name: 'header_picture') this.headerPicture,
      @JsonKey(name: 'group_image') this.groupImage,
      @JsonKey(name: 'has_pending_invitations') this.isHasPendingInvitations,
      this.privacy,
      @JsonKey(name: 'owner_id') this.ownerId,
      @JsonKey(name: 'invitation_id') this.invitationId,
      @JsonKey(name: 'member_count') this.memberCount,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'user_status') this.userStatus,
      this.owner});

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'header_picture')
  final String? headerPicture;
  @override
  @JsonKey(name: 'group_image')
  final String? groupImage;
  @override
  @JsonKey(name: 'has_pending_invitations')
  final bool? isHasPendingInvitations;
  @override
  final String? privacy;
  @override
  @JsonKey(name: 'owner_id')
  final int? ownerId;
  @override
  @JsonKey(name: 'invitation_id')
  final int? invitationId;
  @override
  @JsonKey(name: 'member_count')
  final int? memberCount;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'user_status')
  final String? userStatus;
  @override
  final DoctorModel? owner;

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, description: $description, headerPicture: $headerPicture, groupImage: $groupImage, isHasPendingInvitations: $isHasPendingInvitations, privacy: $privacy, ownerId: $ownerId, invitationId: $invitationId, memberCount: $memberCount, createdAt: $createdAt, updatedAt: $updatedAt, userStatus: $userStatus, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.headerPicture, headerPicture) ||
                other.headerPicture == headerPicture) &&
            (identical(other.groupImage, groupImage) ||
                other.groupImage == groupImage) &&
            (identical(
                    other.isHasPendingInvitations, isHasPendingInvitations) ||
                other.isHasPendingInvitations == isHasPendingInvitations) &&
            (identical(other.privacy, privacy) || other.privacy == privacy) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      headerPicture,
      groupImage,
      isHasPendingInvitations,
      privacy,
      ownerId,
      invitationId,
      memberCount,
      createdAt,
      updatedAt,
      userStatus,
      owner);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(
      this,
    );
  }
}

abstract class _GroupModel implements GroupModel {
  const factory _GroupModel(
      {final int? id,
      final String? name,
      final String? description,
      @JsonKey(name: 'header_picture') final String? headerPicture,
      @JsonKey(name: 'group_image') final String? groupImage,
      @JsonKey(name: 'has_pending_invitations')
      final bool? isHasPendingInvitations,
      final String? privacy,
      @JsonKey(name: 'owner_id') final int? ownerId,
      @JsonKey(name: 'invitation_id') final int? invitationId,
      @JsonKey(name: 'member_count') final int? memberCount,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt,
      @JsonKey(name: 'user_status') final String? userStatus,
      final DoctorModel? owner}) = _$GroupModelImpl;

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'header_picture')
  String? get headerPicture;
  @override
  @JsonKey(name: 'group_image')
  String? get groupImage;
  @override
  @JsonKey(name: 'has_pending_invitations')
  bool? get isHasPendingInvitations;
  @override
  String? get privacy;
  @override
  @JsonKey(name: 'owner_id')
  int? get ownerId;
  @override
  @JsonKey(name: 'invitation_id')
  int? get invitationId;
  @override
  @JsonKey(name: 'member_count')
  int? get memberCount;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'user_status')
  String? get userStatus;
  @override
  DoctorModel? get owner;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
