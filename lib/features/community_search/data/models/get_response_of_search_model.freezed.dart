// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_response_of_search_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetResponseOfSearchModel _$GetResponseOfSearchModelFromJson(
    Map<String, dynamic> json) {
  return _GetResponseOfSearchModel.fromJson(json);
}

/// @nodoc
mixin _$GetResponseOfSearchModel {
  GetPostsCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetResponseOfSearchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetResponseOfSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetResponseOfSearchModelCopyWith<GetResponseOfSearchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetResponseOfSearchModelCopyWith<$Res> {
  factory $GetResponseOfSearchModelCopyWith(GetResponseOfSearchModel value,
          $Res Function(GetResponseOfSearchModel) then) =
      _$GetResponseOfSearchModelCopyWithImpl<$Res, GetResponseOfSearchModel>;
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetResponseOfSearchModelCopyWithImpl<$Res,
        $Val extends GetResponseOfSearchModel>
    implements $GetResponseOfSearchModelCopyWith<$Res> {
  _$GetResponseOfSearchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetResponseOfSearchModel
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

  /// Create a copy of GetResponseOfSearchModel
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
abstract class _$$GetResponseOfSearchModelImplCopyWith<$Res>
    implements $GetResponseOfSearchModelCopyWith<$Res> {
  factory _$$GetResponseOfSearchModelImplCopyWith(
          _$GetResponseOfSearchModelImpl value,
          $Res Function(_$GetResponseOfSearchModelImpl) then) =
      __$$GetResponseOfSearchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetPostsCommunityDataModelResponse? data});

  @override
  $GetPostsCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetResponseOfSearchModelImplCopyWithImpl<$Res>
    extends _$GetResponseOfSearchModelCopyWithImpl<$Res,
        _$GetResponseOfSearchModelImpl>
    implements _$$GetResponseOfSearchModelImplCopyWith<$Res> {
  __$$GetResponseOfSearchModelImplCopyWithImpl(
      _$GetResponseOfSearchModelImpl _value,
      $Res Function(_$GetResponseOfSearchModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetResponseOfSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetResponseOfSearchModelImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetPostsCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetResponseOfSearchModelImpl implements _GetResponseOfSearchModel {
  const _$GetResponseOfSearchModelImpl({this.data});

  factory _$GetResponseOfSearchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetResponseOfSearchModelImplFromJson(json);

  @override
  final GetPostsCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetResponseOfSearchModel(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetResponseOfSearchModelImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetResponseOfSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetResponseOfSearchModelImplCopyWith<_$GetResponseOfSearchModelImpl>
      get copyWith => __$$GetResponseOfSearchModelImplCopyWithImpl<
          _$GetResponseOfSearchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetResponseOfSearchModelImplToJson(
      this,
    );
  }
}

abstract class _GetResponseOfSearchModel implements GetResponseOfSearchModel {
  const factory _GetResponseOfSearchModel(
          {final GetPostsCommunityDataModelResponse? data}) =
      _$GetResponseOfSearchModelImpl;

  factory _GetResponseOfSearchModel.fromJson(Map<String, dynamic> json) =
      _$GetResponseOfSearchModelImpl.fromJson;

  @override
  GetPostsCommunityDataModelResponse? get data;

  /// Create a copy of GetResponseOfSearchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetResponseOfSearchModelImplCopyWith<_$GetResponseOfSearchModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
