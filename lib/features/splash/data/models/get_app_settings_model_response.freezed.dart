// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_app_settings_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetAppSettingsModelResponse _$GetAppSettingsModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetAppSettingsModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetAppSettingsModelResponse {
  @JsonKey(name: 'app_freeze')
  bool? get appFreeze => throw _privateConstructorUsedError;
  @JsonKey(name: 'force_update')
  bool? get forceUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetAppSettingsModelResponseCopyWith<GetAppSettingsModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetAppSettingsModelResponseCopyWith<$Res> {
  factory $GetAppSettingsModelResponseCopyWith(
          GetAppSettingsModelResponse value,
          $Res Function(GetAppSettingsModelResponse) then) =
      _$GetAppSettingsModelResponseCopyWithImpl<$Res,
          GetAppSettingsModelResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'app_freeze') bool? appFreeze,
      @JsonKey(name: 'force_update') bool? forceUpdate});
}

/// @nodoc
class _$GetAppSettingsModelResponseCopyWithImpl<$Res,
        $Val extends GetAppSettingsModelResponse>
    implements $GetAppSettingsModelResponseCopyWith<$Res> {
  _$GetAppSettingsModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appFreeze = freezed,
    Object? forceUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      appFreeze: freezed == appFreeze
          ? _value.appFreeze
          : appFreeze // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceUpdate: freezed == forceUpdate
          ? _value.forceUpdate
          : forceUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetAppSettingsModelResponseImplCopyWith<$Res>
    implements $GetAppSettingsModelResponseCopyWith<$Res> {
  factory _$$GetAppSettingsModelResponseImplCopyWith(
          _$GetAppSettingsModelResponseImpl value,
          $Res Function(_$GetAppSettingsModelResponseImpl) then) =
      __$$GetAppSettingsModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'app_freeze') bool? appFreeze,
      @JsonKey(name: 'force_update') bool? forceUpdate});
}

/// @nodoc
class __$$GetAppSettingsModelResponseImplCopyWithImpl<$Res>
    extends _$GetAppSettingsModelResponseCopyWithImpl<$Res,
        _$GetAppSettingsModelResponseImpl>
    implements _$$GetAppSettingsModelResponseImplCopyWith<$Res> {
  __$$GetAppSettingsModelResponseImplCopyWithImpl(
      _$GetAppSettingsModelResponseImpl _value,
      $Res Function(_$GetAppSettingsModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appFreeze = freezed,
    Object? forceUpdate = freezed,
  }) {
    return _then(_$GetAppSettingsModelResponseImpl(
      appFreeze: freezed == appFreeze
          ? _value.appFreeze
          : appFreeze // ignore: cast_nullable_to_non_nullable
              as bool?,
      forceUpdate: freezed == forceUpdate
          ? _value.forceUpdate
          : forceUpdate // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetAppSettingsModelResponseImpl
    implements _GetAppSettingsModelResponse {
  const _$GetAppSettingsModelResponseImpl(
      {@JsonKey(name: 'app_freeze') this.appFreeze,
      @JsonKey(name: 'force_update') this.forceUpdate});

  factory _$GetAppSettingsModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetAppSettingsModelResponseImplFromJson(json);

  @override
  @JsonKey(name: 'app_freeze')
  final bool? appFreeze;
  @override
  @JsonKey(name: 'force_update')
  final bool? forceUpdate;

  @override
  String toString() {
    return 'GetAppSettingsModelResponse(appFreeze: $appFreeze, forceUpdate: $forceUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAppSettingsModelResponseImpl &&
            (identical(other.appFreeze, appFreeze) ||
                other.appFreeze == appFreeze) &&
            (identical(other.forceUpdate, forceUpdate) ||
                other.forceUpdate == forceUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appFreeze, forceUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAppSettingsModelResponseImplCopyWith<_$GetAppSettingsModelResponseImpl>
      get copyWith => __$$GetAppSettingsModelResponseImplCopyWithImpl<
          _$GetAppSettingsModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetAppSettingsModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetAppSettingsModelResponse
    implements GetAppSettingsModelResponse {
  const factory _GetAppSettingsModelResponse(
          {@JsonKey(name: 'app_freeze') final bool? appFreeze,
          @JsonKey(name: 'force_update') final bool? forceUpdate}) =
      _$GetAppSettingsModelResponseImpl;

  factory _GetAppSettingsModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetAppSettingsModelResponseImpl.fromJson;

  @override
  @JsonKey(name: 'app_freeze')
  bool? get appFreeze;
  @override
  @JsonKey(name: 'force_update')
  bool? get forceUpdate;
  @override
  @JsonKey(ignore: true)
  _$$GetAppSettingsModelResponseImplCopyWith<_$GetAppSettingsModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
