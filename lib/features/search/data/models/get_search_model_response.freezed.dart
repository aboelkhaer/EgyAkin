// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_search_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetSearchModelResponse _$GetSearchModelResponseFromJson(
    Map<String, dynamic> json) {
  return _GetSearchModelResponse.fromJson(json);
}

/// @nodoc
mixin _$GetSearchModelResponse {
  bool? get value => throw _privateConstructorUsedError;
  List<PatientHomeDataModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetSearchModelResponseCopyWith<GetSearchModelResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSearchModelResponseCopyWith<$Res> {
  factory $GetSearchModelResponseCopyWith(GetSearchModelResponse value,
          $Res Function(GetSearchModelResponse) then) =
      _$GetSearchModelResponseCopyWithImpl<$Res, GetSearchModelResponse>;
  @useResult
  $Res call({bool? value, List<PatientHomeDataModel>? data});
}

/// @nodoc
class _$GetSearchModelResponseCopyWithImpl<$Res,
        $Val extends GetSearchModelResponse>
    implements $GetSearchModelResponseCopyWith<$Res> {
  _$GetSearchModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetSearchModelResponseImplCopyWith<$Res>
    implements $GetSearchModelResponseCopyWith<$Res> {
  factory _$$GetSearchModelResponseImplCopyWith(
          _$GetSearchModelResponseImpl value,
          $Res Function(_$GetSearchModelResponseImpl) then) =
      __$$GetSearchModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? value, List<PatientHomeDataModel>? data});
}

/// @nodoc
class __$$GetSearchModelResponseImplCopyWithImpl<$Res>
    extends _$GetSearchModelResponseCopyWithImpl<$Res,
        _$GetSearchModelResponseImpl>
    implements _$$GetSearchModelResponseImplCopyWith<$Res> {
  __$$GetSearchModelResponseImplCopyWithImpl(
      _$GetSearchModelResponseImpl _value,
      $Res Function(_$GetSearchModelResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? data = freezed,
  }) {
    return _then(_$GetSearchModelResponseImpl(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetSearchModelResponseImpl
    with DiagnosticableTreeMixin
    implements _GetSearchModelResponse {
  const _$GetSearchModelResponseImpl(
      {this.value, final List<PatientHomeDataModel>? data})
      : _data = data;

  factory _$GetSearchModelResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetSearchModelResponseImplFromJson(json);

  @override
  final bool? value;
  final List<PatientHomeDataModel>? _data;
  @override
  List<PatientHomeDataModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GetSearchModelResponse(value: $value, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GetSearchModelResponse'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetSearchModelResponseImpl &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, value, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetSearchModelResponseImplCopyWith<_$GetSearchModelResponseImpl>
      get copyWith => __$$GetSearchModelResponseImplCopyWithImpl<
          _$GetSearchModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetSearchModelResponseImplToJson(
      this,
    );
  }
}

abstract class _GetSearchModelResponse implements GetSearchModelResponse {
  const factory _GetSearchModelResponse(
      {final bool? value,
      final List<PatientHomeDataModel>? data}) = _$GetSearchModelResponseImpl;

  factory _GetSearchModelResponse.fromJson(Map<String, dynamic> json) =
      _$GetSearchModelResponseImpl.fromJson;

  @override
  bool? get value;
  @override
  List<PatientHomeDataModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$GetSearchModelResponseImplCopyWith<_$GetSearchModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
