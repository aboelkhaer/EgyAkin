// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_group_details_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetGroupDetailsInCommunityModelResponse
    _$GetGroupDetailsInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetGroupDetailsInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetGroupDetailsInCommunityModelResponse {
  GetGroupDetailsInCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetGroupDetailsInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetGroupDetailsInCommunityModelResponseCopyWith<
          GetGroupDetailsInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetGroupDetailsInCommunityModelResponseCopyWith<$Res> {
  factory $GetGroupDetailsInCommunityModelResponseCopyWith(
          GetGroupDetailsInCommunityModelResponse value,
          $Res Function(GetGroupDetailsInCommunityModelResponse) then) =
      _$GetGroupDetailsInCommunityModelResponseCopyWithImpl<$Res,
          GetGroupDetailsInCommunityModelResponse>;
  @useResult
  $Res call({GetGroupDetailsInCommunityDataModelResponse? data});

  $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetGroupDetailsInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends GetGroupDetailsInCommunityModelResponse>
    implements $GetGroupDetailsInCommunityModelResponseCopyWith<$Res> {
  _$GetGroupDetailsInCommunityModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
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
              as GetGroupDetailsInCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res>(
        _value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetGroupDetailsInCommunityModelResponseImplCopyWith<$Res>
    implements $GetGroupDetailsInCommunityModelResponseCopyWith<$Res> {
  factory _$$GetGroupDetailsInCommunityModelResponseImplCopyWith(
          _$GetGroupDetailsInCommunityModelResponseImpl value,
          $Res Function(_$GetGroupDetailsInCommunityModelResponseImpl) then) =
      __$$GetGroupDetailsInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetGroupDetailsInCommunityDataModelResponse? data});

  @override
  $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetGroupDetailsInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$GetGroupDetailsInCommunityModelResponseCopyWithImpl<$Res,
        _$GetGroupDetailsInCommunityModelResponseImpl>
    implements _$$GetGroupDetailsInCommunityModelResponseImplCopyWith<$Res> {
  __$$GetGroupDetailsInCommunityModelResponseImplCopyWithImpl(
      _$GetGroupDetailsInCommunityModelResponseImpl _value,
      $Res Function(_$GetGroupDetailsInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetGroupDetailsInCommunityModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetGroupDetailsInCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetGroupDetailsInCommunityModelResponseImpl
    implements _GetGroupDetailsInCommunityModelResponse {
  const _$GetGroupDetailsInCommunityModelResponseImpl({this.data});

  factory _$GetGroupDetailsInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetGroupDetailsInCommunityModelResponseImplFromJson(json);

  @override
  final GetGroupDetailsInCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetGroupDetailsInCommunityModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetGroupDetailsInCommunityModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetGroupDetailsInCommunityModelResponseImplCopyWith<
          _$GetGroupDetailsInCommunityModelResponseImpl>
      get copyWith =>
          __$$GetGroupDetailsInCommunityModelResponseImplCopyWithImpl<
              _$GetGroupDetailsInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetGroupDetailsInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetGroupDetailsInCommunityModelResponse
    implements GetGroupDetailsInCommunityModelResponse {
  const factory _GetGroupDetailsInCommunityModelResponse(
          {final GetGroupDetailsInCommunityDataModelResponse? data}) =
      _$GetGroupDetailsInCommunityModelResponseImpl;

  factory _GetGroupDetailsInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetGroupDetailsInCommunityModelResponseImpl.fromJson;

  @override
  GetGroupDetailsInCommunityDataModelResponse? get data;

  /// Create a copy of GetGroupDetailsInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetGroupDetailsInCommunityModelResponseImplCopyWith<
          _$GetGroupDetailsInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetGroupDetailsInCommunityDataModelResponse
    _$GetGroupDetailsInCommunityDataModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetGroupDetailsInCommunityDataModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetGroupDetailsInCommunityDataModelResponse {
  GroupModel? get group => throw _privateConstructorUsedError;
  GetPostsCommunityDataModelResponse? get posts =>
      throw _privateConstructorUsedError;

  /// Serializes this GetGroupDetailsInCommunityDataModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetGroupDetailsInCommunityDataModelResponseCopyWith<
          GetGroupDetailsInCommunityDataModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res> {
  factory $GetGroupDetailsInCommunityDataModelResponseCopyWith(
          GetGroupDetailsInCommunityDataModelResponse value,
          $Res Function(GetGroupDetailsInCommunityDataModelResponse) then) =
      _$GetGroupDetailsInCommunityDataModelResponseCopyWithImpl<$Res,
          GetGroupDetailsInCommunityDataModelResponse>;
  @useResult
  $Res call({GroupModel? group, GetPostsCommunityDataModelResponse? posts});

  $GroupModelCopyWith<$Res>? get group;
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get posts;
}

/// @nodoc
class _$GetGroupDetailsInCommunityDataModelResponseCopyWithImpl<$Res,
        $Val extends GetGroupDetailsInCommunityDataModelResponse>
    implements $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res> {
  _$GetGroupDetailsInCommunityDataModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? posts = freezed,
  }) {
    return _then(_value.copyWith(
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupModelCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupModelCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get posts {
    if (_value.posts == null) {
      return null;
    }

    return $GetPostsCommunityDataModelResponseCopyWith<$Res>(_value.posts!,
        (value) {
      return _then(_value.copyWith(posts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetGroupDetailsInCommunityDataModelResponseImplCopyWith<$Res>
    implements $GetGroupDetailsInCommunityDataModelResponseCopyWith<$Res> {
  factory _$$GetGroupDetailsInCommunityDataModelResponseImplCopyWith(
          _$GetGroupDetailsInCommunityDataModelResponseImpl value,
          $Res Function(_$GetGroupDetailsInCommunityDataModelResponseImpl)
              then) =
      __$$GetGroupDetailsInCommunityDataModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GroupModel? group, GetPostsCommunityDataModelResponse? posts});

  @override
  $GroupModelCopyWith<$Res>? get group;
  @override
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get posts;
}

/// @nodoc
class __$$GetGroupDetailsInCommunityDataModelResponseImplCopyWithImpl<$Res>
    extends _$GetGroupDetailsInCommunityDataModelResponseCopyWithImpl<$Res,
        _$GetGroupDetailsInCommunityDataModelResponseImpl>
    implements
        _$$GetGroupDetailsInCommunityDataModelResponseImplCopyWith<$Res> {
  __$$GetGroupDetailsInCommunityDataModelResponseImplCopyWithImpl(
      _$GetGroupDetailsInCommunityDataModelResponseImpl _value,
      $Res Function(_$GetGroupDetailsInCommunityDataModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = freezed,
    Object? posts = freezed,
  }) {
    return _then(_$GetGroupDetailsInCommunityDataModelResponseImpl(
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetGroupDetailsInCommunityDataModelResponseImpl
    implements _GetGroupDetailsInCommunityDataModelResponse {
  const _$GetGroupDetailsInCommunityDataModelResponseImpl(
      {this.group, this.posts});

  factory _$GetGroupDetailsInCommunityDataModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetGroupDetailsInCommunityDataModelResponseImplFromJson(json);

  @override
  final GroupModel? group;
  @override
  final GetPostsCommunityDataModelResponse? posts;

  @override
  String toString() {
    return 'GetGroupDetailsInCommunityDataModelResponse(group: $group, posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetGroupDetailsInCommunityDataModelResponseImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.posts, posts) || other.posts == posts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, group, posts);

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetGroupDetailsInCommunityDataModelResponseImplCopyWith<
          _$GetGroupDetailsInCommunityDataModelResponseImpl>
      get copyWith =>
          __$$GetGroupDetailsInCommunityDataModelResponseImplCopyWithImpl<
                  _$GetGroupDetailsInCommunityDataModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetGroupDetailsInCommunityDataModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetGroupDetailsInCommunityDataModelResponse
    implements GetGroupDetailsInCommunityDataModelResponse {
  const factory _GetGroupDetailsInCommunityDataModelResponse(
          {final GroupModel? group,
          final GetPostsCommunityDataModelResponse? posts}) =
      _$GetGroupDetailsInCommunityDataModelResponseImpl;

  factory _GetGroupDetailsInCommunityDataModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetGroupDetailsInCommunityDataModelResponseImpl.fromJson;

  @override
  GroupModel? get group;
  @override
  GetPostsCommunityDataModelResponse? get posts;

  /// Create a copy of GetGroupDetailsInCommunityDataModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetGroupDetailsInCommunityDataModelResponseImplCopyWith<
          _$GetGroupDetailsInCommunityDataModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
