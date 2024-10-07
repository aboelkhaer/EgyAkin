// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply_patient_filters_model_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplyPatientFiltersModelResponse _$ApplyPatientFiltersModelResponseFromJson(
    Map<String, dynamic> json) {
  return _ApplyPatientFiltersModelResponse.fromJson(json);
}

/// @nodoc
mixin _$ApplyPatientFiltersModelResponse {
  List<PatientHomeDataModel>? get data => throw _privateConstructorUsedError;
  PaginationFiltersModelResponse? get pagination =>
      throw _privateConstructorUsedError;

  /// Serializes this ApplyPatientFiltersModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplyPatientFiltersModelResponseCopyWith<ApplyPatientFiltersModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  factory $ApplyPatientFiltersModelResponseCopyWith(
          ApplyPatientFiltersModelResponse value,
          $Res Function(ApplyPatientFiltersModelResponse) then) =
      _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
          ApplyPatientFiltersModelResponse>;
  @useResult
  $Res call(
      {List<PatientHomeDataModel>? data,
      PaginationFiltersModelResponse? pagination});

  $PaginationFiltersModelResponseCopyWith<$Res>? get pagination;
}

/// @nodoc
class _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
        $Val extends ApplyPatientFiltersModelResponse>
    implements $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  _$ApplyPatientFiltersModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationFiltersModelResponse?,
    ) as $Val);
  }

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationFiltersModelResponseCopyWith<$Res>? get pagination {
    if (_value.pagination == null) {
      return null;
    }

    return $PaginationFiltersModelResponseCopyWith<$Res>(_value.pagination!,
        (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ApplyPatientFiltersModelResponseImplCopyWith<$Res>
    implements $ApplyPatientFiltersModelResponseCopyWith<$Res> {
  factory _$$ApplyPatientFiltersModelResponseImplCopyWith(
          _$ApplyPatientFiltersModelResponseImpl value,
          $Res Function(_$ApplyPatientFiltersModelResponseImpl) then) =
      __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PatientHomeDataModel>? data,
      PaginationFiltersModelResponse? pagination});

  @override
  $PaginationFiltersModelResponseCopyWith<$Res>? get pagination;
}

/// @nodoc
class __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<$Res>
    extends _$ApplyPatientFiltersModelResponseCopyWithImpl<$Res,
        _$ApplyPatientFiltersModelResponseImpl>
    implements _$$ApplyPatientFiltersModelResponseImplCopyWith<$Res> {
  __$$ApplyPatientFiltersModelResponseImplCopyWithImpl(
      _$ApplyPatientFiltersModelResponseImpl _value,
      $Res Function(_$ApplyPatientFiltersModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$ApplyPatientFiltersModelResponseImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PatientHomeDataModel>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationFiltersModelResponse?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplyPatientFiltersModelResponseImpl
    implements _ApplyPatientFiltersModelResponse {
  const _$ApplyPatientFiltersModelResponseImpl(
      {final List<PatientHomeDataModel>? data, this.pagination})
      : _data = data;

  factory _$ApplyPatientFiltersModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ApplyPatientFiltersModelResponseImplFromJson(json);

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
  final PaginationFiltersModelResponse? pagination;

  @override
  String toString() {
    return 'ApplyPatientFiltersModelResponse(data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyPatientFiltersModelResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), pagination);

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyPatientFiltersModelResponseImplCopyWith<
          _$ApplyPatientFiltersModelResponseImpl>
      get copyWith => __$$ApplyPatientFiltersModelResponseImplCopyWithImpl<
          _$ApplyPatientFiltersModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyPatientFiltersModelResponseImplToJson(
      this,
    );
  }
}

abstract class _ApplyPatientFiltersModelResponse
    implements ApplyPatientFiltersModelResponse {
  const factory _ApplyPatientFiltersModelResponse(
          {final List<PatientHomeDataModel>? data,
          final PaginationFiltersModelResponse? pagination}) =
      _$ApplyPatientFiltersModelResponseImpl;

  factory _ApplyPatientFiltersModelResponse.fromJson(
          Map<String, dynamic> json) =
      _$ApplyPatientFiltersModelResponseImpl.fromJson;

  @override
  List<PatientHomeDataModel>? get data;
  @override
  PaginationFiltersModelResponse? get pagination;

  /// Create a copy of ApplyPatientFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyPatientFiltersModelResponseImplCopyWith<
          _$ApplyPatientFiltersModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PaginationFiltersModelResponse _$PaginationFiltersModelResponseFromJson(
    Map<String, dynamic> json) {
  return _PaginationFiltersModelResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginationFiltersModelResponse {
  int? get total => throw _privateConstructorUsedError;

  /// Serializes this PaginationFiltersModelResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginationFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationFiltersModelResponseCopyWith<PaginationFiltersModelResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationFiltersModelResponseCopyWith<$Res> {
  factory $PaginationFiltersModelResponseCopyWith(
          PaginationFiltersModelResponse value,
          $Res Function(PaginationFiltersModelResponse) then) =
      _$PaginationFiltersModelResponseCopyWithImpl<$Res,
          PaginationFiltersModelResponse>;
  @useResult
  $Res call({int? total});
}

/// @nodoc
class _$PaginationFiltersModelResponseCopyWithImpl<$Res,
        $Val extends PaginationFiltersModelResponse>
    implements $PaginationFiltersModelResponseCopyWith<$Res> {
  _$PaginationFiltersModelResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = freezed,
  }) {
    return _then(_value.copyWith(
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationFiltersModelResponseImplCopyWith<$Res>
    implements $PaginationFiltersModelResponseCopyWith<$Res> {
  factory _$$PaginationFiltersModelResponseImplCopyWith(
          _$PaginationFiltersModelResponseImpl value,
          $Res Function(_$PaginationFiltersModelResponseImpl) then) =
      __$$PaginationFiltersModelResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? total});
}

/// @nodoc
class __$$PaginationFiltersModelResponseImplCopyWithImpl<$Res>
    extends _$PaginationFiltersModelResponseCopyWithImpl<$Res,
        _$PaginationFiltersModelResponseImpl>
    implements _$$PaginationFiltersModelResponseImplCopyWith<$Res> {
  __$$PaginationFiltersModelResponseImplCopyWithImpl(
      _$PaginationFiltersModelResponseImpl _value,
      $Res Function(_$PaginationFiltersModelResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginationFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = freezed,
  }) {
    return _then(_$PaginationFiltersModelResponseImpl(
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationFiltersModelResponseImpl
    implements _PaginationFiltersModelResponse {
  const _$PaginationFiltersModelResponseImpl({this.total});

  factory _$PaginationFiltersModelResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PaginationFiltersModelResponseImplFromJson(json);

  @override
  final int? total;

  @override
  String toString() {
    return 'PaginationFiltersModelResponse(total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationFiltersModelResponseImpl &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total);

  /// Create a copy of PaginationFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationFiltersModelResponseImplCopyWith<
          _$PaginationFiltersModelResponseImpl>
      get copyWith => __$$PaginationFiltersModelResponseImplCopyWithImpl<
          _$PaginationFiltersModelResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationFiltersModelResponseImplToJson(
      this,
    );
  }
}

abstract class _PaginationFiltersModelResponse
    implements PaginationFiltersModelResponse {
  const factory _PaginationFiltersModelResponse({final int? total}) =
      _$PaginationFiltersModelResponseImpl;

  factory _PaginationFiltersModelResponse.fromJson(Map<String, dynamic> json) =
      _$PaginationFiltersModelResponseImpl.fromJson;

  @override
  int? get total;

  /// Create a copy of PaginationFiltersModelResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationFiltersModelResponseImplCopyWith<
          _$PaginationFiltersModelResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
