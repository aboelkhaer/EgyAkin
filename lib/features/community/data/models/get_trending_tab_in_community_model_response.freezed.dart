// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_trending_tab_in_community_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetTrendingTabInCommunityModelResponse
    _$GetTrendingTabInCommunityModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetTrendingTabInCommunityModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetTrendingTabInCommunityModelResponse {
  List<TrendModel>? get data => throw _privateConstructorUsedError;

  /// Serializes this GetTrendingTabInCommunityModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetTrendingTabInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetTrendingTabInCommunityModelResponseCopyWith<
          GetTrendingTabInCommunityModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetTrendingTabInCommunityModelResponseCopyWith<$Res> {
  factory $GetTrendingTabInCommunityModelResponseCopyWith(
          GetTrendingTabInCommunityModelResponse value,
          $Res Function(GetTrendingTabInCommunityModelResponse) then) =
      _$GetTrendingTabInCommunityModelResponseCopyWithImpl<$Res,
          GetTrendingTabInCommunityModelResponse>;
  @useResult
  $Res call({List<TrendModel>? data});
}

/// @nodoc
class _$GetTrendingTabInCommunityModelResponseCopyWithImpl<$Res,
        $Val extends GetTrendingTabInCommunityModelResponse>
    implements $GetTrendingTabInCommunityModelResponseCopyWith<$Res> {
  _$GetTrendingTabInCommunityModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetTrendingTabInCommunityModelResponse
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
              as List<TrendModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetTrendingTabInCommunityModelResponseImplCopyWith<$Res>
    implements $GetTrendingTabInCommunityModelResponseCopyWith<$Res> {
  factory _$$GetTrendingTabInCommunityModelResponseImplCopyWith(
          _$GetTrendingTabInCommunityModelResponseImpl value,
          $Res Function(_$GetTrendingTabInCommunityModelResponseImpl) then) =
      __$$GetTrendingTabInCommunityModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TrendModel>? data});
}

/// @nodoc
class __$$GetTrendingTabInCommunityModelResponseImplCopyWithImpl<$Res>
    extends _$GetTrendingTabInCommunityModelResponseCopyWithImpl<$Res,
        _$GetTrendingTabInCommunityModelResponseImpl>
    implements _$$GetTrendingTabInCommunityModelResponseImplCopyWith<$Res> {
  __$$GetTrendingTabInCommunityModelResponseImplCopyWithImpl(
      _$GetTrendingTabInCommunityModelResponseImpl _value,
      $Res Function(_$GetTrendingTabInCommunityModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetTrendingTabInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetTrendingTabInCommunityModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TrendModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetTrendingTabInCommunityModelResponseImpl
    implements _GetTrendingTabInCommunityModelResponse {
  const _$GetTrendingTabInCommunityModelResponseImpl(
      {final List<TrendModel>? data})
      : _data = data;

  factory _$GetTrendingTabInCommunityModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetTrendingTabInCommunityModelResponseImplFromJson(json);

  final List<TrendModel>? _data;
  @override
  List<TrendModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GetTrendingTabInCommunityModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTrendingTabInCommunityModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of GetTrendingTabInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTrendingTabInCommunityModelResponseImplCopyWith<
          _$GetTrendingTabInCommunityModelResponseImpl>
      get copyWith =>
          __$$GetTrendingTabInCommunityModelResponseImplCopyWithImpl<
              _$GetTrendingTabInCommunityModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetTrendingTabInCommunityModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetTrendingTabInCommunityModelResponse
    implements GetTrendingTabInCommunityModelResponse {
  const factory _GetTrendingTabInCommunityModelResponse(
          {final List<TrendModel>? data}) =
      _$GetTrendingTabInCommunityModelResponseImpl;

  factory _GetTrendingTabInCommunityModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetTrendingTabInCommunityModelResponseImpl.fromJson;

  @override
  List<TrendModel>? get data;

  /// Create a copy of GetTrendingTabInCommunityModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetTrendingTabInCommunityModelResponseImplCopyWith<
          _$GetTrendingTabInCommunityModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TrendModel _$TrendModelFromJson(Map<String, dynamic> json) {
  return _TrendModel.fromJson(json);
}

/// @nodoc
mixin _$TrendModel {
  int? get id => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  @JsonKey(name: 'usage_count')
  int? get usageCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TrendModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendModelCopyWith<TrendModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendModelCopyWith<$Res> {
  factory $TrendModelCopyWith(
          TrendModel value, $Res Function(TrendModel) then) =
      _$TrendModelCopyWithImpl<$Res, TrendModel>;
  @useResult
  $Res call(
      {int? id,
      String? tag,
      @JsonKey(name: 'usage_count') int? usageCount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class _$TrendModelCopyWithImpl<$Res, $Val extends TrendModel>
    implements $TrendModelCopyWith<$Res> {
  _$TrendModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tag = freezed,
    Object? usageCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      usageCount: freezed == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendModelImplCopyWith<$Res>
    implements $TrendModelCopyWith<$Res> {
  factory _$$TrendModelImplCopyWith(
          _$TrendModelImpl value, $Res Function(_$TrendModelImpl) then) =
      __$$TrendModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? tag,
      @JsonKey(name: 'usage_count') int? usageCount,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'updated_at') String? updatedAt});
}

/// @nodoc
class __$$TrendModelImplCopyWithImpl<$Res>
    extends _$TrendModelCopyWithImpl<$Res, _$TrendModelImpl>
    implements _$$TrendModelImplCopyWith<$Res> {
  __$$TrendModelImplCopyWithImpl(
      _$TrendModelImpl _value, $Res Function(_$TrendModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrendModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? tag = freezed,
    Object? usageCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TrendModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      usageCount: freezed == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendModelImpl implements _TrendModel {
  const _$TrendModelImpl(
      {this.id,
      this.tag,
      @JsonKey(name: 'usage_count') this.usageCount,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$TrendModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? tag;
  @override
  @JsonKey(name: 'usage_count')
  final int? usageCount;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @override
  String toString() {
    return 'TrendModel(id: $id, tag: $tag, usageCount: $usageCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, tag, usageCount, createdAt, updatedAt);

  /// Create a copy of TrendModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendModelImplCopyWith<_$TrendModelImpl> get copyWith =>
      __$$TrendModelImplCopyWithImpl<_$TrendModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendModelImplToJson(
      this,
    );
  }
}

abstract class _TrendModel implements TrendModel {
  const factory _TrendModel(
      {final int? id,
      final String? tag,
      @JsonKey(name: 'usage_count') final int? usageCount,
      @JsonKey(name: 'created_at') final String? createdAt,
      @JsonKey(name: 'updated_at') final String? updatedAt}) = _$TrendModelImpl;

  factory _TrendModel.fromJson(Map<String, dynamic> json) =
      _$TrendModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get tag;
  @override
  @JsonKey(name: 'usage_count')
  int? get usageCount;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;

  /// Create a copy of TrendModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendModelImplCopyWith<_$TrendModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
