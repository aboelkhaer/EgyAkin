// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_doctor_invitation_for_groups_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetDoctorInvitationForGroupsModelResponse
    _$GetDoctorInvitationForGroupsModelResponseFromJson(
        Map<String, dynamic> json) {
  return _GetDoctorInvitationForGroupsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetDoctorInvitationForGroupsModelResponse {
  GetAllGroupsInCommunityDataModelResponse? get data =>
      throw _privateConstructorUsedError;

  /// Serializes this GetDoctorInvitationForGroupsModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetDoctorInvitationForGroupsModelResponseCopyWith<
          GetDoctorInvitationForGroupsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetDoctorInvitationForGroupsModelResponseCopyWith<$Res> {
  factory $GetDoctorInvitationForGroupsModelResponseCopyWith(
          GetDoctorInvitationForGroupsModelResponse value,
          $Res Function(GetDoctorInvitationForGroupsModelResponse) then) =
      _$GetDoctorInvitationForGroupsModelResponseCopyWithImpl<$Res,
          GetDoctorInvitationForGroupsModelResponse>;
  @useResult
  $Res call({GetAllGroupsInCommunityDataModelResponse? data});

  $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class _$GetDoctorInvitationForGroupsModelResponseCopyWithImpl<$Res,
        $Val extends GetDoctorInvitationForGroupsModelResponse>
    implements $GetDoctorInvitationForGroupsModelResponseCopyWith<$Res> {
  _$GetDoctorInvitationForGroupsModelResponseCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
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
              as GetAllGroupsInCommunityDataModelResponse?,
    ) as $Val);
  }

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
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
abstract class _$$GetDoctorInvitationForGroupsModelResponseImplCopyWith<$Res>
    implements $GetDoctorInvitationForGroupsModelResponseCopyWith<$Res> {
  factory _$$GetDoctorInvitationForGroupsModelResponseImplCopyWith(
          _$GetDoctorInvitationForGroupsModelResponseImpl value,
          $Res Function(_$GetDoctorInvitationForGroupsModelResponseImpl) then) =
      __$$GetDoctorInvitationForGroupsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GetAllGroupsInCommunityDataModelResponse? data});

  @override
  $GetAllGroupsInCommunityDataModelResponseCopyWith<$Res>? get data;
}

/// @nodoc
class __$$GetDoctorInvitationForGroupsModelResponseImplCopyWithImpl<$Res>
    extends _$GetDoctorInvitationForGroupsModelResponseCopyWithImpl<$Res,
        _$GetDoctorInvitationForGroupsModelResponseImpl>
    implements _$$GetDoctorInvitationForGroupsModelResponseImplCopyWith<$Res> {
  __$$GetDoctorInvitationForGroupsModelResponseImplCopyWithImpl(
      _$GetDoctorInvitationForGroupsModelResponseImpl _value,
      $Res Function(_$GetDoctorInvitationForGroupsModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$GetDoctorInvitationForGroupsModelResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetAllGroupsInCommunityDataModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetDoctorInvitationForGroupsModelResponseImpl
    implements _GetDoctorInvitationForGroupsModelResponse {
  const _$GetDoctorInvitationForGroupsModelResponseImpl({this.data});

  factory _$GetDoctorInvitationForGroupsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetDoctorInvitationForGroupsModelResponseImplFromJson(json);

  @override
  final GetAllGroupsInCommunityDataModelResponse? data;

  @override
  String toString() {
    return 'GetDoctorInvitationForGroupsModelResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetDoctorInvitationForGroupsModelResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetDoctorInvitationForGroupsModelResponseImplCopyWith<
          _$GetDoctorInvitationForGroupsModelResponseImpl>
      get copyWith =>
          __$$GetDoctorInvitationForGroupsModelResponseImplCopyWithImpl<
                  _$GetDoctorInvitationForGroupsModelResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetDoctorInvitationForGroupsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetDoctorInvitationForGroupsModelResponse
    implements GetDoctorInvitationForGroupsModelResponse {
  const factory _GetDoctorInvitationForGroupsModelResponse(
          {final GetAllGroupsInCommunityDataModelResponse? data}) =
      _$GetDoctorInvitationForGroupsModelResponseImpl;

  factory _GetDoctorInvitationForGroupsModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$GetDoctorInvitationForGroupsModelResponseImpl.fromJson;

  @override
  GetAllGroupsInCommunityDataModelResponse? get data;

  /// Create a copy of GetDoctorInvitationForGroupsModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetDoctorInvitationForGroupsModelResponseImplCopyWith<
          _$GetDoctorInvitationForGroupsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
